import 'package:easy_money/dao/base_dao.dart';
import 'package:easy_money/models/pagamento.dart';
import 'package:sqflite/sqflite.dart';

class PagamentosDao {
  static const _tableName = 'pagamentos';
  static const _id = 'id';
  static const _nome = 'nome';
  static const _valor = 'valor';
  static const _isPago = 'isPago';

  static const String tableSql = 'CREATE TABLE $_tableName ('
      '$_id INTEGER PRIMARY KEY, '
      '$_nome TEXT, '
      '$_valor REAL, '
      '$_isPago INTEGER )';

  Future<int> delete(Pagamento pagamento) async {
    final Database db = await BaseDao().getDatabase();
    return db.delete(
      _tableName,
      where: 'id=?',
      whereArgs: [pagamento.id],
    );
  }

  Future<int> insert(Pagamento pagamento) async {
    final Database db = await BaseDao().getDatabase();
    Map<String, dynamic> pagamentoMap = _toMap(pagamento);
    return db.insert(_tableName, pagamentoMap);
  }

  Future<List<Pagamento>> findAll() async {
    final Database db = await BaseDao().getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableName);
    List<Pagamento> pagamentos = _toList(result);
    return pagamentos;
  }

  edit(Pagamento pagamento) async {
    final Database db = await BaseDao().getDatabase();
    Map<String, dynamic> pagamentoMap = _toMap(pagamento);
    db.update(_tableName, pagamentoMap,
        where: 'id=?', whereArgs: [pagamento.id]);
  }

  Future<double> getTotalPagamentos() async {
    List<Pagamento> listaCompleta = await findAll();
    double total = 0;
    for (var pagamento in listaCompleta) {
      total = total + pagamento.valor;
    }

    return total;
  }

  Future<double> getTotalPagos() async {
    List<Pagamento> listaCompleta = await findAll();
    double total = 0;
    for (var pagamento in listaCompleta) {
      if (pagamento.isPago) {
        total = total + pagamento.valor;
      }
    }

    return total;
  }

  Future<double> getTotalNaoPagos() async {
    List<Pagamento> listaCompleta = await findAll();
    double total = 0;
    for (var pagamento in listaCompleta) {
      if (!pagamento.isPago) {
        total = total + pagamento.valor;
      }
    }

    return total;
  }

  Future<String> getTotais() async {
    double total = await getTotalPagamentos();
    double totalPago = await getTotalPagos();
    double totalNaoPago = await getTotalNaoPagos();
    return '${totalPago.toStringAsFixed(2)} + ${totalNaoPago.toStringAsFixed(2)} = ${total.toStringAsFixed(2)}';
  }

  Map<String, Object?> _toMap(Pagamento pagamento) {
    final Map<String, dynamic> map = {};
    map[_nome] = pagamento.nome;
    map[_valor] = pagamento.valor;
    map[_isPago] = pagamento.isPago ? 1 : 0;
    return map;
  }

  List<Pagamento> _toList(List<Map<String, dynamic>> result) {
    final List<Pagamento> pagamentos = [];
    for (Map<String, dynamic> map in result) {
      final Pagamento pagamento = Pagamento(
        map[_id],
        map[_nome],
        map[_valor],
        map[_isPago] == 1 ? true : false,
      );
      pagamentos.add(pagamento);
    }
    return pagamentos;
  }
}
