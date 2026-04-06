// ignore_for_file: public_member_api_docs, prefer_match_file_name

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
    return TextFormField(
      controller: controller,
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
        labelText: 'Name',
        hintText: 'e.g. Drink water',
      ),
      validator: validator,
    );
  }
}

/// Description input field for habit form.
class HabitDescriptionField extends StatelessWidget {
  final TextEditingController controller;

  /// Creates [HabitDescriptionField].
  const HabitDescriptionField({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textInputAction: TextInputAction.done,
      minLines: 2,
      maxLines: 4,
      decoration: const InputDecoration(
        labelText: 'Description',
        hintText: 'Optional notes for this habit',
      ),
    );
  }
}

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
