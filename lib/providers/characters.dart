import 'dart:io';

import 'package:comfort_zone_remake/database/database_helper.dart';
import 'package:comfort_zone_remake/models/character.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CharactersNotifier extends StateNotifier<List<Character>> {
  CharactersNotifier() : super(const []);

  // Load character entries from database
  Future<void> loadCharacters() async {
    final characters = await SQLiteDatabaseHelper().loadAllCharacters();

    state = characters;
  }

  // Add new character entry
  void addCharacter(File image, String name) async {
    final newCharacter = await SQLiteDatabaseHelper().addCharacter(image, name);

    state = [...state, newCharacter];
  }
}

final charactersProvider =
    StateNotifierProvider<CharactersNotifier, List<Character>>(
  (ref) => CharactersNotifier(),
);
