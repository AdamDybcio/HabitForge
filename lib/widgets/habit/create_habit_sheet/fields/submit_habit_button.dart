// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

/// Submit button for create/edit habit action.
class SubmitHabitButton extends StatelessWidget {
  final bool isSubmitting;
  final String label;
  final Widget icon;
  final VoidCallback onPressed;

  /// Creates [SubmitHabitButton].
  const SubmitHabitButton({
    required this.isSubmitting,
    required this.label,
    required this.icon,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton.icon(
        onPressed: isSubmitting ? null : onPressed,
        icon: icon,
        label: Text(label),
      ),
    );
  }
}
