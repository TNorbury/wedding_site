import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:wedding_site/firebase_options.dart';
import 'package:wedding_site/routes/router.dart';
import 'package:wedding_site/theme/theme.dart';

Future<void> main() async {
  usePathUrlStrategy();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, ref) {
    final lightTheme = themeForBrightness(Brightness.light);
    return MaterialApp.router(
      title: 'Tyler + Missy 4 Ever',
      theme: lightTheme,
      routerConfig: router(ref),
    );
  }
}
