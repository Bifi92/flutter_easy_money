import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:easy_money/dao/recebimentos_dao.dart';
import 'package:easy_money/models/recebimento.dart';
import 'package:rxdart/rxdart.dart';

RecebimentoBloc recebimentoBloc = RecebimentoBloc();

class RecebimentoBloc extends BlocBase {
  RecebimentosDao databaseHelper = RecebimentosDao();

  final _nome = BehaviorSubject<String>.seeded("");

  Stream<String> get outNome => _nome.stream;

  Sink<String> get inNome => _nome.sink;

  String get nomeValue => _nome.value;

  void salvaNome(String nome) {
    inNome.add(nome);
  }

  final _valor = BehaviorSubject<double>.seeded(0);

  Stream<double> get outValor => _valor.stream;

  Sink<double> get inValor => _valor.sink;

  double get valorValue => _valor.value;

  void salvaValor(double valor) {
    inValor.add(valor);
  }

  final _recebimento =
      BehaviorSubject<Recebimento>.seeded(Recebimento(0, "", 0));

  Stream<Recebimento> get outRecebimento => _recebimento.stream;

  Sink<Recebimento> get inRecebimento => _recebimento.sink;

  Recebimento get recebimentoValue => _recebimento.value;

  void salvaRecebimento(Recebimento recebimento) {
    inRecebimento.add(recebimento);
  }

  final _listRecebimento =
      BehaviorSubject<List<Recebimento>>.seeded(<Recebimento>[]);

  Stream<List<Recebimento>> get outList => _listRecebimento.stream;

  Sink<List<Recebimento>> get inList => _listRecebimento.sink;

  List<Recebimento> get listRecebimentoValue => _listRecebimento.value;

  void carregaLista() async {
    List<Recebimento> recebimentos = await databaseHelper.findAll();
    recebimentos.sort((a, b) {
      return a.nome.toLowerCase().compareTo(b.nome.toLowerCase());
    });
    _listRecebimento.value = recebimentos;
  }

  @override
  void dispose() {
    _nome.close();
    _valor.close();
    _recebimento.close();
    _listRecebimento.close();
  }
}
