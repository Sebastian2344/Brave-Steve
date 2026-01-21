import 'package:brave_steve/game/presentation/menu_screen/main_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
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