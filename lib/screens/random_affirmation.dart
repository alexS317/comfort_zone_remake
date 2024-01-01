import 'package:comfort_zone_remake/providers/characters_provider.dart';
import 'package:comfort_zone_remake/screens/character_gallery.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RandomAffirmationScreen extends ConsumerStatefulWidget {
  const RandomAffirmationScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RandomAffirmationScreenState();
}

class _RandomAffirmationScreenState
    extends ConsumerState<RandomAffirmationScreen> {
  late Future<void> _charactersFuture;

  void _openGallery(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const CharacterGalleryScreen(),
      ),
    );
  }

  void _loadRandomCharacter() {
    _charactersFuture =
        ref.read(charactersProvider.notifier).loadRandomCharacter();
  }

  @override
  void initState() {
    super.initState();
    _loadRandomCharacter();
  }

  @override
  Widget build(BuildContext context) {
    final characters = ref.watch(charactersProvider);

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
              return snapshot.connectionState == ConnectionState.waiting
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                      children: [
                        Image.file(
                          characters[0].image,
                          fit: BoxFit.cover,
                        ),
                        Text(characters[0].name),
                        ElevatedButton.icon(
                          onPressed: _loadRandomCharacter,
                          icon: const Icon(Icons.favorite),
                          label: const Text('Get Affirmation'),
                        ),
                      ],
                    );
            }),
      ),
    );
  }
}
