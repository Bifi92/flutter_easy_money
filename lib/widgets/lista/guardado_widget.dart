import 'package:easy_money/bloc/guardado_bloc.dart';
import 'package:easy_money/dao/guardado_dao.dart';
import 'package:easy_money/models/guardado.dart';
import 'package:easy_money/widgets/dialogs/guardado_dialog_widget.dart';
import 'package:easy_money/widgets/formulario/guardado_widget.dart';
import 'package:flutter/material.dart';

class GuardadoListaWidget extends StatefulWidget {
  const GuardadoListaWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<GuardadoListaWidget> createState() => _GuardadoListaWidgetState();
}

class _GuardadoListaWidgetState extends State<GuardadoListaWidget> {
  GuardadoDao guardadoDao = GuardadoDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<double>(
          initialData: 0,
          future: guardadoDao.getTotalGuardado(),
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
                  builder: (context) => const GuardadoFormWidget(),
                ),
              )
              .then((value) => setState(() {}));
        },
      ),
      body: StreamBuilder(
        stream: guardadoBloc.outList,
        initialData: guardadoBloc.listGuardadoValue,
        builder:
            (BuildContext context, AsyncSnapshot<List<Guardado>> snapshot) {
          guardadoBloc.carregaLista();
          if (snapshot.hasData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final Guardado guardado = snapshot.data!.elementAt(index);
                GuardadoDialogWidget dialog = GuardadoDialogWidget(guardado);
                return ListTile(
                  onLongPress: () {
                    showDialog(
                            context: context,
                            builder: (context) => dialog.montaDialog(context))
                        .then((value) {
                      setState(() {});
                    });
                  },
                  title: Text(guardado.nome),
                  subtitle: Text(guardado.valor.toString()),
                );
              },
              itemCount: snapshot.data!.length,
            );
          } else {
            return Container();
          }
        },
      ),
      // body: FutureBuilder<List<Guardado>>(
      //   initialData: const [],
      //   future: guardadoDao.findAll(),
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
      //           List<Guardado> guardados = snapshot.data as List<Guardado>;
      //           return ListView.builder(
      //             itemBuilder: (context, index) {
      //               final Guardado guardado = guardados[index];
      //               GuardadoDialogWidget dialog =
      //                   GuardadoDialogWidget(guardado);
      //               return ListTile(
      //                 onLongPress: () {
      //                   showDialog(
      //                       context: context,
      //                       builder: (context) =>
      //                           dialog.montaDialog(context)).then((value) {
      //                     setState(() {});
      //                   });
      //                 },
      //                 title: Text(guardado.nome),
      //                 subtitle: Text(guardado.valor.toString()),
      //               );
      //             },
      //             itemCount: guardados.length,
      //           );
      //         }
      //     }
      //     return const Text('Nenhum recebimento cadastrado.');
      //   },
      // ),
    );
  }
}
