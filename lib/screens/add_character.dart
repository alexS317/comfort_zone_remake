import 'dart:io';

import 'package:comfort_zone_remake/models/character.dart';
import 'package:comfort_zone_remake/screens/character_details.dart';
import 'package:comfort_zone_remake/widgets/image_input.dart';

import 'package:flutter/material.dart';

// Add a new character entry or edit an existing one
class AddCharacterScreen extends StatefulWidget {
  // Add a new entry (default)
  const AddCharacterScreen({super.key}) : character = null;

  // Edit an existing entry
  const AddCharacterScreen.edit({super.key, required this.character});

  final Character? character;

  @override
  State<AddCharacterScreen> createState() => _AddCharacterScreenState();
}

class _AddCharacterScreenState extends State<AddCharacterScreen> {
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
    // Close add screen
    Navigator.of(context).pop();

    // Open detail screen to view new entry
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => widget.character != null
            ? CharacterDetailsScreen(character: widget.character!)
            : CharacterDetailsScreen(
                character: Character(
                    image: _selectedImage!, name: _nameController.text),
              ),
      ),
    );
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
            widget.character != null
                ? ImageInput.edit(
                    onPickImage: (image) => _selectedImage = image,
                    oldImage: widget.character!.image,
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
