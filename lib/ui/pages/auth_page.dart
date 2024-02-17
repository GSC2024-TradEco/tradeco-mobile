// ignore_for_file: unnecessary_null_comparison, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:zero_waste_application/ui/styles/custom_theme.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: view == 0 ? false : true,
      body: Container(
        padding: const EdgeInsets.all(8),
        child: view == null
            ? landingView()
            : view == 0
                ? loginView()
                : regisView(),
      ),
    );
  }

  Widget landingView() {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 90),
              Image.asset(
                'assets/images/backgrounds/earth collab.png',
                width: 300,
              ),
              Text(
                "Welcome to TradEco",
                style: GoogleFonts.robotoSlab(
                  textStyle: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Text(
                "Transform Waste into DIY Wonders:",
                style: GoogleFonts.lato(
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              Text(
                "Trade, Creative, Elevate",
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: CustomTheme.color.base1,
                  ),
                ),
              ),
            ],
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 76),
              child: Column(
                children: [
                  SizedBox(
                    width: 252,
                    height: 44,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          view = 1;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CustomTheme.color.base1,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: const Text("Register"),
                    ),
                  ),
                  const SizedBox(height: 22),
                  SizedBox(
                    width: 252,
                    height: 44,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          view = 0;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: CustomTheme.color.base1,
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: const Text("Login"),
                    ),
                  ),
                  Text(
                    "or",
                    style: GoogleFonts.lato(
                      textStyle: const TextStyle(fontWeight: FontWeight.w300),
                    ),
                  ),
                  SizedBox(
                    width: 252,
                    height: 44,
                    child: SignInButton(
                      Buttons.google,
                      onPressed: () {},
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
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
                await FirebaseAuth.instance.signInWithEmailAndPassword(
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
