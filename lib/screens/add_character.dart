import 'dart:io';

import 'package:comfort_zone_remake/models/character.dart';
import 'package:comfort_zone_remake/providers/characters_provider.dart';
import 'package:comfort_zone_remake/widgets/image_input.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Add a new character entry or edit an existing one
class AddCharacterScreen extends ConsumerStatefulWidget {
  // Add a new entry (default)
  const AddCharacterScreen({super.key}) : oldCharacter = null;

  // Edit an existing entry
  const AddCharacterScreen.edit({super.key, required this.oldCharacter});

  final Character? oldCharacter;

  @override
  ConsumerState<AddCharacterScreen> createState() => _AddCharacterScreenState();
}

class _AddCharacterScreenState extends ConsumerState<AddCharacterScreen> {
  final _nameController = TextEditingController();
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    if (widget.oldCharacter != null) {
      _selectedImage = widget.oldCharacter!.image;
      _nameController.text = widget.oldCharacter!.name;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _saveCharacter(BuildContext context) {
    final enteredName = _nameController.text;

    // Prevent submitting an empty entry
    if (_selectedImage == null || enteredName.trim().isEmpty) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please provide an image and the character\'s name.'),
        ),
      );
      return;
    }

    if (widget.oldCharacter == null) {
      // Add character via provider
      ref
          .read(charactersProvider.notifier)
          .addCharacter(_selectedImage!, enteredName);

      // Close add screen
      Navigator.of(context).pop();
    } else {
      ref
          .read(charactersProvider.notifier)
          .updateCharacter(widget.oldCharacter!, _selectedImage!, enteredName);

      // Send updated character back to view on details screen
      Character updatedCharacter = Character(
          image: _selectedImage!,
          name: enteredName,
          id: widget.oldCharacter!.id,
          createDate: widget.oldCharacter!.createDate);

      // Close edit screen
      Navigator.of(context).pop(updatedCharacter);
    }
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
            widget.oldCharacter != null
                ? ImageInput.edit(
                    onPickImage: (image) => _selectedImage = image,
                    oldImage: widget.oldCharacter!.image,
                  )
                : ImageInput(
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
            const SizedBox(height: 26),
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
