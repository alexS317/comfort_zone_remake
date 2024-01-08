import 'package:comfort_zone_remake/providers/characters_provider.dart';
import 'package:comfort_zone_remake/screens/add_character.dart';
import 'package:comfort_zone_remake/screens/character_gallery.dart';
import 'package:comfort_zone_remake/widgets/random_character.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeAffirmationScreen extends ConsumerStatefulWidget {
  const HomeAffirmationScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _HomeAffirmationScreenState();
}

class _HomeAffirmationScreenState
    extends ConsumerState<HomeAffirmationScreen> {
  late Future<void> _charactersFuture;

  void _openGallery(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const CharacterGalleryScreen(),
      ),
    );
  }

  // Open add screen to add a new entry if there are no entries yet
  Future<void> _addCharacterEntry(BuildContext context) async {
    await Future.delayed(Duration.zero);
    if (!mounted) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const AddCharacterScreen(),
      ),
    );
  }

  void _loadRandomCharacter() {
    _charactersFuture = ref.read(charactersProvider.notifier).loadCharacters();
  }

  @override
  void initState() {
    super.initState();
    _loadRandomCharacter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Comfort Zone',
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          IconButton(
            onPressed: () {
              _openGallery(context);
            },
            icon: Icon(
              Icons.grid_view_sharp,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: FutureBuilder(
            future: _charactersFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else {
                final characters = ref.watch(charactersProvider);
                if (characters.isEmpty) {
                  _addCharacterEntry(context);
                  return const Center(
                      child: Text("No characters available yet."));
                } else {
                  return RandomCharacter(
                      characters: characters,
                      onLoadCharacter: _loadRandomCharacter);
                }
              }
            }),
      ),
    );
  }
}
