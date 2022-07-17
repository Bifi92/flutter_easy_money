import 'package:easy_money/dao/balanco_dao.dart';
import 'package:easy_money/models/balanco.dart';
import 'package:flutter/material.dart';

class BalancoListaWidget extends StatefulWidget {
  const BalancoListaWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<BalancoListaWidget> createState() => _BalancoListaWidgetState();
}

class _BalancoListaWidgetState extends State<BalancoListaWidget> {
  BalancoDao balancoDao = BalancoDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Balanço')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: Card(
                      color: Colors.red,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Total pago:',
                            style: TextStyle(
                              fontSize: 32,
                            ),
                          ),
                          FutureBuilder<double>(
                            initialData: 0,
                            future: balancoDao.getTotalPago(),
                            builder: (context, snapshot) {
                              switch (snapshot.connectionState) {
                                case ConnectionState.none:
                                  break;
                                case ConnectionState.waiting:
                                  return const Text(
                                    'Calculando...',
                                    style: TextStyle(fontSize: 16),
                                  );
                                case ConnectionState.active:
                                  break;
                                case ConnectionState.done:
                                  return Text(
                                    '${snapshot.data?.toStringAsFixed(2)}',
                                    style: const TextStyle(fontSize: 16),
                                  );
                              }
                              return const Text('Unknown error!');
                            },
                          )
                        ],
                      ),
                      elevation: 2,
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Card(
                      color: Colors.blue,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Total recebido:',
                            style: TextStyle(
                              fontSize: 24,
                            ),
                          ),
                          FutureBuilder<double>(
                            initialData: 0,
                            future: balancoDao.getTotalRecebido(),
                            builder: (context, snapshot) {
                              switch (snapshot.connectionState) {
                                case ConnectionState.none:
                                  break;
                                case ConnectionState.waiting:
                                  return const Text(
                                    'Calculando...',
                                    style: TextStyle(fontSize: 16),
                                  );
                                case ConnectionState.active:
                                  break;
                                case ConnectionState.done:
                                  return Text(
                                    '${snapshot.data?.toStringAsFixed(2)}',
                                    style: const TextStyle(fontSize: 16),
                                  );
                              }
                              return const Text('Unknown error!');
                            },
                          )
                        ],
                      ),
                      elevation: 2,
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: SizedBox(
                width: double.maxFinite,
                child: Card(
                  color: Colors.green,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Total Sobra:',
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                      FutureBuilder<double>(
                        initialData: 0,
                        future: balancoDao.getTotalSobra(),
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.none:
                              break;
                            case ConnectionState.waiting:
                              return const Text(
                                'Calculando...',
                                style: TextStyle(fontSize: 16),
                              );
                            case ConnectionState.active:
                              break;
                            case ConnectionState.done:
                              return Text(
                                '${snapshot.data?.toStringAsFixed(2)}',
                                style: const TextStyle(fontSize: 16),
                              );
                          }
                          return const Text('Unknown error!');
                        },
                      )
                    ],
                  ),
                  elevation: 2,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
