import 'package:almanara/features/home/views/home_screen.dart';
import 'package:almanara/theme/light_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const AlmanaraApp());
}

class AlmanaraApp extends StatelessWidget {
  const AlmanaraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'almanara',
        theme: LightTheme.data,
        darkTheme: LightTheme.data,
        home: HomeScreen());
  }
}
