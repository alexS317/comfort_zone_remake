import 'dart:io';

import 'package:comfort_zone_remake/models/character.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CharactersNotifier extends StateNotifier<List<Character>> {
  CharactersNotifier() : super(const []);

  // Add new character entry
  void addCharacter(File image, String name) {
    final newCharacter = Character(image: image, name: name);

    state = [...state, newCharacter];
  }
}

final charactersProvider =
    StateNotifierProvider<CharactersNotifier, List<Character>>(
  (ref) => CharactersNotifier(),
);
