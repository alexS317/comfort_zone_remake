import 'package:comfort_zone_remake/data/default_affirmations.dart';
import 'package:comfort_zone_remake/database/user_settings.dart';
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
    bool defaultsAllowed;

    // Toggle whether default affirmations should be included and set user preferences accordingly
    Widget defaultToggler = FutureBuilder(
      future: UserSettings().getIncludeDefaultAffirmations(),
      builder: (context, snapshot) {
        defaultsAllowed = snapshot.data ?? false;

        return Switch(
            value: defaultsAllowed,
            onChanged: (value) {
              UserSettings().setIncludeDefaultAffirmations(value);
              setState(() {
                defaultsAllowed = value;
              });
            });
        // }
      },
    );

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
            height: 20,
          ),
          Row(
            children: [
              Text(
                "Default",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(
                width: 10,
              ),
              defaultToggler,
            ],
          ),
          Text(
            "Default affirmations will be used regardless if you don't have any custom affirmations saved.",
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(
            height: 10,
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
