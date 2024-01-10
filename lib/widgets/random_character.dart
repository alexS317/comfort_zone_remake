import 'dart:math';

import 'package:comfort_zone_remake/data/default_affirmations.dart';
import 'package:comfort_zone_remake/models/affirmation.dart';
import 'package:comfort_zone_remake/models/character.dart';

import 'package:flutter/material.dart';

class RandomCharacter extends StatelessWidget {
  const RandomCharacter(
      {super.key,
      required this.characters,
      required this.affirmations,
      required this.onLoadCharacter});

  final List<Character> characters;
  final List<Affirmation> affirmations;
  final void Function() onLoadCharacter;

  @override
  Widget build(BuildContext context) {
    final randomIndexC = Random().nextInt(characters.length);
    final randomCharacter = characters[randomIndexC];
    var affirmationText = "";

    final allAffirmations = affirmations + defaultAffirmations;
    if (affirmations.isNotEmpty) {
      var randomIndexA = Random().nextInt(affirmations.length);
      var randomAffirmation = affirmations[randomIndexA];

      // Include default affirmations
      // To be adapted so user can choose whether to include default affirmations or not
      if (true) {
        randomIndexA = Random().nextInt(allAffirmations.length);
        randomAffirmation = allAffirmations[randomIndexA];
      }

      affirmationText = randomAffirmation.text;
    }

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
        Text(
          affirmationText,
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
