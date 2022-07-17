import 'package:easy_money/dao/guardado_dao.dart';
import 'package:easy_money/models/guardado.dart';
import 'package:flutter/material.dart';

class GuardadoDialogWidget {
  final Guardado _guardado;

  GuardadoDialogWidget(this._guardado);

  AlertDialog montaDialog(BuildContext context) {
    GuardadoDao _dao = GuardadoDao();
    return AlertDialog(
      title: Text(
        'Guardado: ${_guardado.nome}',
        style: const TextStyle(fontSize: 24),
      ),
      content: Text('Valor: ${_guardado.valor.toStringAsFixed(2)}'),
      actions: [
        TextButton(
          onPressed: () {
            _dao.delete(_guardado).then((value) => Navigator.pop(context));
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
