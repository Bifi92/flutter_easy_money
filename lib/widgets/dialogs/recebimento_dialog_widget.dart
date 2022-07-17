import 'package:easy_money/dao/recebimentos_dao.dart';
import 'package:easy_money/models/recebimento.dart';
import 'package:flutter/material.dart';

class RecebimentoDialogWidget {
  final Recebimento _recebimento;

  RecebimentoDialogWidget(this._recebimento);

  AlertDialog montaDialog(BuildContext context) {
    RecebimentosDao _dao = RecebimentosDao();
    return AlertDialog(
      title: Text(
        'Recebimento: ${_recebimento.nome}',
        style: const TextStyle(fontSize: 24),
      ),
      content: Text('Valor: ${_recebimento.valor.toStringAsFixed(2)}'),
      actions: [
        TextButton(
          onPressed: () {
            _dao.delete(_recebimento).then((value) => Navigator.pop(context));
          },
          child: const Text('Deletar'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Voltar'),
        )
      ],
    );
  }
}
