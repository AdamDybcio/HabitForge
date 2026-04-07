// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

/// Section title for icon picker.
class IconPickerTitle extends StatelessWidget {
  final String label;

  /// Creates [IconPickerTitle].
  const IconPickerTitle({required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(label, style: Theme.of(context).textTheme.labelLarge);
  }
}
