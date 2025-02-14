import 'package:flutter/material.dart';
import '../models/planet.dart';

class PlanetDetailScreen extends StatelessWidget {
  final Planet planet;

  const PlanetDetailScreen({super.key, required this.planet});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(planet.nome)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Distância do Sol: ${planet.distancia} UA'),
            Text('Tamanho: ${planet.tamanho} km'),
            Text('Apelido: ${planet.apelido ?? "Sem apelido"}'),
          ],
        ),
      ),
    );
  }
}
