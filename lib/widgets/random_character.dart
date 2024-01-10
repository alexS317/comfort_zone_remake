import 'dart:math';

import 'package:comfort_zone_remake/data/default_affirmations.dart';
import 'package:comfort_zone_remake/database/user_settings.dart';
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
    int randomIndexA;
    Affirmation randomAffirmation;

    if (affirmations.isNotEmpty) {
      randomIndexA = Random().nextInt(affirmations.length);
      randomAffirmation = affirmations[randomIndexA];

      affirmationText = randomAffirmation.text;
    }

    Widget affirmationWidget = FutureBuilder(
      future: UserSettings().getIncludeDefaultAffirmations(),
      builder: (context, snapshot) {
        bool allowDefaultAffirmations = snapshot.data ?? false;
        // If there are no custom affirmations use defaults regardless of preference
        if (affirmations.isEmpty) allowDefaultAffirmations = true;

        // Include default affirmations
        // To be adapted so user can choose whether to include default affirmations or not
        if (allowDefaultAffirmations) {
          final allAffirmations = affirmations + defaultAffirmations;
          randomIndexA = Random().nextInt(allAffirmations.length);
          randomAffirmation = allAffirmations[randomIndexA];

          affirmationText = randomAffirmation.text;
        }

        return Text(
          affirmationText,
          style: Theme.of(context).textTheme.titleMedium,
        );
      },
    );

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
        affirmationWidget,
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
