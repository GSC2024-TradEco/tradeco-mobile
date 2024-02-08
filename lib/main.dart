import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:zero_waste_application/ui/pages/main_page.dart';

List<CameraDescription> cameras = [];
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print("${e.code} ${e.description}");
  }
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(cam: cameras.first),
    );
  }
}
