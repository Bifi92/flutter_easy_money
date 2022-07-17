import 'package:easy_money/bloc/pagamento_bloc.dart';
import 'package:easy_money/dao/pagamentos_dao.dart';
import 'package:easy_money/models/pagamento.dart';
import 'package:easy_money/widgets/dialogs/pagamento_dialog_widget.dart';
import 'package:easy_money/widgets/formulario/pagamentos_widget.dart';
import 'package:flutter/material.dart';

class PagamentosListaWidget extends StatefulWidget {
  const PagamentosListaWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<PagamentosListaWidget> createState() => _PagamentosListaWidgetState();
}

class _PagamentosListaWidgetState extends State<PagamentosListaWidget> {
  PagamentosDao pagamentosDao = PagamentosDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<String>(
          initialData: "",
          future: pagamentosDao.getTotais(),
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
                  '${snapshot.data}',
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
                  builder: (context) => const PagamentosFormWidget(),
                ),
              )
              .then((value) => setState(() {}));
        },
      ),
      body: StreamBuilder(
        stream: pagamentoBloc.outList,
        initialData: pagamentoBloc.listPagamentoValue,
        builder:
            (BuildContext context, AsyncSnapshot<List<Pagamento>> snapshot) {
          pagamentoBloc.carregaLista();
          if (snapshot.hasData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                PagamentoDialogWidget dialog =
                    PagamentoDialogWidget(snapshot.data!.elementAt(index));
                return GestureDetector(
                  onLongPress: () {
                    showDialog(
                            context: context,
                            builder: (context) => dialog.montaDialog(context))
                        .then((value) {
                      setState(() {});
                    });
                  },
                  child: CheckboxListTile(
                    title: Text(snapshot.data!.elementAt(index).nome),
                    subtitle:
                        Text(snapshot.data!.elementAt(index).valor.toString()),
                    onChanged: (bool? value) {
                      setState(() {
                        debugPrint('Passou pelo SetState do checkbox. $value');
                        snapshot.data!.elementAt(index).isPago = value!;
                        pagamentosDao.edit(snapshot.data!.elementAt(index));
                      });
                    },
                    value: snapshot.data!.elementAt(index).isPago,
                  ),
                );
              },
              itemCount: snapshot.data!.length,
            );
          } else {
            return Container();
          }
        },
      ),
      // body: FutureBuilder<List<Pagamento>>(
      //   initialData: const [],
      //   future: pagamentosDao.findAll(),
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
      //           List<Pagamento> pagamentos = snapshot.data as List<Pagamento>;
      //           return ListView.builder(
      //             itemBuilder: (context, index) {
      //               PagamentoDialogWidget dialog =
      //                   PagamentoDialogWidget(pagamentos[index]);
      //               return GestureDetector(
      //                 onLongPress: () {
      //                   showDialog(
      //                       context: context,
      //                       builder: (context) =>
      //                           dialog.montaDialog(context)).then((value) {
      //                     setState(() {});
      //                   });
      //                 },
      //                 child: CheckboxListTile(
      //                   title: Text(pagamentos[index].nome),
      //                   subtitle: Text(pagamentos[index].valor.toString()),
      //                   onChanged: (bool? value) {
      //                     setState(() {
      //                       debugPrint(
      //                           'Passou pelo SetState do checkbox. $value');
      //                       pagamentos[index].isPago = value!;
      //                       pagamentosDao.edit(pagamentos[index]);
      //                     });
      //                   },
      //                   value: pagamentos[index].isPago,
      //                 ),
      //               );
      //             },
      //             itemCount: pagamentos.length,
      //           );
      //         }
      //     }
      //     return const Text('Nenhum recebimento cadastrado.');
      //   },
      // ),
    );
  }
}
