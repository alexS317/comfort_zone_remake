import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

String dbName = 'comfort_zone.db';
String characterTable = 'characters';

String characterId = 'c_id';
String characterImage = 'image';
String characterName = 'name';
String characterDate = 'create_date';

Future<Database> _getDatabase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
    path.join(dbPath, dbName),
    onCreate: (db, version) {
      return db.execute("""CREATE TABLE $characterTable(
            $characterId TEXT PRIMARY KEY, 
            $characterImage TEXT, 
            $characterName TEXT, 
            $characterDate TEXT
            )
            """);
    },
    version: 1,
  );

  return db;
}
