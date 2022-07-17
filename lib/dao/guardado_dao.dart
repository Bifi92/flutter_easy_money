import 'package:easy_money/dao/base_dao.dart';
import 'package:easy_money/models/guardado.dart';
import 'package:sqflite/sqflite.dart';

class GuardadoDao {
  static const _tableName = 'guardado';
  static const _id = 'id';
  static const _nome = 'nome';
  static const _valor = 'valor';

  static const String tableSql = 'CREATE TABLE $_tableName ('
      '$_id INTEGER PRIMARY KEY, '
      '$_nome TEXT, '
      '$_valor REAL )';

  Future<int> delete(Guardado guardado) async {
    final Database db = await BaseDao().getDatabase();
    return db.delete(
      _tableName,
      where: 'id=?',
      whereArgs: [guardado.id],
    );
  }

  Future<int> insert(Guardado guardado) async {
    final Database db = await BaseDao().getDatabase();
    Map<String, dynamic> recebimentoMap = _toMap(guardado);
    return db.insert(_tableName, recebimentoMap);
  }

  Future<List<Guardado>> findAll() async {
    final Database db = await BaseDao().getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableName);
    List<Guardado> contacts = _toList(result);
    return contacts;
  }

  Future<double> getTotalGuardado() async {
    List<Guardado> listaCompleta = await findAll();
    double total = 0;
    for (var guardado in listaCompleta) {
      total = total + guardado.valor;
    }

    return total;
  }

  Map<String, Object?> _toMap(Guardado guardado) {
    final Map<String, dynamic> map = {};
    map[_nome] = guardado.nome;
    map[_valor] = guardado.valor;
    return map;
  }

  List<Guardado> _toList(List<Map<String, dynamic>> result) {
    final List<Guardado> guardados = [];
    for (Map<String, dynamic> map in result) {
      final Guardado guardado = Guardado(
        map[_id],
        map[_nome],
        map[_valor],
      );
      guardados.add(guardado);
    }
    return guardados;
  }
}
