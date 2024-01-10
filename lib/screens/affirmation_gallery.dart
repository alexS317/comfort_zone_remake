import 'package:comfort_zone_remake/data/default_affirmations.dart';
import 'package:comfort_zone_remake/models/affirmation.dart';
import 'package:comfort_zone_remake/providers/affirmations_provider.dart';
import 'package:comfort_zone_remake/widgets/affirmation_list.dart';

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
  late Future<void> _affirmationsFuture;

  @override
  void initState() {
    super.initState();
    _affirmationsFuture =
        ref.read(affirmationsProvider.notifier).loadAffirmations();
  }

  void _deleteEntry(Affirmation affirmation) {
    ref.read(affirmationsProvider.notifier).deleteAffirmation(affirmation);
  }

  @override
  Widget build(BuildContext context) {
    final affirmations = ref.watch(affirmationsProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Custom",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          FutureBuilder(
            future: _affirmationsFuture,
            builder: (context, snapshot) {
              return snapshot.connectionState == ConnectionState.waiting
                  ? const Center(child: CircularProgressIndicator())
                  : AffirmationList(
                      list: affirmations,
                      deletableItems: true,
                      onDeleteFunc: _deleteEntry,
                    );
            },
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            "Default",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          AffirmationList(
            list: defaultAffirmations,
            deletableItems: false,
          ),
        ],
      ),
    );
  }
}
