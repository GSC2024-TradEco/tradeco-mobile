import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  int view = 1;
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
        const TextField(
          decoration: InputDecoration(
            labelText: "Email",
          ),
        ),
        const SizedBox(height: 18),
        const TextField(
          decoration: InputDecoration(
            labelText: "Password",
          ),
        ),
        const SizedBox(height: 25),
        ElevatedButton(onPressed: () {}, child: Text("Login")),
        const SizedBox(height: 18),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Don't have any account? "),
            InkWell(
              onTap: () {
                print('tap');
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
        const TextField(
          decoration: InputDecoration(
            labelText: "Name",
          ),
        ),
        const SizedBox(height: 18),
        const TextField(
          decoration: InputDecoration(
            labelText: "Email",
          ),
        ),
        const SizedBox(height: 18),
        const TextField(
          decoration: InputDecoration(
            labelText: "Password",
          ),
        ),
        const SizedBox(height: 18),
        const TextField(
          decoration: InputDecoration(
            labelText: "Confirm Password",
          ),
        ),
        const SizedBox(height: 25),
        ElevatedButton(onPressed: () {}, child: Text("Register")),
        const SizedBox(height: 18),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Already have an account? "),
            InkWell(
              onTap: () {
                print('tap');
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
