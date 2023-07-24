import 'dart:io';

import 'package:comfort_zone_remake/models/character.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

// Database helper class provides sqlite methods
class SQLiteDatabaseHelper {
  final _dbName = 'comfort_zone.db';
  final _characterTable = 'characters';

  final _characterId = 'c_id';
  final _characterImage = 'image';
  final _characterName = 'name';
  final _characterDate = 'create_date';

  // Open database (or create one if it doesn't exist yet)
  Future<Database> _getDatabase() async {
    final dbPath =
        await sql.getDatabasesPath(); // Get default database path on device
    // print(dbPath);

    // Open database
    final db = await sql.openDatabase(
      path.join(dbPath, _dbName),
      onCreate: (db, version) {
        return db.execute("""CREATE TABLE $_characterTable(
            $_characterId TEXT PRIMARY KEY, 
            $_characterImage TEXT, 
            $_characterName TEXT, 
            $_characterDate TEXT
            )
            """);
      },
      version: 1,
    );

    return db;
  }

  // Helper function to copy an image from it's original storage place to the app's own storage space (to prevent losing it)
  Future<File> _copyImage(File image) async {
    final appDir = await syspaths
        .getApplicationDocumentsDirectory(); // Get directory to save user data to
    final filename =
        path.basename(image.path); // Get original name of the image file
    final copiedImage = await image
        .copy('${appDir.path}/${DateTime.now()}_$filename'); // Copy image to the app directory

    return copiedImage;
  }

  // Load character entries from database and return them as a list future
  Future<List<Character>> loadAllCharacters() async {
    final db = await _getDatabase();
    final data =
        await db.query(_characterTable); // Get all db entries as list of maps

    // Convert entries into list of characters
    final allCharacters = data
        .map(
          (rowItem) => Character(
            id: rowItem[_characterId] as String,
            image: File(rowItem[_characterImage] as String),
            name: rowItem[_characterName] as String,
            createDate: rowItem[_characterDate] as String,
          ),
        )
        .toList();

    return allCharacters;
  }

  Future<Character> loadOneCharacter(String id) async {
    final db = await _getDatabase();
    final data = await db
        .query(_characterTable, where: "$_characterId = ?", whereArgs: [id]);
    final currentMap = data[0];

    final currentCharacter = Character(
      id: currentMap[_characterId] as String,
      image: File(currentMap[_characterImage] as String),
      name: currentMap[_characterName] as String,
      createDate: currentMap[_characterDate] as String,
    );

    return currentCharacter;
  }

  // Add a new character to database and return it
  Future<Character> addCharacter(File image, String name) async {
    final copiedImage = await _copyImage(image);

    final newCharacter = Character(image: copiedImage, name: name);

    // Insert new character entry in database
    final db = await _getDatabase();
    db.insert(
      _characterTable,
      {
        _characterId: newCharacter.id,
        _characterImage: newCharacter.image.path,
        _characterName: newCharacter.name,
        _characterDate: newCharacter.createDate,
      },
    );

    return newCharacter;
  }

  // Update a character entry in the database
  Future<Character> updateCharacter(
      Character character, File image, String name) async {
    final copiedImage = await _copyImage(image);

    final updatedCharacter = Character(
      id: character.id,
      image: copiedImage,
      name: name,
      createDate: character.createDate,
    );

    final db = await _getDatabase();
    db.update(
      _characterTable,
      {
        _characterImage: updatedCharacter.image.path,
        _characterName: updatedCharacter.name,
      },
      where: "$_characterId = ?",
      whereArgs: [character.id],
    );

    // Delete old image from app storage
    if (await character.image.exists()) await character.image.delete();

    return updatedCharacter;
  }

  // Delete a character entry from the database
  Future<void> deleteCharacter(Character character) async {
    final db = await _getDatabase();
    db.delete(
      _characterTable,
      where: "$_characterId = ?",
      whereArgs: [character.id],
    );

    // Delete the image from the app storage
    if(await character.image.exists()) await character.image.delete();
  }
}
