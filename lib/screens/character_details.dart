import 'package:flutter/material.dart';

class CharacterDetailsScreen extends StatelessWidget {
  const CharacterDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Character name'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            const SizedBox(
              height: 300,
              child: FittedBox(
                child: Icon(Icons.image),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Character name'),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Edit
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.edit),
                    ),
                    // Delete
                    IconButton(
                      onPressed: () {},
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
