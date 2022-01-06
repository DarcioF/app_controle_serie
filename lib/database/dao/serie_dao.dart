import 'package:app_controle_serie/database/app_database.dart';
import 'package:app_controle_serie/models/serie.dart';
import 'package:sqflite/sqflite.dart';

class SerieDao {
  static const String tableSql = 'CREATE TABLE serie('
      'id INTEGER PRIMARY KEY, '
      'nome TEXT, '
      'numero_epsodio INTEGER, '
      'numero_temporada INTEGER)';

  Future<int> save(Serie serie) async {
    final Database db = await getDatabase();
    return db.insert('serie', _toMap(serie));
  }

  Map<String, dynamic> _toMap(Serie serie) {
    final Map<String, dynamic> serieMap = Map();
    serieMap['nome'] = serie.nome;
    serieMap['numero_epsodio'] = serie.numero_epsodio;
    serieMap['numero_temporada'] = serie.numero_epsodio;
    return serieMap;
  }

  Future<void> update(Serie serie) async {
    final db = await getDatabase();
    await db.update(
      'serie',
      serie.toMap(),
      where: 'id = ?',
      whereArgs: [serie.id],
    );
  }

  Future<void> delete(int id) async {
    final db = await getDatabase();
    await db.delete(
      'serie',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Serie>> findAll() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query('serie');
    return _toList(result);
  }

  List<Serie> _toList(List<Map<String, dynamic>> result) {
    final List<Serie> seriesList = [];
    for (Map<String, dynamic> row in result) {
      final Serie serie = Serie(
        row['id'],
        row['nome'],
        row['numero_epsodio'],
        row['numero_temporada'],
      );
      seriesList.add(serie);
    }
    return seriesList;
  }
}
