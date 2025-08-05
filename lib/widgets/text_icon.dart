import 'package:flutter/material.dart';

class TextIcon extends StatelessWidget {
  const TextIcon({super.key, required this.text, required this.icon});

  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          // color: Theme.of(context).colorScheme.primary
        ),
        const SizedBox(width: 4),
        Text(
          text,
          maxLines: 1,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}
