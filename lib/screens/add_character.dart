import 'package:flutter/material.dart';

class AddCharacterScreen extends StatelessWidget {
  const AddCharacterScreen({super.key});

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
            // Image input (tbd)
            const SizedBox(
              height: 300,
              child: FittedBox(
                child: Icon(Icons.image),
              ),
            ),
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
              onPressed: () {},
              icon: const Icon(Icons.save),
              label: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
