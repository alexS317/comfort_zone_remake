import 'package:comfort_zone_remake/models/character.dart';
import 'package:comfort_zone_remake/widgets/character_grid_item.dart';
import 'package:flutter/cupertino.dart';

// Gallery grid to display small previews of the character entries
class CharacterGalleryGrid extends StatelessWidget {
  const CharacterGalleryGrid({
    super.key,
    required this.characters,
  });

  final List<Character> characters;

  @override
  Widget build(BuildContext context) {
    // Placeholder for empty database
    if (characters.isEmpty) {
      return const Center(
        child: Text('No character entries yet.'),
      );
    }

    // Grid gallery
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
      ),
      itemCount: characters.length,
      itemBuilder: (context, index) => CharacterGridItem(
        character: characters[index],
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
    );
  }
}
