// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:habit_forge/core/helpers/app_localizations_helper.dart';

/// Name input field for habit form.
class HabitNameField extends StatelessWidget {
  final TextEditingController controller;
  final FormFieldValidator<String> validator;

  /// Creates [HabitNameField].
  const HabitNameField({
    required this.controller,
    required this.validator,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = appL10n(context);

    return TextFormField(
      controller: controller,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: l10n.habitNameLabel,
        hintText: l10n.habitNameHint,
      ),
      validator: validator,
    );
  }
}
