import 'package:easy_money/bloc/guardado_bloc.dart';
import 'package:easy_money/bloc/recebimento_bloc.dart';
import 'package:easy_money/dao/recebimentos_dao.dart';
import 'package:easy_money/models/recebimento.dart';
import 'package:easy_money/widgets/dialogs/recebimento_dialog_widget.dart';
import 'package:easy_money/widgets/formulario/recebimentos_widget.dart';
import 'package:flutter/material.dart';

class RecebimentosListaWidget extends StatefulWidget {
  const RecebimentosListaWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<RecebimentosListaWidget> createState() =>
      _RecebimentosListaWidgetState();
}

class _RecebimentosListaWidgetState extends State<RecebimentosListaWidget> {
  RecebimentosDao recebimentosDao = RecebimentosDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<double>(
          initialData: 0,
          future: recebimentosDao.getTotalRecebimentos(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                break;
              case ConnectionState.waiting:
                return const Text(
                  'Total: Calculando...',
                  style: TextStyle(fontSize: 16),
                );
              case ConnectionState.active:
                break;
              case ConnectionState.done:
                return Text(
                  'Total: ${snapshot.data?.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 16),
                );
            }
            return const Text('Unknown error!');
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context)
              .push(
                MaterialPageRoute(
                  builder: (context) => const RecebimentosFormWidget(),
                ),
              )
              .then((value) => setState(() {}));
        },
      ),
      body: StreamBuilder(
        stream: recebimentoBloc.outList,
        initialData: recebimentoBloc.listRecebimentoValue,
        builder:
            (BuildContext context, AsyncSnapshot<List<Recebimento>> snapshot) {
          recebimentoBloc.carregaLista();
          if (snapshot.hasData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final Recebimento recebimento = snapshot.data!.elementAt(index);
                RecebimentoDialogWidget dialog =
                    RecebimentoDialogWidget(recebimento);
                return ListTile(
                  onLongPress: () {
                    showDialog(
                            context: context,
                            builder: (context) => dialog.montaDialog(context))
                        .then((value) {
                      setState(() {});
                    });
                  },
                  title: Text(recebimento.nome),
                  subtitle: Text(recebimento.valor.toString()),
                );
              },
              itemCount: snapshot.data!.length,
            );
          } else {
            return Container();
          }
        },
      ),
      // body: FutureBuilder<List<Recebimento>>(
      //   future: recebimentosDao.findAll(),
      //   initialData: const [],
      //   builder: (context, snapshot) {
      //     switch (snapshot.connectionState) {
      //       case ConnectionState.none:
      //         break;
      //       case ConnectionState.waiting:
      //         return Center(
      //           child: Column(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             crossAxisAlignment: CrossAxisAlignment.center,
      //             children: const [
      //               CircularProgressIndicator(),
      //               Text('Carregando...'),
      //             ],
      //           ),
      //         );
      //       case ConnectionState.active:
      //         break;
      //       case ConnectionState.done:
      //         if (snapshot.hasData) {
      //           List<Recebimento> recebimentos =
      //               snapshot.data as List<Recebimento>;
      //           return ListView.builder(
      //             itemBuilder: (context, index) {
      //               final Recebimento recebimento = recebimentos[index];
      //               RecebimentoDialogWidget dialog =
      //                   RecebimentoDialogWidget(recebimento);
      //               return ListTile(
      //                 onLongPress: () {
      //                   showDialog(
      //                       context: context,
      //                       builder: (context) =>
      //                           dialog.montaDialog(context)).then((value) {
      //                     setState(() {});
      //                   });
      //                 },
      //                 title: Text(recebimento.nome),
      //                 subtitle: Text(recebimento.valor.toString()),
      //               );
      //             },
      //             itemCount: recebimentos.length,
      //           );
      //         }
      //     }
      //     return const Text('Nenhum recebimento cadastrado.');
      //   },
      // ),
    );
  }
}
