import 'package:flutter/material.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';

import 'screens/login.dart';

void main() {
  runApp(MaterialApp(
    title: 'Leave App',
    debugShowCheckedModeBanner: false,
    theme: FlexThemeData.light(
      scheme: FlexScheme.hippieBlue,
    ),
    darkTheme: FlexThemeData.dark(
        scheme: FlexScheme.hippieBlue, darkIsTrueBlack: true),
    home: const Login(),
  ));
}
