import 'package:easy_money/dao/recebimentos_dao.dart';
import 'package:easy_money/models/recebimento.dart';
import 'package:flutter/material.dart';

class RecebimentosFormWidget extends StatefulWidget {
  const RecebimentosFormWidget({Key? key}) : super(key: key);

  @override
  State<RecebimentosFormWidget> createState() => _RecebimentosFormWidgetState();
}

class _RecebimentosFormWidgetState extends State<RecebimentosFormWidget> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _nomeDoRecebimentoController =
        TextEditingController();
    final TextEditingController _valorRecebidoController =
        TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Novo recebimento')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _nomeDoRecebimentoController,
              decoration:
                  const InputDecoration(labelText: 'Nome do recebimento'),
              style: const TextStyle(fontSize: 24.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _valorRecebidoController,
              decoration: const InputDecoration(labelText: 'Valor recebido'),
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
                  final String _nomeDoRecebimento =
                      _nomeDoRecebimentoController.text;
                  final double? _valorRecebido =
                      double.tryParse(_valorRecebidoController.text);
                  if (_valorRecebido != null) {
                    final Recebimento newRecebimento =
                        Recebimento(0, _nomeDoRecebimento, _valorRecebido);
                    RecebimentosDao recebimentosDao = RecebimentosDao();

                    recebimentosDao
                        .insert(newRecebimento)
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
