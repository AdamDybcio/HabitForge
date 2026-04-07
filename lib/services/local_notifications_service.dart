// ignore_for_file: prefer_match_file_name

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:habit_forge/models/habit.dart';
import 'package:habit_forge/services/locale_local_storage_service.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

/// Contract for scheduling habit reminder notifications.
abstract class HabitReminderScheduler {
  /// Initializes notification channels, permissions and timezone configuration.
  Future<void> initialize();

  /// Reconciles notifications so they match current list of habits.
  Future<void> syncHabitReminders(List<Habit> habits);

  /// Creates or updates a daily reminder for a single habit.
  Future<void> scheduleHabitReminder(Habit habit);

  /// Cancels reminder notification for a single habit.
  Future<void> cancelHabitReminder(String habitId);
}

/// No-op implementation used for testing and unsupported targets.
class NoopHabitReminderScheduler implements HabitReminderScheduler {
  @override
  Future<void> initialize() => Future<void>.value();

  @override
  Future<void> syncHabitReminders(List<Habit> habits) => Future<void>.value();

  @override
  Future<void> scheduleHabitReminder(Habit habit) => Future<void>.value();

  @override
  Future<void> cancelHabitReminder(String habitId) => Future<void>.value();
}

/// Schedules and manages local notifications for habit reminders.
class LocalNotificationsService implements HabitReminderScheduler {
  static const _channelId = 'habit_forge_daily_reminders';
  static const _channelName = 'Daily Habit Reminders';
  static const _channelDescription = 'Daily reminders for enabled habits.';
  static const _notificationTitlePrefixEn = 'Habit reminder';
  static const _notificationTitlePrefixPl = 'Przypomnienie o nawyku';
  static const _notificationFallbackBodyEn =
      'Open HabitForge and mark it done.';
  static const _notificationFallbackBodyPl =
      'Otwórz HabitForge i oznacz nawyk jako wykonany.';
  static const _fnvOffset = 0x811C9DC5;
  static const _fnvPrime = 0x01000193;
  static const _positiveIntMask = 0x7fffffff;

  final FlutterLocalNotificationsPlugin _plugin;
  final LocaleLocalStorageService _localeStorage;

  bool _isInitialized = false;

  /// Creates [LocalNotificationsService].
  LocalNotificationsService({
    FlutterLocalNotificationsPlugin? plugin,
    LocaleLocalStorageService? localeStorage,
  }) : _plugin = plugin ?? FlutterLocalNotificationsPlugin(),
       _localeStorage = localeStorage ?? LocaleLocalStorageService();

  @override
  Future<void> initialize() async {
    if (_isInitialized) {
      return;
    }

    tz.initializeTimeZones();

    try {
      final timezone = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(timezone));
    } catch (_) {
      // Falls back to the package default timezone if device lookup fails.
    }

    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const darwin = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    await _plugin.initialize(
      settings: const InitializationSettings(
        android: android,
        iOS: darwin,
        macOS: darwin,
      ),
    );

    await _requestPermissions();
    _isInitialized = true;
  }

  @override
  Future<void> syncHabitReminders(List<Habit> habits) async {
    await initialize();

    final targetHabitIds = habits
        .where((habit) => habit.hasReminder)
        .map((habit) => habit.id)
        .toSet();
    final pending = await _plugin.pendingNotificationRequests();

    for (final request in pending) {
      final payload = request.payload;

      if (payload == null || !payload.startsWith('habit:')) {
        continue;
      }

      final habitId = payload.substring('habit:'.length);

      if (!targetHabitIds.contains(habitId)) {
        await _plugin.cancel(id: request.id);
      }
    }

    for (final habit in habits.where((item) => item.hasReminder)) {
      await scheduleHabitReminder(habit);
    }
  }

  @override
  Future<void> scheduleHabitReminder(Habit habit) async {
    if (!habit.hasReminder) {
      await cancelHabitReminder(habit.id);

      return;
    }

    if (habit.isCompletedToday()) {
      await cancelHabitReminder(habit.id);

      return;
    }

    await initialize();

    final hour = habit.reminderHour;
    final minute = habit.reminderMinute;

    if (hour == null || minute == null) {
      await cancelHabitReminder(habit.id);

      return;
    }

    final scheduledDate = _nextInstanceOfTime(hour, minute);
    final locale = await _localeStorage.loadLocale();
    final languageCode = locale?.languageCode.toLowerCase() ?? 'en';

    await _plugin.zonedSchedule(
      id: _notificationIdForHabit(habit.id),
      title: _notificationTitleForHabit(habit, languageCode),
      body: _notificationBodyForHabit(habit, languageCode),
      scheduledDate: scheduledDate,
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          _channelId,
          _channelName,
          channelDescription: _channelDescription,
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      payload: 'habit:${habit.id}',
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  @override
  Future<void> cancelHabitReminder(String habitId) {
    return _plugin.cancel(id: _notificationIdForHabit(habitId));
  }

  Future<void> _requestPermissions() async {
    final android = _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    await android?.requestNotificationsPermission();
    await android?.requestExactAlarmsPermission();

    final ios = _plugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >();
    await ios?.requestPermissions(alert: true, badge: true, sound: true);

    final macos = _plugin
        .resolvePlatformSpecificImplementation<
          MacOSFlutterLocalNotificationsPlugin
        >();
    await macos?.requestPermissions(alert: true, badge: true, sound: true);
  }

  tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
    final now = tz.TZDateTime.now(tz.local);
    final scheduled = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    if (scheduled.isBefore(now) || scheduled.isAtSameMomentAs(now)) {
      return scheduled.add(const Duration(days: 1));
    }

    return scheduled;
  }

  int _notificationIdForHabit(String habitId) {
    var hash = _fnvOffset;

    for (final codeUnit in habitId.codeUnits) {
      hash ^= codeUnit;
      hash = (hash * _fnvPrime) & _positiveIntMask;
    }

    return hash;
  }

  String _notificationTitleForHabit(Habit habit, String languageCode) {
    final isPolish = languageCode == 'pl';
    final prefix = isPolish
        ? _notificationTitlePrefixPl
        : _notificationTitlePrefixEn;

    return '$prefix: ${habit.name}';
  }

  String _notificationBodyForHabit(Habit habit, String languageCode) {
    if (habit.description.trim().isNotEmpty) {
      return habit.description.trim();
    }

    if (languageCode == 'pl') {
      return _notificationFallbackBodyPl;
    }

    return _notificationFallbackBodyEn;
  }
}
