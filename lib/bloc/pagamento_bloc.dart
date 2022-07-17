import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:easy_money/dao/pagamentos_dao.dart';
import 'package:easy_money/models/pagamento.dart';
import 'package:rxdart/rxdart.dart';

PagamentoBloc pagamentoBloc = PagamentoBloc();

class PagamentoBloc extends BlocBase {
  PagamentosDao databaseHelper = PagamentosDao();

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

  final _isPago = BehaviorSubject<bool>.seeded(false);

  Stream<bool> get outIsPago => _isPago.stream;

  Sink<bool> get inIsPago => _isPago.sink;

  bool get isPagoValue => _isPago.value;

  void salvaIsPago(bool isPago) {
    inIsPago.add(isPago);
  }

  final _pagamento =
      BehaviorSubject<Pagamento>.seeded(Pagamento(0, "", 0, false));

  Stream<Pagamento> get outPagamento => _pagamento.stream;

  Sink<Pagamento> get inPagamento => _pagamento.sink;

  Pagamento get pagamentoValue => _pagamento.value;

  void salvaPagamento(Pagamento pagamento) {
    inPagamento.add(pagamento);
  }

  final _listPagamento = BehaviorSubject<List<Pagamento>>.seeded(<Pagamento>[]);

  Stream<List<Pagamento>> get outList => _listPagamento.stream;

  Sink<List<Pagamento>> get inList => _listPagamento.sink;

  List<Pagamento> get listPagamentoValue => _listPagamento.value;

  void carregaLista() async {
    List<Pagamento> pagamentos = await databaseHelper.findAll();
    pagamentos.sort((a, b) {
      return a.nome.toLowerCase().compareTo(b.nome.toLowerCase());
    });
    _listPagamento.value = pagamentos;
  }

  @override
  void dispose() {
    _nome.close();
    _valor.close();
    _pagamento.close();
    _listPagamento.close();
  }
}
