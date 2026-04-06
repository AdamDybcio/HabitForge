import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_forge/core/theme/colors.dart';

/// Defines the application's theme.
class AppTheme {
  static const _displayLargeSize = 52.0;
  static const _headlineLargeSize = 32.0;
  static const _headlineMediumSize = 24.0;
  static const _titleLargeSize = 20.0;
  static const _bodyMediumSize = 14.0;
  static const _labelSmallSize = 12.0;
  static const _buttonSize = 16.0;
  static const _textButtonSize = 15.0;

  static const _displayLargeHeight = 1.06;
  static const _headlineLargeHeight = 1.15;
  static const _headlineMediumHeight = 1.2;
  static const _titleLargeHeight = 1.25;
  static const _bodyMediumHeight = 1.45;
  static const _labelSmallHeight = 1.25;
  static const _labelSmallLetterSpacing = 0.6;

  static const _navigationBarOpacity = 0.8;
  static const _navigationBarHeight = 72.0;

  static const _darkBackground = Color(0xFF0E1116);
  static const _darkSurface = Color(0xFF0E1116);
  static const _darkSurfaceContainerLow = Color(0xFF181D26);
  static const _darkSurfaceContainerLowest = Color(0xFF121722);
  static const _darkSurfaceContainerHigh = Color(0xFF232A35);
  static const _darkSurfaceVariant = Color(0xFF2F3745);
  static const _darkOnSurface = Color(0xFFF1F3F6);
  static const _darkOnSurfaceVariant = Color(0xFFA7B0C0);
  static const _darkOutlineVariant = Color(0xFF3A4558);

  /// The light theme for the application.
  static final lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: _lightColorScheme,
    scaffoldBackgroundColor: AppColors.background,
    textTheme: _editorialTextTheme(
      ThemeData.light(useMaterial3: true).textTheme,
      onSurface: AppColors.onSurface,
      onSurfaceVariant: AppColors.onSurfaceVariant,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.surface,
      foregroundColor: AppColors.onSurface,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
    ),
    cardTheme: const CardThemeData(
      color: AppColors.surfaceContainerLowest,
      elevation: 0,
      shadowColor: Colors.transparent,
      shape: _shapeXl,
      margin: EdgeInsets.zero,
    ),
    listTileTheme: const ListTileThemeData(
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      iconColor: AppColors.onSurfaceVariant,
      textColor: AppColors.onSurface,
      shape: _shapeLg,
      tileColor: AppColors.surfaceContainerLowest,
    ),
    dividerTheme: const DividerThemeData(
      color: Colors.transparent,
      thickness: 0,
      space: 0,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surfaceContainerHigh,
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      labelStyle: TextStyle(
        color: AppColors.onSurfaceVariant,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primary, width: 2),
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.tertiary),
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.tertiary, width: 2),
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
    ),
    chipTheme: const ChipThemeData(
      backgroundColor: AppColors.surfaceVariant,
      selectedColor: AppColors.secondaryContainer,
      disabledColor: AppColors.surfaceContainerLow,
      deleteIconColor: AppColors.onSurfaceVariant,
      labelStyle: TextStyle(color: AppColors.onSurface),
      secondaryLabelStyle: TextStyle(color: Color(0xFF003824)),
      shape: StadiumBorder(side: BorderSide(color: Colors.transparent)),
      side: BorderSide.none,
      showCheckmark: false,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(52),
        shape: _shapeXl,
        elevation: 0,
        foregroundColor: Colors.white,
        textStyle: GoogleFonts.inter(
          fontWeight: FontWeight.w700,
          fontSize: _buttonSize,
        ),
        shadowColor: Colors.transparent,
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: const Size.fromHeight(52),
        shape: _shapeXl,
        elevation: 0,
        foregroundColor: Colors.white,
        backgroundColor: AppColors.primary,
        textStyle: GoogleFonts.inter(
          fontWeight: FontWeight.w700,
          fontSize: _buttonSize,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size.fromHeight(52),
        shape: _shapeXl,
        side: const BorderSide(color: AppColors.ghostBorder),
        foregroundColor: AppColors.primary,
        textStyle: GoogleFonts.inter(
          fontWeight: FontWeight.w700,
          fontSize: _buttonSize,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        textStyle: GoogleFonts.inter(
          fontWeight: FontWeight.w700,
          fontSize: _textButtonSize,
        ),
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColors.surface.withValues(
        alpha: _navigationBarOpacity,
      ),
      indicatorColor: AppColors.surfaceContainerLow,
      labelTextStyle: WidgetStatePropertyAll(
        GoogleFonts.inter(
          fontWeight: FontWeight.w600,
          fontSize: _labelSmallSize,
        ),
      ),
      iconTheme: const WidgetStatePropertyAll(
        IconThemeData(color: AppColors.onSurfaceVariant),
      ),
      elevation: 0,
      shadowColor: Colors.transparent,
      height: _navigationBarHeight,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      elevation: 0,
      hoverElevation: 0,
      focusElevation: 0,
      splashColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(24)),
      ),
    ),
  );

  /// The dark theme for the application.
  static final darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: _darkColorScheme,
    scaffoldBackgroundColor: _darkBackground,
    textTheme: _editorialTextTheme(
      ThemeData.dark(useMaterial3: true).textTheme,
      onSurface: _darkOnSurface,
      onSurfaceVariant: _darkOnSurfaceVariant,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: _darkSurface,
      foregroundColor: _darkOnSurface,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
    ),
    cardTheme: const CardThemeData(
      color: _darkSurfaceContainerLowest,
      elevation: 0,
      shadowColor: Colors.transparent,
      shape: _shapeXl,
      margin: EdgeInsets.zero,
    ),
    listTileTheme: const ListTileThemeData(
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      iconColor: _darkOnSurfaceVariant,
      textColor: _darkOnSurface,
      shape: _shapeLg,
      tileColor: _darkSurfaceContainerLowest,
    ),
    dividerTheme: const DividerThemeData(
      color: Colors.transparent,
      thickness: 0,
      space: 0,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: _darkSurfaceContainerHigh,
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      labelStyle: TextStyle(
        color: _darkOnSurfaceVariant,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primaryContainer, width: 2),
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.tertiary),
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.tertiary, width: 2),
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
    ),
    chipTheme: const ChipThemeData(
      backgroundColor: _darkSurfaceVariant,
      selectedColor: Color(0xFF134838),
      disabledColor: _darkSurfaceContainerLow,
      deleteIconColor: _darkOnSurfaceVariant,
      labelStyle: TextStyle(color: _darkOnSurface),
      secondaryLabelStyle: TextStyle(color: Color(0xFFC9FFDF)),
      shape: StadiumBorder(side: BorderSide(color: Colors.transparent)),
      side: BorderSide.none,
      showCheckmark: false,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(52),
        shape: _shapeXl,
        elevation: 0,
        foregroundColor: Colors.white,
        textStyle: GoogleFonts.inter(
          fontWeight: FontWeight.w700,
          fontSize: _buttonSize,
        ),
        shadowColor: Colors.transparent,
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: const Size.fromHeight(52),
        shape: _shapeXl,
        elevation: 0,
        foregroundColor: Colors.white,
        backgroundColor: AppColors.primaryContainer,
        textStyle: GoogleFonts.inter(
          fontWeight: FontWeight.w700,
          fontSize: _buttonSize,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size.fromHeight(52),
        shape: _shapeXl,
        side: const BorderSide(color: _darkOutlineVariant),
        foregroundColor: AppColors.primaryContainer,
        textStyle: GoogleFonts.inter(
          fontWeight: FontWeight.w700,
          fontSize: _buttonSize,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primaryContainer,
        textStyle: GoogleFonts.inter(
          fontWeight: FontWeight.w700,
          fontSize: _textButtonSize,
        ),
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: _darkSurface.withValues(alpha: _navigationBarOpacity),
      indicatorColor: _darkSurfaceContainerLow,
      labelTextStyle: WidgetStatePropertyAll(
        GoogleFonts.inter(
          fontWeight: FontWeight.w600,
          fontSize: _labelSmallSize,
        ),
      ),
      iconTheme: const WidgetStatePropertyAll(
        IconThemeData(color: _darkOnSurfaceVariant),
      ),
      elevation: 0,
      shadowColor: Colors.transparent,
      height: _navigationBarHeight,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryContainer,
      foregroundColor: Colors.white,
      elevation: 0,
      hoverElevation: 0,
      focusElevation: 0,
      splashColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(24)),
      ),
    ),
  );

  static const _shapeLg = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(16)),
  );

  static const _shapeXl = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(24)),
  );

  static final _lightColorScheme =
      ColorScheme.fromSeed(
        seedColor: AppColors.primary,
      ).copyWith(
        primary: AppColors.primary,
        onPrimary: Colors.white,
        primaryContainer: AppColors.primaryContainer,
        onPrimaryContainer: Colors.white,
        secondary: AppColors.secondary,
        onSecondary: Colors.white,
        secondaryContainer: AppColors.secondaryContainer,
        onSecondaryContainer: const Color(0xFF003824),
        tertiary: AppColors.tertiary,
        onTertiary: Colors.white,
        tertiaryContainer: AppColors.tertiaryContainer,
        onTertiaryContainer: const Color(0xFF410004),
        surface: AppColors.surface,
        onSurface: AppColors.onSurface,
        surfaceContainerLow: AppColors.surfaceContainerLow,
        surfaceContainerLowest: AppColors.surfaceContainerLowest,
        surfaceContainerHigh: AppColors.surfaceContainerHigh,
        onSurfaceVariant: AppColors.onSurfaceVariant,
        outlineVariant: AppColors.outlineVariant,
      );

  static final _darkColorScheme =
      ColorScheme.fromSeed(
        seedColor: AppColors.primaryContainer,
        brightness: Brightness.dark,
      ).copyWith(
        primary: AppColors.primaryContainer,
        onPrimary: Colors.white,
        primaryContainer: AppColors.primary,
        onPrimaryContainer: Colors.white,
        secondary: AppColors.secondaryContainer,
        onSecondary: const Color(0xFF003824),
        secondaryContainer: const Color(0xFF134838),
        onSecondaryContainer: const Color(0xFFC9FFDF),
        tertiary: AppColors.tertiaryContainer,
        onTertiary: const Color(0xFF5C1017),
        tertiaryContainer: const Color(0xFF5C1017),
        onTertiaryContainer: AppColors.tertiaryContainer,
        surface: _darkSurface,
        onSurface: _darkOnSurface,
        surfaceContainerLow: _darkSurfaceContainerLow,
        surfaceContainerLowest: _darkSurfaceContainerLowest,
        surfaceContainerHigh: _darkSurfaceContainerHigh,
        onSurfaceVariant: _darkOnSurfaceVariant,
        outlineVariant: _darkOutlineVariant,
      );

  static TextTheme _editorialTextTheme(
    TextTheme base, {
    required Color onSurface,
    required Color onSurfaceVariant,
  }) {
    final inter = GoogleFonts.interTextTheme(base).apply(
      bodyColor: onSurface,
      displayColor: onSurface,
    );

    return inter.copyWith(
      displayLarge: GoogleFonts.manrope(
        fontSize: _displayLargeSize,
        fontWeight: FontWeight.w700,
        height: _displayLargeHeight,
        color: onSurface,
      ),
      headlineLarge: GoogleFonts.manrope(
        fontSize: _headlineLargeSize,
        fontWeight: FontWeight.w700,
        height: _headlineLargeHeight,
        color: onSurface,
      ),
      headlineMedium: GoogleFonts.manrope(
        fontSize: _headlineMediumSize,
        fontWeight: FontWeight.w700,
        height: _headlineMediumHeight,
        color: onSurface,
      ),
      titleLarge: GoogleFonts.manrope(
        fontSize: _titleLargeSize,
        fontWeight: FontWeight.w700,
        height: _titleLargeHeight,
        color: onSurface,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: _bodyMediumSize,
        fontWeight: FontWeight.w400,
        height: _bodyMediumHeight,
        color: onSurface,
      ),
      labelSmall: GoogleFonts.inter(
        fontSize: _labelSmallSize,
        fontWeight: FontWeight.w600,
        height: _labelSmallHeight,
        letterSpacing: _labelSmallLetterSpacing,
        color: onSurfaceVariant,
      ),
    );
  }
}
