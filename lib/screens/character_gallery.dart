import 'package:comfort_zone_remake/screens/add_character.dart';

import 'package:flutter/material.dart';

class CharacterGalleryScreen extends StatelessWidget {
  const CharacterGalleryScreen({super.key});

  // Open add screen to add a new entry
  void _addCharacterEntry(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const AddCharacterScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Character Gallery'),
      ),
      body: IconButton.filled(
        onPressed: () {
          _addCharacterEntry(context);
        },
        icon: const Icon(Icons.add),
      ),
    );
  }
}
