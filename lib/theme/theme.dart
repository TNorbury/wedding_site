import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
      headlineMedium: GoogleFonts.ultra(
        fontWeight: FontWeight.w400,
        color: colorScheme.onSurface,
        fontSize: 28,
        letterSpacing: 1.25,
      ),
      titleMedium: GoogleFonts.playfair(
        fontWeight: FontWeight.w500,
        letterSpacing: 1.15,
        fontSize: 18,
        color: colorScheme.onSurface,
      ),
      titleLarge: GoogleFonts.playfair(
        fontWeight: FontWeight.w600,
        letterSpacing: 1.15,
        fontSize: 22,
        color: colorScheme.onSurface,
      ),
      bodyMedium: GoogleFonts.raleway(
        fontWeight: FontWeight.w400,
        letterSpacing: 1,
        fontSize: 14,
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
