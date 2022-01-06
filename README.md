# Aplicativo controle de Série/Anime

Projeto simples de controle de Episodio de Série/Anime com Persistência sqflite utilizando Flutter

## Documentação

- https://docs.flutter.dev/

## Dependência

- sqflite 2.0.1
- path 1.8.1

## Configuração do Banco de Dados

```dart
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
```

```dart

static const String tableSql = 'CREATE TABLE serie('
    'id INTEGER PRIMARY KEY, '
    'nome TEXT, '
    'numero_epsodio INTEGER, '
    'numero_temporada INTEGER)';
```

```dart
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
```