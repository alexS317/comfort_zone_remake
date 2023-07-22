import 'package:comfort_zone_remake/providers/characters.dart';
import 'package:comfort_zone_remake/screens/add_character.dart';
import 'package:comfort_zone_remake/widgets/character_gallery_grid.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Character gallery shows small previews of all existing entries
class CharacterGalleryScreen extends ConsumerStatefulWidget {
  const CharacterGalleryScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _CharacterGalleryScreenState();
  }
}

class _CharacterGalleryScreenState
    extends ConsumerState<CharacterGalleryScreen> {
  late Future<void> _charactersFuture;

  // Open add screen to add a new entry
  void _addCharacterEntry(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const AddCharacterScreen(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _charactersFuture = ref.read(charactersProvider.notifier).loadCharacters();
  }

  @override
  Widget build(BuildContext context) {
    final characters = ref.watch(charactersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Character Gallery'),
      ),
      body: Stack(
        children: [
          // Gallery grid
          FutureBuilder(
              future: _charactersFuture,
              builder: (context, snapshot) {
                return snapshot.connectionState == ConnectionState.waiting
                    ? const Center(child: CircularProgressIndicator())
                    : CharacterGalleryGrid(characters: characters);
              }),
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
      ),
    );
  }
}
