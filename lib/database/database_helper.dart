import 'dart:io';

import 'package:comfort_zone_remake/models/character.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

// Database helper class provides sqlite methods
class SQLiteDatabaseHelper {
  String dbName = 'comfort_zone.db';
  String characterTable = 'characters';

  String characterId = 'c_id';
  String characterImage = 'image';
  String characterName = 'name';
  String characterDate = 'create_date';

  // Open database (or create one if it doesn't exist yet)
  Future<Database> _getDatabase() async {
    final dbPath = await sql.getDatabasesPath();
    print('Db path: $dbPath');
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

  // Load characters from database and return them
  Future<List<Character>> loadAllCharacters() async {
    final db = await _getDatabase();
    final data = await db.query(characterTable);
    final allCharacters = data
        .map(
          (rowItem) => Character(
            id: rowItem[characterId] as String,
            image: File(rowItem[characterImage] as String),
            name: rowItem[characterName] as String,
            createDate: rowItem[characterDate] as String,
          ),
        )
        .toList();

    return allCharacters;
  }

  // Add a new character to database and return it
  Future<Character> addCharacter(File image, String name) async {
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final filename = path.basename(image.path);
    final copiedImage = await image.copy('${appDir.path}/$filename');

    print('Appdir: $appDir, Filename: $filename');

    final newCharacter = Character(image: copiedImage, name: name);

    final db = await _getDatabase();
    db.insert(
      characterTable,
      {
        characterId: newCharacter.id,
        characterImage: newCharacter.image.path,
        characterName: newCharacter.name,
        characterDate: newCharacter.createDate,
      },
    );

    return newCharacter;
  }
}
