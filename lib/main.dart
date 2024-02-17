import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:zero_waste_application/firebase_options.dart';
import 'package:zero_waste_application/ui/pages/auth_page.dart';
import 'package:zero_waste_application/ui/styles/custom_theme.dart';

List<CameraDescription> cameras = [];
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print("${e.code} ${e.description}");
  } catch (e) {
    print(e);
  }
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AuthPage(cam: cameras.first),
      theme: ThemeData(scaffoldBackgroundColor: CustomTheme.color.background1),
    );
  }
}
