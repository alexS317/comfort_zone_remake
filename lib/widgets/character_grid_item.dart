import 'package:comfort_zone_remake/models/character.dart';
import 'package:flutter/material.dart';

// Grid item for the character gallery
class CharacterGridItem extends StatelessWidget {
  const CharacterGridItem({super.key, required this.character});

  final Character character;

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: Image.file(
        character.image,
        fit: BoxFit.cover,
      ),
    );
  }
}
