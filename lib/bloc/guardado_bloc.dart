import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:easy_money/dao/guardado_dao.dart';
import 'package:easy_money/models/guardado.dart';
import 'package:rxdart/rxdart.dart';

GuardadoBloc guardadoBloc = GuardadoBloc();

class GuardadoBloc extends BlocBase {
  GuardadoDao databaseHelper = GuardadoDao();

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

  final _guardado = BehaviorSubject<Guardado>.seeded(Guardado(0, "", 0));

  Stream<Guardado> get outGuardado => _guardado.stream;

  Sink<Guardado> get inGuardado => _guardado.sink;

  Guardado get guardadoValue => _guardado.value;

  void salvaGuardado(Guardado guardado) {
    inGuardado.add(guardado);
  }

  final _listGuardado = BehaviorSubject<List<Guardado>>.seeded(<Guardado>[]);

  Stream<List<Guardado>> get outList => _listGuardado.stream;

  Sink<List<Guardado>> get inList => _listGuardado.sink;

  List<Guardado> get listGuardadoValue => _listGuardado.value;

  void carregaLista() async {
    List<Guardado> guardados = await databaseHelper.findAll();
    guardados.sort((a, b) {
      return a.nome.toLowerCase().compareTo(b.nome.toLowerCase());
    });
    _listGuardado.value = guardados;
  }

  @override
  void dispose() {
    _nome.close();
    _valor.close();
    _guardado.close();
    _listGuardado.close();
  }
}
