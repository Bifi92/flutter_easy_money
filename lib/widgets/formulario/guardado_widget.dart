import 'package:easy_money/dao/guardado_dao.dart';
import 'package:easy_money/models/guardado.dart';
import 'package:flutter/material.dart';

class GuardadoFormWidget extends StatelessWidget {
  const GuardadoFormWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _nomeController = TextEditingController();
    final TextEditingController _valorController = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: const Text('Novo guardado')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _nomeController,
              decoration: const InputDecoration(labelText: 'Nome'),
              style: const TextStyle(fontSize: 24.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _valorController,
              decoration: const InputDecoration(labelText: 'Valor'),
              style: const TextStyle(fontSize: 24.0),
              keyboardType: TextInputType.number,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.maxFinite,
              child: ElevatedButton(
                onPressed: () {
                  final String _nome = _nomeController.text;
                  final double? _valor = double.tryParse(_valorController.text);
                  if (_valor != null) {
                    final Guardado newGuardado = Guardado(0, _nome, _valor);
                    GuardadoDao guardadoDao = GuardadoDao();

                    guardadoDao
                        .insert(newGuardado)
                        .then((id) => Navigator.pop(context));
                  }
                },
                child: const Text('Cadastrar'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
