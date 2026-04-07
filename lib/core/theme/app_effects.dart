import 'package:flutter/material.dart';
import 'package:habit_forge/core/theme/colors.dart';

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
