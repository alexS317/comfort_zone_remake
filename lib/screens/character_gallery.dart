import 'package:comfort_zone_remake/providers/characters.dart';
import 'package:comfort_zone_remake/screens/add_character.dart';
import 'package:comfort_zone_remake/widgets/character_grid_item.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Character gallery shows small previews of all existing entries
class CharacterGalleryScreen extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final characters = ref.watch(charactersProvider);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Character Gallery'),
        ),
        body: Stack(
          children: [
            // Gallery grid
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              itemCount: characters.length,
              itemBuilder: ((context, index) =>
                  CharacterGridItem(character: characters[index])),
            ),
            // Add button
            Positioned(
              right: 10,
              bottom: 20,
              child: IconButton.filled(
                onPressed: () {
                  _addCharacterEntry(context);
                },
                icon: const Icon(Icons.add),
                iconSize: 30,
              ),
            ),
          ],
        ));
  }
}
