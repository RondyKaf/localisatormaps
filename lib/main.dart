import 'package:flutter/material.dart';
import 'package:localisatormaps/util/constants.dart';
import 'package:localisatormaps/views/screens/splash/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'localisator maps',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: RessourcesColor.COLOR_WHITE),
      home: const SplashScreen(),
    );
  }
}
