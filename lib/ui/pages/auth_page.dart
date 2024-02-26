import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:zero_waste_application/controllers/authentication.dart';
import 'package:zero_waste_application/ui/pages/main_page.dart';
import 'package:zero_waste_application/ui/styles/custom_theme.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  int? view;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool passwordMatch = false;
  bool isLoading = false;
  List<CameraDescription> cameras = [];

  AuthController authController = AuthController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    setupCamera();
  }

  setupCamera() async {
    try {
      cameras = await availableCameras().whenComplete(() {
        setState(() {});
      });
    } on CameraException catch (e) {
      print("${e.code} ${e.description}");
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: view == 0 ? false : true,
      body: Container(
        padding: const EdgeInsets.all(8),
        child: Stack(children: [
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : const SizedBox(),
          view == null
              ? landingView()
              : view == 0
                  ? loginView()
                  : regisView(),
        ]),
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
                "Trade, Create, Elevate",
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
                  // Text(
                  //   "or",
                  //   style: GoogleFonts.lato(
                  //     textStyle: const TextStyle(fontWeight: FontWeight.w300),
                  //   ),
                  // ),
                  // SizedBox(
                  //   width: 252,
                  //   height: 44,
                  //   child: SignInButton(
                  //     Buttons.google,
                  //     onPressed: () {},
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(5),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget loginView() {
    return Padding(
      padding: const EdgeInsets.all(45),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 170,
            height: 173,
            margin: const EdgeInsets.only(bottom: 27),
            child:
                Image.asset("assets/images/logos/tradeco logo with name.png"),
          ),
          Text(
            "Login",
            style: GoogleFonts.robotoSlab(
              textStyle: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: emailController,
            decoration: const InputDecoration(
              labelText: "Email",
            ),
          ),
          const SizedBox(height: 18),
          TextField(
            controller: passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: "Password",
            ),
          ),
          const SizedBox(height: 25),
          SizedBox(
            width: 252,
            height: 44,
            child: ElevatedButton(
              onPressed: () async {
                String email = emailController.text;
                String password = passwordController.text;
                setState(() {
                  isLoading = true;
                });
                try {
                  await _auth.signInWithEmailAndPassword(
                    email: email,
                    password: password,
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MainPage(cam: cameras.first),
                    ),
                  );
                  setState(() {
                    isLoading = false;
                  });
                } catch (e) {
                  setState(() {
                    isLoading = false;
                  });
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Login Failed'),
                        content: Text('$e'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: CustomTheme.color.base1,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: const Text("Login"),
            ),
          ),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Don't have any account? "),
              InkWell(
                onTap: () {
                  setState(() {
                    nameController.text = "";
                    emailController.text = "";
                    passwordController.text = "";
                    confirmPasswordController.text = "";
                    view = 1;
                  });
                },
                child: Text(
                  "Register Here",
                  style: TextStyle(color: CustomTheme.color.base1),
                ),
              )
            ],
          ),
          // const SizedBox(height: 18),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Expanded(
          //       child: Container(
          //         width: double.infinity,
          //         decoration: BoxDecoration(
          //           border: Border.all(color: Colors.black, width: 0.25),
          //         ),
          //       ),
          //     ),
          //     const Text("  Or  "),
          //     Expanded(
          //       child: Container(
          //         width: double.infinity,
          //         decoration: BoxDecoration(
          //           border: Border.all(color: Colors.black, width: 0.25),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          // const SizedBox(height: 18),
          // SizedBox(
          //   width: 252,
          //   height: 44,
          //   child: SignInButton(
          //     Buttons.google,
          //     onPressed: () {},
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(5),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget regisView() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 45,
          right: 45,
          top: 100,
          bottom: 20,
        ),
        child: Column(
          children: [
            Container(
              width: 170,
              height: 173,
              margin: const EdgeInsets.only(bottom: 27),
              child:
                  Image.asset("assets/images/logos/tradeco logo with name.png"),
            ),
            Text(
              "Register",
              style: GoogleFonts.robotoSlab(
                textStyle: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Name",
              ),
            ),
            const SizedBox(height: 18),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: "Email",
              ),
            ),
            const SizedBox(height: 18),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password",
              ),
              onChanged: (value) {
                setState(() {
                  passwordMatch = (value == confirmPasswordController.text);
                });
              },
            ),
            const SizedBox(height: 18),
            TextField(
              controller: confirmPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Confirm Password",
              ),
              onChanged: (value) {
                setState(() {
                  passwordMatch = (value == passwordController.text);
                });
              },
            ),
            if (!passwordMatch)
              const Text(
                'Passwords do not match',
                style: TextStyle(color: Colors.red),
              ),
            const SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              height: 44,
              child: ElevatedButton(
                onPressed: passwordMatch
                    ? () async {
                        setState(() {
                          isLoading = true;
                        });
                        bool success = await authController.register(
                          nameController.text,
                          emailController.text,
                          passwordController.text,
                        );
                        setState(() {
                          isLoading = false;
                        });

                        if (success) {
                          setState(() {
                            nameController.text = "";
                            emailController.text = "";
                            passwordController.text = "";
                            confirmPasswordController.text = "";
                            view = 0;
                          });
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Register Failed'),
                                content: const Text(
                                    'Try using another email address'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      }
                    : null,
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
            const SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account? ",
                  style: GoogleFonts.lato(),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      nameController.text = "";
                      emailController.text = "";
                      passwordController.text = "";
                      confirmPasswordController.text = "";
                      view = 0;
                    });
                  },
                  child: Text(
                    "Login Here",
                    style: TextStyle(color: CustomTheme.color.base1),
                  ),
                )
              ],
            ),
            // const SizedBox(height: 18),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Expanded(
            //       child: Container(
            //         width: double.infinity,
            //         decoration: BoxDecoration(
            //           border: Border.all(color: Colors.black, width: 0.25),
            //         ),
            //       ),
            //     ),
            //     const Text("  Or  "),
            //     Expanded(
            //       child: Container(
            //         width: double.infinity,
            //         decoration: BoxDecoration(
            //           border: Border.all(color: Colors.black, width: 0.25),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            // const SizedBox(height: 18),
            // SizedBox(
            //   width: 252,
            //   height: 44,
            //   child: SignInButton(
            //     Buttons.google,
            //     onPressed: () {},
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(5),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
