import 'dart:io';

import 'package:comfort_zone_remake/models/character.dart';
import 'package:comfort_zone_remake/providers/characters.dart';
import 'package:comfort_zone_remake/widgets/image_input.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Add a new character entry or edit an existing one
class AddCharacterScreen extends ConsumerStatefulWidget {
  // Add a new entry (default)
  const AddCharacterScreen({super.key}) : character = null;

  // // Edit an existing entry
  // const AddCharacterScreen.edit({super.key, required this.character});

  final Character? character;

  @override
  ConsumerState<AddCharacterScreen> createState() => _AddCharacterScreenState();
}

class _AddCharacterScreenState extends ConsumerState<AddCharacterScreen> {
  final _nameController = TextEditingController();
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    if (widget.character != null) _nameController.text = widget.character!.name;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _saveCharacter(BuildContext context) {
    if (_selectedImage == null || _nameController.text.trim().isEmpty) {
      print('Please enter data.');
      return;
    }

    // Close add screen
    Navigator.of(context).pop();

    // Add character via provider
    ref
        .read(charactersProvider.notifier)
        .addCharacter(_selectedImage!, _nameController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new character'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Image input
            // widget.character != null
            //     ? ImageInput.edit(
            //         onPickImage: (image) => _selectedImage = image,
            //         oldImage: widget.character!.image,
            //       )
            ImageInput(
              onPickImage: (image) => _selectedImage = image,
            ),
            const SizedBox(height: 10),
            // Name input
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Character name',
              ),
            ),
            const SizedBox(height: 10),
            // Save button
            ElevatedButton.icon(
              onPressed: () {
                _saveCharacter(context);
              },
              icon: const Icon(Icons.save),
              label: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
