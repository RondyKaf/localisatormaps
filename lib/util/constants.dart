import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localisatormaps/views/screens/home/home_screen.dart';

//compteur
timer(BuildContext context) {
  Timer(const Duration(seconds: 5), () {
    Navigator.pushAndRemoveUntil(
        context,
        CupertinoPageRoute(builder: (context) => const HomeScreen()),
        (route) => false);
  });
}

class RessourcesColor {
  static const Color COLOR_BLACK = Colors.black;
  static const Color COLOR_WHITE = Colors.white;
  static const Color COLOR_GREEN = Colors.green;
  static const Color COLOR_BLUE = Colors.blue;
  static const Color COLOR_GREY = Colors.grey;
  static const Color COLOR_BLUEGREY = Colors.blueGrey;
}
const MARKER_SIZE_EXPAND = 55.0;
const MARKER_SIZE_SHRINK = 35.0;