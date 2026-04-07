// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:habit_forge/core/helpers/app_localizations_helper.dart';

/// Description input field for habit form.
class HabitDescriptionField extends StatelessWidget {
  final TextEditingController controller;

  /// Creates [HabitDescriptionField].
  const HabitDescriptionField({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = appL10n(context);

    return TextFormField(
      controller: controller,
      textInputAction: TextInputAction.done,
      minLines: 2,
      maxLines: 4,
      decoration: InputDecoration(
        labelText: l10n.habitDescriptionLabel,
        hintText: l10n.habitDescriptionHint,
      ),
    );
  }
}
