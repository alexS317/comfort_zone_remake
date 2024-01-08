import 'package:comfort_zone_remake/models/character.dart';
import 'package:comfort_zone_remake/providers/characters_provider.dart';
import 'package:comfort_zone_remake/screens/add_character.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Shows a detailed view of the character entry and allows editing and deleting
class CharacterDetailsScreen extends ConsumerStatefulWidget {
  const CharacterDetailsScreen({super.key, required this.character});

  final Character character;

  @override
  ConsumerState<CharacterDetailsScreen> createState() =>
      _CharacterDetailsScreenState();
}

class _CharacterDetailsScreenState
    extends ConsumerState<CharacterDetailsScreen> {
  Character? currentCharacter;
  Character? updatedCharacter;

  Future<void> _openEditScreen(BuildContext context) async {
    // Wait for updated character data to come back after editing
    updatedCharacter = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => AddCharacterScreen.edit(
          oldCharacter: currentCharacter,
        ),
      ),
    );

    setState(() {
      currentCharacter = updatedCharacter;
    });
  }

  void _deleteEntry() {
    ref.read(charactersProvider.notifier).deleteCharacter(widget.character);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    currentCharacter = widget.character;

    if (updatedCharacter != null) {
      currentCharacter = updatedCharacter!;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(currentCharacter!.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Image.file(currentCharacter!.image),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(currentCharacter!.name),
                Row(
                  children: [
                    // Edit
                    IconButton(
                      onPressed: () {
                        _openEditScreen(context);
                      },
                      icon: const Icon(Icons.edit),
                    ),
                    // Delete
                    IconButton(
                      onPressed: () {
                        _deleteEntry();
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
