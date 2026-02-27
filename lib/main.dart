import 'dart:io';

import 'package:brave_steve/game/presentation/menu_screen/main_menu.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    // 1. Wymagane, aby używać kodu natywnego przed startem UI
    //WidgetsFlutterBinding.ensureInitialized();

    // 2. Inicjalizacja menedżera okien
    await windowManager.ensureInitialized();

    // 3. Ustawienie opcji okna
    WindowOptions windowOptions = const WindowOptions(
      maximumSize: Size(500, 1000), // Ustawienie wielkości startowej
      minimumSize: Size(500, 1000), // Minimalna wielkość
      center: true, // Wyśrodkowanie okna na ekranie
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.normal,
      fullScreen: false,
      title: 'Brave Steve',
    );

    // 4. Czekamy aż okno będzie gotowe do pokazania
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) => 
    runApp(const ProviderScope(child:MyApp(),),),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Brave Steve',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const MainMenu(),
    );
  }
}