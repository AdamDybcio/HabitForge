import 'package:flutter/material.dart';
import 'package:habit_forge/controllers/home_controller.dart';
import 'package:habit_forge/core/helpers/habit_icon_catalog.dart';
import 'package:habit_forge/models/habit.dart';
import 'package:habit_forge/widgets/habit/create_habit_sheet/create_habit_form_fields.dart';
import 'package:habit_forge/widgets/habit/create_habit_sheet/habit_icon_picker.dart';

/// Bottom sheet with form for creating a new habit.
class CreateHabitBottomSheet extends StatefulWidget {
  /// Controller used to persist a newly created habit.
  final HomeController controller;

  /// Habit being edited. When null, sheet works in create mode.
  final Habit? initialHabit;

  /// Creates [CreateHabitBottomSheet].
  const CreateHabitBottomSheet({
    required this.controller,
    this.initialHabit,
    super.key,
  });

  @override
  State<CreateHabitBottomSheet> createState() => _CreateHabitBottomSheetState();
}

class _CreateHabitBottomSheetState extends State<CreateHabitBottomSheet> {
  static const _iconBoxSize = 52.0;
  static const _iconRadius = 14.0;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  String _selectedIconName = 'task_alt';
  bool _isSubmitting = false;

  bool get _isEditMode => widget.initialHabit != null;

  @override
  void initState() {
    super.initState();

    final initialHabit = widget.initialHabit;

    if (initialHabit != null) {
      _nameController.text = initialHabit.name;
      _descriptionController.text = initialHabit.description;
      _selectedIconName = initialHabit.iconName;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
    final submitIcon = _isSubmitting
        ? const SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(strokeWidth: 2),
          )
        : Icon(_isEditMode ? Icons.check_rounded : Icons.add_rounded);

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 12, 16, bottomInset + 16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CreateHabitSheetTitle(text: _titleText),
                const SizedBox(height: 14),
                HabitNameField(
                  controller: _nameController,
                  validator: _validateName,
                ),
                const SizedBox(height: 12),
                HabitDescriptionField(controller: _descriptionController),
                const SizedBox(height: 14),
                const IconPickerTitle(),
                const SizedBox(height: 8),
                HabitIconPicker(
                  options: habitIconCatalog,
                  selectedIconName: _selectedIconName,
                  iconBoxSize: _iconBoxSize,
                  iconRadius: _iconRadius,
                  onSelect: _selectIcon,
                ),
                const SizedBox(height: 18),
                SubmitHabitButton(
                  isSubmitting: _isSubmitting,
                  label: _submitLabel,
                  icon: submitIcon,
                  onPressed: _submit,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? _validateName(String? value) {
    if ((value ?? '').trim().isEmpty) {
      return 'Name is required';
    }

    return null;
  }

  void _selectIcon(String iconKey) {
    setState(() {
      _selectedIconName = iconKey;
    });
  }

  String get _titleText => _isEditMode ? 'Edit Habit' : 'Create Habit';

  String get _submitLabel {
    if (_isSubmitting) {
      return _isEditMode ? 'Saving...' : 'Creating...';
    }

    return _isEditMode ? 'Save changes' : 'Create habit';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final valid = _formKey.currentState?.validate() ?? false;

    if (!valid) {
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    final initialHabit = widget.initialHabit;

    if (initialHabit == null) {
      await widget.controller.addHabit(
        name: _nameController.text,
        description: _descriptionController.text,
        iconName: _selectedIconName,
      );
    } else {
      await widget.controller.updateHabit(
        habitId: initialHabit.id,
        name: _nameController.text,
        description: _descriptionController.text,
        iconName: _selectedIconName,
      );
    }

    if (!mounted) {
      return;
    }

    Navigator.of(context).pop();
  }
}
