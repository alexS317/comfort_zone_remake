import 'dart:io';

import 'package:comfort_zone_remake/models/affirmation.dart';
import 'package:comfort_zone_remake/models/character.dart';

import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

// Database helper class provides sqlite methods
class SQLiteDatabaseHelper {
  final _dbName = 'comfort_zone.db';
  final _characterTable = 'characters';
  final _affirmationTable = 'affirmations';

  final _characterId = 'c_id';
  final _characterImage = 'image';
  final _characterName = 'name';
  final _characterDate = 'create_date';

  final _affirmationId = 'a_id';
  final _affirmationText = 'text';

  // Open database (or create one if it doesn't exist yet)
  Future<Database> _getDatabase() async {
    final dbPath =
        await sql.getDatabasesPath(); // Get default database path on device

    // Open database
    final db = await sql.openDatabase(
      path.join(dbPath, _dbName),
      onCreate: (db, version) async {
        await db.execute("""CREATE TABLE IF NOT EXISTS $_characterTable(
            $_characterId TEXT PRIMARY KEY, 
            $_characterImage TEXT, 
            $_characterName TEXT, 
            $_characterDate TEXT
            )
            """);
        await db.execute("""CREATE TABLE IF NOT EXISTS $_affirmationTable(
              $_affirmationId TEXT PRIMARY KEY, 
              $_affirmationText TEXT
              )
              """);
      },
      version: 1,
    );

    return db;
  }

  // Helper function to copy an image from it's original storage place to the app's own storage space (to prevent losing it)
  Future<File> _copyImage(String id, File image) async {
    final appDir = await syspaths
        .getApplicationDocumentsDirectory(); // Get directory to save user data to
    final filename =
        path.basename(image.path); // Get original name of the image file
    final copiedImage = await image.copy(
        '${appDir.path}/${id}_$filename'); // Copy image to the app directory

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

  // Add a new character to database and return it
  Future<Character> addCharacter(File image, String name) async {
    final id =
        uuid.v4(); // Need to create id manually to use it as name for the image
    final copiedImage = await _copyImage(id, image);

    final newCharacter = Character(image: copiedImage, name: name, id: id);

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
    final copiedImage = await _copyImage(character.id, image);

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
    if (await character.image.exists()) await character.image.delete();
  }

  // Load affirmations from the database and convert them to a list
  Future<List<Affirmation>> loadAllAffirmations() async {
    final db = await _getDatabase();
    final data = await db.query(_affirmationTable);

    final allAffirmations = data
        .map(
          (rowItem) => Affirmation(
            id: rowItem[_affirmationId] as String,
            text: rowItem[_affirmationText] as String,
          ),
        )
        .toList();

    return allAffirmations;
  }

  // Add new affirmation
  Future<Affirmation> addAffirmation(String text) async {
    final newAffirmation = Affirmation(text: text);

    final db = await _getDatabase();
    db.insert(
      _affirmationTable,
      {
        _affirmationId: newAffirmation.id,
        _affirmationText: newAffirmation.text,
      },
    );

    return newAffirmation;
  }

  // Delete an affirmation
  Future<void> deleteAffirmation(Affirmation affirmation) async {
    final db = await _getDatabase();

    db.delete(
      _affirmationTable,
      where: "$_affirmationId = ?",
      whereArgs: [affirmation.id],
    );
  }
}
