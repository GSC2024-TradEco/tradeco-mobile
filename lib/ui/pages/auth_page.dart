import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zero_waste_application/controllers/authentication.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  int view = 0;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool passwordsMatch = true;

  AuthController authController = AuthController();
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(50),
        child: view == 0 ? loginView() : regisView(),
      ),
    );
  }

  Widget loginView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 116,
          height: 114,
          margin: EdgeInsets.only(bottom: 77),
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        ),
        TextField(
          controller: emailController,
          decoration: InputDecoration(
            labelText: "Email",
          ),
        ),
        const SizedBox(height: 18),
        TextField(
          controller: passwordController,
          obscureText: true,
          decoration: InputDecoration(
            labelText: "Password",
          ),
        ),
        const SizedBox(height: 25),
        ElevatedButton(
            onPressed: () async {
              String email = emailController.text;
              String password = passwordController.text;
              try {
                UserCredential user = await _auth.signInWithEmailAndPassword(
                  email: email,
                  password: password,
                );
              } catch (e) {
                // An error occurred, handle it accordingly
                print('Login failed: $e');
                // You can also show an error message to the user
              }
            },
            child: Text("Login")),
        const SizedBox(height: 18),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Don't have any account? "),
            InkWell(
              onTap: () {
                setState(() {
                  view = 1;
                  nameController.text = "";
                  emailController.text = "";
                  passwordController.text = "";
                  confirmPasswordController.text = "";
                });
              },
              child: const Text(
                "Register Here",
                style: TextStyle(color: Colors.blue),
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget regisView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 116,
          height: 114,
          margin: EdgeInsets.only(bottom: 77),
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        ),
        TextField(
          controller: nameController,
          decoration: InputDecoration(
            labelText: "Name",
          ),
        ),
        const SizedBox(height: 18),
        TextField(
          controller: emailController,
          decoration: InputDecoration(
            labelText: "Email",
          ),
        ),
        const SizedBox(height: 18),
        TextField(
          controller: passwordController,
          obscureText: true,
          decoration: InputDecoration(
            labelText: "Password",
          ),
          onChanged: (value) {
            setState(() {
              passwordsMatch = (value == confirmPasswordController.text);
            });
          },
        ),
        const SizedBox(height: 18),
        TextField(
          controller: confirmPasswordController,
          obscureText: true,
          decoration: InputDecoration(
              labelText: "Confirm Password",
              errorText: passwordsMatch ? null : "Passwords do not match"),
          onChanged: (value) {
            setState(() {
              passwordsMatch = (value == passwordController.text);
            });
          },
        ),
        const SizedBox(height: 25),
        ElevatedButton(
            onPressed: () {
              authController.register(nameController.text, emailController.text,
                  passwordController.text);
            },
            child: Text("Register")),
        const SizedBox(height: 18),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Already have an account? "),
            InkWell(
              onTap: () {
                setState(() {
                  view = 0;
                  nameController.text = "";
                  emailController.text = "";
                  passwordController.text = "";
                  confirmPasswordController.text = "";
                });
              },
              child: const Text(
                "Login Here",
                style: TextStyle(color: Colors.blue),
              ),
            )
          ],
        ),
      ],
    );
  }
}
