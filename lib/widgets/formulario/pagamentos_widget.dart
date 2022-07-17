import 'package:easy_money/dao/pagamentos_dao.dart';
import 'package:easy_money/models/pagamento.dart';
import 'package:flutter/material.dart';

class PagamentosFormWidget extends StatelessWidget {
  const PagamentosFormWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _nomeDaContaController =
        TextEditingController();
    final TextEditingController _valorDaContaController =
        TextEditingController();
    return Scaffold(
      appBar: AppBar(title: const Text('Novo pagamento')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _nomeDaContaController,
              decoration: const InputDecoration(labelText: 'Nome da conta'),
              style: const TextStyle(fontSize: 24.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _valorDaContaController,
              decoration: const InputDecoration(labelText: 'Valor da conta'),
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
                  final String _nomeDaConta = _nomeDaContaController.text;
                  final double? _valorDaConta =
                      double.tryParse(_valorDaContaController.text);
                  if (_valorDaConta != null) {
                    final Pagamento newPagamento =
                        Pagamento(0, _nomeDaConta, _valorDaConta, false);
                    PagamentosDao pagamentosDao = PagamentosDao();

                    pagamentosDao
                        .insert(newPagamento)
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
