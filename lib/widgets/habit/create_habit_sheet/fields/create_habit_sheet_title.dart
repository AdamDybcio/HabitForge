// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

/// Bottom sheet title widget.
class CreateHabitSheetTitle extends StatelessWidget {
  final String text;

  /// Creates [CreateHabitSheetTitle].
  const CreateHabitSheetTitle({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(text, style: Theme.of(context).textTheme.titleLarge);
  }
}
