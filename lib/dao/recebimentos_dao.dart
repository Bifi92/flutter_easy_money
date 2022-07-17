import 'package:easy_money/dao/base_dao.dart';
import 'package:easy_money/models/recebimento.dart';
import 'package:sqflite/sqlite_api.dart';

class RecebimentosDao {
  static const _tableName = 'recebimentos';
  static const _id = 'id';
  static const _nome = 'nome';
  static const _valor = 'valor';

  static const String tableSql = 'CREATE TABLE $_tableName ('
      '$_id INTEGER PRIMARY KEY, '
      '$_nome TEXT, '
      '$_valor REAL )';

  Future<int> delete(Recebimento recebimento) async {
    final Database db = await BaseDao().getDatabase();
    return db.delete(
      _tableName,
      where: 'id=?',
      whereArgs: [recebimento.id],
    );
  }

  Future<int> insert(Recebimento recebimento) async {
    final Database db = await BaseDao().getDatabase();
    Map<String, dynamic> recebimentoMap = _toMap(recebimento);
    return db.insert(_tableName, recebimentoMap);
  }

  Future<List<Recebimento>> findAll() async {
    final Database db = await BaseDao().getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableName);
    List<Recebimento> recebimentos = _toList(result);
    return recebimentos;
  }

  Future<double> getTotalRecebimentos() async {
    List<Recebimento> listaCompleta = await findAll();
    double total = 0;
    for (var recebimento in listaCompleta) {
      total = total + recebimento.valor;
    }

    return total;
  }

  Map<String, Object?> _toMap(Recebimento recebimento) {
    final Map<String, dynamic> map = {};
    map[_nome] = recebimento.nome;
    map[_valor] = recebimento.valor;
    return map;
  }

  List<Recebimento> _toList(List<Map<String, dynamic>> result) {
    final List<Recebimento> recebimentos = [];
    for (Map<String, dynamic> map in result) {
      final Recebimento recebimento = Recebimento(
        map[_id],
        map[_nome],
        map[_valor],
      );
      recebimentos.add(recebimento);
    }
    return recebimentos;
  }
}
