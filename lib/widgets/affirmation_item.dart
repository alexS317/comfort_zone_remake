import 'package:comfort_zone_remake/models/affirmation.dart';

import 'package:flutter/material.dart';

// Affirmation item to show in list
class AffirmationItem extends StatelessWidget {
  const AffirmationItem({
    super.key,
    required this.affirmation,
    required this.deletable,
    this.onDelete,
  });

  final Affirmation affirmation;
  final bool deletable;
  final void Function(Affirmation aff)? onDelete;

  @override
  Widget build(BuildContext context) {
    double paddingValue = 10.0;
    if (deletable) paddingValue = 1.0;

    return Container(
      decoration: BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(
            color: Theme.of(context).colorScheme.secondaryContainer,
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: paddingValue),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            affirmation.text,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          if (deletable)
            IconButton(
              onPressed: () {
                onDelete!(affirmation);
              },
              icon: const Icon(Icons.delete),
            ),
        ],
      ),
    );
  }
}
