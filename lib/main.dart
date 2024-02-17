import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zero_waste_application/firebase_options.dart';
import 'package:zero_waste_application/ui/pages/main_page.dart';
import 'firebase_options.dart';
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
      home: AuthenticationWrapper(),
      theme: ThemeData(scaffoldBackgroundColor: CustomTheme.color.background1),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // or a loading indicator
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData && snapshot.data != null) {
          return MainPage(cam: cameras.first);
        } else {
          return AuthPage();
        }
      },
    );
  }
}
