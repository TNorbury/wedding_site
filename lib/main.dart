import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:wedding_site/routes/router.dart';
import 'package:wedding_site/theme/theme.dart';

void main() {
  usePathUrlStrategy();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final lightTheme = themeForBrightness(Brightness.light);
    return MaterialApp.router(
      title: 'Tyler + Missy 4 Every',
      theme: lightTheme,
      routerConfig: router,
    );
  }
}
