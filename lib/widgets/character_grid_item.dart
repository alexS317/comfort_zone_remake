import 'package:comfort_zone_remake/models/character.dart';
import 'package:comfort_zone_remake/screens/character_details.dart';
import 'package:flutter/material.dart';

// Grid item for the character gallery
class CharacterGridItem extends StatelessWidget {
  const CharacterGridItem({super.key, required this.character});

  final Character character;

  void _openCharacter(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => CharacterDetailsScreen(character: character),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _openCharacter(context);
      },
      child: GridTile(
        child: Image.file(
          character.image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
