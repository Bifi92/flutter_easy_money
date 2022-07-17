import 'package:easy_money/dao/guardado_dao.dart';
import 'package:easy_money/dao/pagamentos_dao.dart';
import 'package:easy_money/dao/recebimentos_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class BaseDao {
  Future<Database> getDatabase() async {
    final String dbPath = await getDatabasesPath();
    final String path = join(dbPath, 'easy_money.db');
    return openDatabase(
      path,
      onCreate: (db, version) {
        db.execute(RecebimentosDao.tableSql);
        db.execute(GuardadoDao.tableSql);
        db.execute(PagamentosDao.tableSql);
      },
      version: 1,
      //onDowngrade: onDatabaseDowngradeDelete,
    );
  }
}
