import 'dart:io';

import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Character {
  // Initialize character with a uniquely generated id and the time it was created
  Character({
    required this.image,
    required this.name,
  })  : id =  uuid.v4(),
        createDate = DateTime.now().toString();

  final String id;
  final String createDate;
  final File image;
  final String name;
}
