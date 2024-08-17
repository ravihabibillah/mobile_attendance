import 'package:flutter/material.dart';
import 'package:mobile_attendance/features/home/home_screen.dart';
import 'package:mobile_attendance/utils/locator_service.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}
