import 'package:comfort_zone_remake/models/character.dart';

import 'package:flutter/material.dart';

// Shows a detailed view of the character entry and allows editing and deleting
class CharacterDetailsScreen extends StatelessWidget {
  const CharacterDetailsScreen({super.key, required this.character});

  final Character character;

  // void _editCharacter(BuildContext context) {
  //   // Navigator.of(context).pop();

  //   Navigator.of(context).push(
  //     MaterialPageRoute(
  //       builder: (ctx) => AddCharacterScreen.edit(
  //         character: character,
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(character.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Image.file(character.image),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(character.name),
                Row(
                  children: [
                    // Edit
                    IconButton(
                      onPressed: () {
                        // _editCharacter(context);
                      },
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
            Text('Id: ${character.id}'),
            Text('Date created: ${character.createDate}'),
          ],
        ),
      ),
    );
  }
}
