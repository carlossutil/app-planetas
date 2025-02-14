import 'package:flutter/material.dart';
import '../models/planet.dart';
import '../database/database_helper.dart';
import 'add_edit_planet_screen.dart';
import 'planet_detail_screen.dart';

class PlanetListScreen extends StatefulWidget {
  const PlanetListScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PlanetListScreenState createState() => _PlanetListScreenState();
}

class _PlanetListScreenState extends State<PlanetListScreen> {
  late Future<List<Planet>> _planetList;

  @override
  void initState() {
    super.initState();
    _loadPlanets();
  }

  void _loadPlanets() {
    setState(() {
      _planetList = DatabaseHelper.instance.getPlanets();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Planetas')),
      body: FutureBuilder<List<Planet>>(
        future: _planetList,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              Planet planet = snapshot.data![index];
              return ListTile(
                title: Text(planet.nome),
                subtitle: Text(planet.apelido ?? 'Sem apelido'),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PlanetDetailScreen(planet: planet),
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddEditPlanetScreen(planet: planet),
                          ),
                        );
                        _loadPlanets();
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () async {
                        await DatabaseHelper.instance.deletePlanet(planet.id!);
                        _loadPlanets();
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddEditPlanetScreen(),
            ),
          );
          _loadPlanets();
        },
      ),
    );
  }
}
