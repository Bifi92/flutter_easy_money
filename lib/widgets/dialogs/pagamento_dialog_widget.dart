import 'package:easy_money/dao/pagamentos_dao.dart';
import 'package:easy_money/dao/recebimentos_dao.dart';
import 'package:easy_money/models/pagamento.dart';
import 'package:easy_money/models/recebimento.dart';
import 'package:flutter/material.dart';

class PagamentoDialogWidget {
  final Pagamento _pagamento;

  PagamentoDialogWidget(this._pagamento);

  AlertDialog montaDialog(BuildContext context) {
    PagamentosDao _dao = PagamentosDao();
    return AlertDialog(
      title: Text(
        'Pagamento: ${_pagamento.nome}',
        style: const TextStyle(fontSize: 24),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Valor: ${_pagamento.valor.toStringAsFixed(2)}'),
          CheckboxListTile(
            value: _pagamento.isPago,
            onChanged: null,
            title: const Text('Foi pago?'),
          )
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            _dao.delete(_pagamento).then((value) => Navigator.pop(context));
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
