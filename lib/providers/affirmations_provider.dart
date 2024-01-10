import 'package:comfort_zone_remake/database/database_helper.dart';
import 'package:comfort_zone_remake/models/affirmation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AffirmationsNotifier extends StateNotifier<List<Affirmation>> {
  AffirmationsNotifier() : super(const []);

  // Load affirmations from database
  Future<void> loadAffirmations() async {
    final affirmations = await SQLiteDatabaseHelper().loadAllAffirmations();

    state = affirmations;
  }

  // Add new affirmation
  void addAffirmation(String text) async {
    final newAffirmation = await SQLiteDatabaseHelper().addAffirmation(text);

    state = [...state, newAffirmation];
  }

  // Delete affirmation
  void deleteAffirmation(Affirmation affirmation) async {
    final affirmationsList = [...state];

    await SQLiteDatabaseHelper().deleteAffirmation(affirmation);
    affirmationsList.remove(affirmation);

    state = affirmationsList;
  }
}

final affirmationsProvider =
    StateNotifierProvider<AffirmationsNotifier, List<Affirmation>>(
  (ref) => AffirmationsNotifier(),
);
