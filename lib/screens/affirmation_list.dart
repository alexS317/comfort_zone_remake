import 'package:comfort_zone_remake/data/default_affirmations.dart';
import 'package:comfort_zone_remake/widgets/affirmation_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Shows lists of default and custom affirmations
class AffirmationGalleryScreen extends ConsumerStatefulWidget {
  const AffirmationGalleryScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AffirmationGalleryScreenState();
}

class _AffirmationGalleryScreenState
    extends ConsumerState<AffirmationGalleryScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Default",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          ListView.builder(
            itemCount: defaultAffirmations.length,
            itemBuilder: (context, index) => AffirmationItem(
              text: defaultAffirmations[index].text,
              deletable: false,
            ),
            shrinkWrap: true,
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            "Custom",
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
