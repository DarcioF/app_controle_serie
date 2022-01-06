import 'package:app_controle_serie/database/dao/serie_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'series.db');
  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(SerieDao.tableSql);
    },
    version: 1,
    //onDowngrade: onDatabaseDowngradeDelete
  );
}
