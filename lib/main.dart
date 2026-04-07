import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:habit_forge/app.dart';
import 'package:habit_forge/services/hive_service.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await initializeDateFormatting();
  await HiveService.init();

  runApp(const HabitForgeApp());
}
