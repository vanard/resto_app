import 'package:flutter/material.dart';

class DividerComponent extends StatelessWidget {
  const DividerComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: Theme.of(context).dividerColor.withValues(alpha: 0.3),
    );
  }
}
