import 'package:flutter/material.dart';

// Add a new affirmation
class AddAffirmationScreen extends StatefulWidget {
  const AddAffirmationScreen({super.key});

  @override
  State<AddAffirmationScreen> createState() => _AddAffirmationScreenState();
}

class _AddAffirmationScreenState extends State<AddAffirmationScreen> {
  final _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  // Save affirmation and leave the screen
  void _saveAffirmation(BuildContext context) {
    final enteredText = _textController.text;

    // Prevent submitting an empty entry
    if (enteredText.trim().isEmpty) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter an affirmation text.'),
        ),
      );
      return;
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new affirmation'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _textController,
              decoration: const InputDecoration(labelText: 'Affirmation text'),
              keyboardType: TextInputType.multiline,
              maxLines: null,
            ),
            const SizedBox(
              height: 26,
            ),
            ElevatedButton.icon(
              onPressed: () {
                _saveAffirmation(context);
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
