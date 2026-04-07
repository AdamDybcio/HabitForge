import 'package:flutter/material.dart';
import 'package:habit_forge/core/helpers/app_localizations_helper.dart';
import 'package:habit_forge/core/helpers/habit_icon_catalog.dart';
import 'package:habit_forge/widgets/habit/create_habit_bottom_sheet.dart';
import 'package:habit_forge/widgets/habit/create_habit_sheet/create_habit_form_fields.dart';
import 'package:habit_forge/widgets/habit/create_habit_sheet/habit_icon_picker.dart';
import 'package:habit_forge/widgets/habit/create_habit_sheet/icon_picker_title.dart';

/// State object for [CreateHabitBottomSheet].
class CreateHabitBottomSheetState extends State<CreateHabitBottomSheet> {
  static const _iconBoxSize = 52.0;
  static const _iconRadius = 14.0;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  String _selectedIconName = 'task_alt';
  bool _reminderEnabled = false;
  TimeOfDay _reminderTime = const TimeOfDay(hour: 20, minute: 0);
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
      _reminderEnabled = initialHabit.reminderEnabled;

      final initialReminderHour = initialHabit.reminderHour;
      final initialReminderMinute = initialHabit.reminderMinute;

      if (initialReminderHour != null && initialReminderMinute != null) {
        _reminderTime = TimeOfDay(
          hour: initialReminderHour,
          minute: initialReminderMinute,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = appL10n(context);
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
                HabitReminderControls(
                  reminderEnabled: _reminderEnabled,
                  reminderTime: _reminderTime,
                  onToggle: _toggleReminder,
                  onSelectTime: _selectReminderTime,
                ),
                const SizedBox(height: 10),
                IconPickerTitle(label: l10n.habitIconLabel),
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
      return appL10n(context).habitNameRequiredError;
    }

    return null;
  }

  void _selectIcon(String iconKey) {
    setState(() {
      _selectedIconName = iconKey;
    });
  }

  String get _titleText {
    final l10n = appL10n(context);

    return _isEditMode ? l10n.editHabitTitle : l10n.createHabitTitle;
  }

  String get _submitLabel {
    final l10n = appL10n(context);

    if (_isSubmitting) {
      return _isEditMode ? l10n.savingHabit : l10n.creatingHabit;
    }

    return _isEditMode ? l10n.saveChanges : l10n.createHabit;
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
        reminderEnabled: _reminderEnabled,
        reminderHour: _reminderEnabled ? _reminderTime.hour : null,
        reminderMinute: _reminderEnabled ? _reminderTime.minute : null,
      );
    } else {
      await widget.controller.updateHabit(
        habitId: initialHabit.id,
        name: _nameController.text,
        description: _descriptionController.text,
        iconName: _selectedIconName,
        reminderEnabled: _reminderEnabled,
        reminderHour: _reminderEnabled ? _reminderTime.hour : null,
        reminderMinute: _reminderEnabled ? _reminderTime.minute : null,
      );
    }

    if (!mounted) {
      return;
    }

    Navigator.of(context).pop();
  }

  void _toggleReminder(bool enabled) {
    setState(() {
      _reminderEnabled = enabled;
    });
  }

  Future<void> _selectReminderTime() async {
    final selected = await showTimePicker(
      context: context,
      initialTime: _reminderTime,
      builder: (context, child) {
        if (child == null) {
          return const SizedBox.shrink();
        }

        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child,
        );
      },
    );

    if (selected == null) {
      return;
    }

    setState(() {
      _reminderTime = selected;
    });
  }
}
