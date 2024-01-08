import 'dart:math';

import 'package:comfort_zone_remake/models/character.dart';

import 'package:flutter/material.dart';

class RandomCharacter extends StatelessWidget {
  const RandomCharacter(
      {super.key, required this.characters, required this.onLoadCharacter});

  final List<Character> characters;
  final void Function() onLoadCharacter;

  @override
  Widget build(BuildContext context) {
    final randomIndex = Random().nextInt(characters.length);
    final randomCharacter = characters[randomIndex];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.file(
          randomCharacter.image,
          fit: BoxFit.cover,
          width: double.infinity,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          randomCharacter.name,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton.icon(
          onPressed: onLoadCharacter,
          icon: const Icon(Icons.favorite),
          label: const Text('Get Affirmation'),
        ),
      ],
    );
  }
}
