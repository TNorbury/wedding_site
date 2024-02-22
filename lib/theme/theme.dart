import 'package:flutter/material.dart';
import 'package:wedding_site/theme/color_scheme.dart';

ThemeData themeForBrightness(Brightness brightness) {
  final colorScheme = switch (brightness) {
    Brightness.dark => darkColorScheme,
    Brightness.light => lightColorScheme,
  };

  final theme = ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    textTheme: TextTheme(
      headlineMedium: TextStyle(
        fontFamily: "Ultra",
        fontWeight: FontWeight.w400,
        color: colorScheme.onSurface,
        fontSize: 28,
        letterSpacing: 1.25,
      ),
      titleMedium: TextStyle(
        fontFamily: "Playfair",
        fontWeight: FontWeight.w500,
        fontSize: 18,
        color: colorScheme.onSurface,
      ),
      titleLarge: TextStyle(
        fontFamily: "Playfair",
        fontWeight: FontWeight.w600,
        fontSize: 22,
        color: colorScheme.onSurface,
      ),
      bodyLarge: TextStyle(
        fontFamily: "Raleway",
        fontWeight: FontWeight.w600,
        letterSpacing: 1.25,
        fontSize: 18,
        color: colorScheme.onSurface,
      ),
      bodyMedium: TextStyle(
        fontFamily: "Raleway",
        fontWeight: FontWeight.w600,
        letterSpacing: 1.15,
        fontSize: 16,
        color: colorScheme.onSurface,
      ),
      bodySmall: TextStyle(
        fontFamily: "Raleway",
        fontWeight: FontWeight.w600,
        letterSpacing: 1.04,
        fontSize: 14,
        color: colorScheme.onSurface,
      ),
      labelLarge: TextStyle(
        fontFamily: "Raleway",
        fontWeight: FontWeight.w500,
        letterSpacing: 1.01,
        fontSize: 14,
        color: colorScheme.onSurface,
      ),
      labelMedium: TextStyle(
        fontFamily: "Raleway",
        fontWeight: FontWeight.w500,
        letterSpacing: 1.05,
        fontSize: 12,
        color: colorScheme.onSurface,
      ),
      labelSmall: TextStyle(
        fontFamily: "Raleway",
        fontWeight: FontWeight.w500,
        letterSpacing: 1.05,
        fontSize: 11,
        color: colorScheme.onSurface,
      ),
    ),
  );

  return theme;
}

/// Convenience function to get the context theme's color scheme
ColorScheme colorSchemeOf(BuildContext context) =>
    Theme.of(context).colorScheme;

/// Convenience function to get the context theme's text theme
TextTheme textThemeOf(BuildContext context) => Theme.of(context).textTheme;

extension TextStyleX on TextStyle? {
  TextStyle? withColor(Color color) => this?.merge(TextStyle(color: color));
}
