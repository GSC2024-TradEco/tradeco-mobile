import 'package:flutter/material.dart';
import 'package:zero_waste_application/ui/pages/auth_page.dart';
import 'package:zero_waste_application/ui/pages/home_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}
