import 'package:comfort_zone_remake/providers/characters_provider.dart';
import 'package:comfort_zone_remake/widgets/character_gallery_grid.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Character gallery shows all existing character entries
class CharacterGalleryScreen extends ConsumerStatefulWidget {
  const CharacterGalleryScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CharacterGalleryScreenState();
}

class _CharacterGalleryScreenState
    extends ConsumerState<CharacterGalleryScreen> {
  late Future<void> _charactersFuture;

  @override
  void initState() {
    super.initState();
    _charactersFuture = ref.read(charactersProvider.notifier).loadCharacters();
  }

  @override
  Widget build(BuildContext context) {
    final characters = ref.watch(charactersProvider);

    return SingleChildScrollView(
      // Gallery grid
      child: FutureBuilder(
        future: _charactersFuture,
        builder: (context, snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? const Center(child: CircularProgressIndicator())
              : CharacterGalleryGrid(characters: characters);
        },
      ),
    );
  }
}
