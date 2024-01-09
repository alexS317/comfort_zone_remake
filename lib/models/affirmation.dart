import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Affirmation {
  Affirmation({
    required this.text,
    String? id,
  }) : id = id ?? uuid.v4();

  final String id;
  final String text;
}
