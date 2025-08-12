import 'package:flutter/material.dart';

class LabelSubtitleText extends StatelessWidget {
  const LabelSubtitleText({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      textAlign: TextAlign.start,
      style: Theme.of(context).textTheme.bodySmall!.copyWith(
        color: Theme.of(context).colorScheme.tertiary.withValues(alpha: 0.7),
        fontWeight: FontWeight.w600,
        fontSize: 12,
      ),
    );
  }
}
