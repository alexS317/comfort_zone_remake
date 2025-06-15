import 'package:comfort_zone_remake/providers/affirmations_provider.dart';
import 'package:comfort_zone_remake/providers/characters_provider.dart';
import 'package:comfort_zone_remake/screens/add_character.dart';
import 'package:comfort_zone_remake/screens/gallery_tabs.dart';
import 'package:comfort_zone_remake/widgets/random_character.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Main screen that displays a random character and affirmation
class HomeAffirmationScreen extends ConsumerStatefulWidget {
  const HomeAffirmationScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _HomeAffirmationScreenState();
}

class _HomeAffirmationScreenState extends ConsumerState<HomeAffirmationScreen> {
  late Future<void> _charactersFuture;
  // ignore: unused_field
  late Future<void> _affirmationsFuture;

  void _openGallery(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const GalleryTabsScreen(),
      ),
    );
  }

  // Open add screen to add a new entry if there are no entries yet
  Future<void> _addCharacterEntry(BuildContext context) async {
    await Future.delayed(Duration.zero);
    if (!context.mounted) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const AddCharacterScreen(),
      ),
    );
  }

  void _loadRandomCharacter() {
    _charactersFuture = ref.read(charactersProvider.notifier).loadCharacters();
    _affirmationsFuture =
        ref.read(affirmationsProvider.notifier).loadAffirmations();
  }

  @override
  void initState() {
    super.initState();
    _loadRandomCharacter();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Comfort Zone',
          ),
          actions: [
            IconButton(
              onPressed: () {
                _openGallery(context);
              },
              icon: const Icon(
                Icons.grid_view_sharp,
              ),
            ),
          ],
        ),
        body: Stack(
          alignment: AlignmentDirectional.topCenter,
          fit: StackFit.expand,
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  FutureBuilder(
                      future: _charactersFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else {
                          final characters = ref.watch(charactersProvider);
                          final affirmations = ref.watch(affirmationsProvider);

                          if (characters.isEmpty) {
                            _addCharacterEntry(context);
                            return const Center(
                                child: Text("No characters available yet."));
                          } else {
                            return RandomCharacter(
                                characters: characters,
                                affirmations: affirmations);
                          }
                        }
                      }),
                  const SizedBox(height: 110)
                ],
              ),
            ),
            Positioned(
              bottom: 60,
              child: ElevatedButton.icon(
                onPressed: _loadRandomCharacter,
                icon: const Icon(Icons.favorite),
                label: const Text('Get Affirmation'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
