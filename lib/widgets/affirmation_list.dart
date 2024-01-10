import 'package:comfort_zone_remake/models/affirmation.dart';
import 'package:comfort_zone_remake/widgets/affirmation_item.dart';
import 'package:flutter/material.dart';

class AffirmationList extends StatelessWidget {
  const AffirmationList({
    super.key,
    required this.list,
    required this.deletableItems,
    this.onDeleteFunc,
  });

  final List<Affirmation> list;
  final bool deletableItems;
  final void Function(Affirmation aff)? onDeleteFunc;

  @override
  Widget build(BuildContext context) {
    if (list.isEmpty) {
      return const Center(
        child: Text(
          'No affirmations saved yet.',
        ),
      );
    } else {
      return ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) => AffirmationItem(
          affirmation: list[index],
          deletable: deletableItems,
          onDelete: onDeleteFunc,
        ),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
      );
    }
  }
}
