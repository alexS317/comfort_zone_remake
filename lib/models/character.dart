import 'dart:io';

import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Character {
  // Initialize character with a uniquely generated id and the time it was created
  // Leave the option to set id and date manually (e.g. for characters that are loaded from a database)
  Character({
    required this.image,
    required this.name,
    String? id,
    String? createDate,
  })  : id = id ?? uuid.v4(),
        createDate = createDate ?? DateTime.now().toString();

  final String id;
  final String createDate;
  final File image;
  final String name;
}
