import 'package:comfort_zone_remake/screens/character_details.dart';
import 'package:comfort_zone_remake/widgets/image_input.dart';
import 'package:flutter/material.dart';

class AddCharacterScreen extends StatelessWidget {
  const AddCharacterScreen({super.key});

  void _saveCharacter(BuildContext context) {
    Navigator.of(context).pop();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const CharacterDetailsScreen(),
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
            const ImageInput(),
            const SizedBox(height: 10),
            // Name input
            const TextField(
              decoration: InputDecoration(
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
