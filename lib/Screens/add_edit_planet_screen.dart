import 'package:flutter/material.dart';
import '../models/planet.dart';
import '../database/database_helper.dart';

class AddEditPlanetScreen extends StatefulWidget {
  final Planet? planet;

  const AddEditPlanetScreen({super.key, this.planet});

  @override
  // ignore: library_private_types_in_public_api
  _AddEditPlanetScreenState createState() => _AddEditPlanetScreenState();
}

class _AddEditPlanetScreenState extends State<AddEditPlanetScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _distanceController;
  late TextEditingController _sizeController;
  late TextEditingController _nicknameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.planet?.nome ?? '');
    _distanceController = TextEditingController(text: widget.planet?.distancia.toString() ?? '');
    _sizeController = TextEditingController(text: widget.planet?.tamanho.toString() ?? '');
    _nicknameController = TextEditingController(text: widget.planet?.apelido ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _distanceController.dispose();
    _sizeController.dispose();
    _nicknameController.dispose();
    super.dispose();
  }

  void _savePlanet() async {
    if (_formKey.currentState!.validate()) {
      final planet = Planet(
        id: widget.planet?.id,
        nome: _nameController.text,
        distancia: double.parse(_distanceController.text),
        tamanho: double.parse(_sizeController.text),
        apelido: _nicknameController.text.isEmpty ? null : _nicknameController.text,
      );

      if (widget.planet == null) {
        await DatabaseHelper.instance.createPlanet(planet);
      } else {
        await DatabaseHelper.instance.updatePlanet(planet);
      }

      // ignore: use_build_context_synchronously
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.planet == null ? 'Adicionar Planeta' : 'Editar Planeta')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nome do Planeta'),
                validator: (value) => value == null || value.isEmpty ? 'Campo obrigatório' : null,
              ),
              TextFormField(
                controller: _distanceController,
                decoration: const InputDecoration(labelText: 'Distância do Sol (UA)'),
                keyboardType: TextInputType.number,
                validator: (value) => value == null || value.isEmpty || double.tryParse(value) == null
                    ? 'Informe um valor válido'
                    : null,
              ),
              TextFormField(
                controller: _sizeController,
                decoration: const InputDecoration(labelText: 'Tamanho (km)'),
                keyboardType: TextInputType.number,
                validator: (value) => value == null || value.isEmpty || double.tryParse(value) == null
                    ? 'Informe um valor válido'
                    : null,
              ),
              TextFormField(
                controller: _nicknameController,
                decoration: const InputDecoration(labelText: 'Apelido (Opcional)'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _savePlanet,
                child: Text(widget.planet == null ? 'Adicionar' : 'Salvar Alterações'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
