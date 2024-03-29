import 'dart:io';

import 'package:comfort_zone_remake/database/database_helper.dart';
import 'package:comfort_zone_remake/models/character.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class CharactersNotifier extends StateNotifier<List<Character>> {
  CharactersNotifier() : super(const []);

  // Load characters from database
  Future<void> loadCharacters() async {
    final characters = await SQLiteDatabaseHelper().loadAllCharacters();

    state = characters;
  }

  // Add new character entry
  void addCharacter(File image, String name) async {
    final newCharacter = await SQLiteDatabaseHelper().addCharacter(image, name);

    // Spread elements of the old state and add new element at the end
    state = [...state, newCharacter];
  }

  // Update existing character entry
  void updateCharacter(Character character, File image, String name) async {
    // Spread elements of the old state (assign them individually)
    final charactersList = [...state];
    
    // Search the current character based on id
    final currentCharacter =
        charactersList.where((element) => element.id == character.id).toList();
    final currentIndex = charactersList.indexOf(currentCharacter[0]);

    final updatedCharacter =
        await SQLiteDatabaseHelper().updateCharacter(character, image, name);
    charactersList[currentIndex] = updatedCharacter;

    state = charactersList;
  }

  // Delete a character entry
  void deleteCharacter(Character character) async {
    // Spread elements of the old state (assign them individually)
    final charactersList = [...state];

    await SQLiteDatabaseHelper().deleteCharacter(character);
    charactersList.remove(character);

    state = charactersList;
  }
}

final charactersProvider =
    StateNotifierProvider<CharactersNotifier, List<Character>>(
  (ref) => CharactersNotifier(),
);
