// ignore_for_file: prefer_match_file_name
import 'package:flutter/material.dart';

/// Application color tokens based on the Editorial Precision design system.
class AppColors {
  /// Brand action color used for primary interactions.
  static const primary = Color(0xFF0058BE);

  /// Tonal companion for gradient-based emphasis.
  static const primaryContainer = Color(0xFF2170E4);

  /// Success and completion color.
  static const secondary = Color(0xFF006C49);

  /// Soft progress fill for completed states.
  static const secondaryContainer = Color(0xFF6CF8BB);

  /// Urgency and missed-state color.
  static const tertiary = Color(0xFFB61722);

  /// Soft urgency background for non-blocking alerts.
  static const tertiaryContainer = Color(0xFFFFDAD9);

  /// Main app canvas.
  static const background = Color(0xFFF8F9FA);

  /// Base surface layer.
  static const surface = Color(0xFFF8F9FA);

  /// Grouping layer for larger sections.
  static const surfaceContainerLow = Color(0xFFF3F4F5);

  /// Interactive/topmost layer for cards and controls.
  static const surfaceContainerLowest = Color(0xFFFFFFFF);

  /// Input and secondary interactive layer.
  static const surfaceContainerHigh = Color(0xFFECEEF0);

  /// Neutral variant used for chips and subtle states.
  static const surfaceVariant = Color(0xFFE3E6EB);

  /// Premium soft black replacement for text.
  static const onSurface = Color(0xFF191C1D);

  /// Secondary text and metadata.
  static const onSurfaceVariant = Color(0xFF5D616B);

  /// Fallback border tone for accessibility.
  static const outlineVariant = Color(0xFFC2C6D6);

  /// 15% opacity ghost border fallback.
  static const ghostBorder = Color(0x26C2C6D6);
}

/// Reusable visual effects for premium interactions.
class AppEffects {
  /// Primary call-to-action gradient.
  static const ctaGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      AppColors.primary,
      AppColors.primaryContainer,
    ],
  );

  /// Ultra-diffused ambient shadow for floating elements.
  static const ambientShadow = [
    BoxShadow(
      color: Color.fromRGBO(25, 28, 29, 0.05),
      blurRadius: 32,
      offset: Offset(0, 8),
    ),
  ];
}
