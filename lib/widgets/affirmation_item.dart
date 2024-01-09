import 'package:flutter/material.dart';

// Affirmation item to show in list
class AffirmationItem extends StatelessWidget {
  const AffirmationItem(
      {super.key, required this.text, required this.deletable});

  final String text;
  final bool deletable;

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
            text,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          if (deletable)
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.delete),
            ),
        ],
      ),
    );
  }
}
