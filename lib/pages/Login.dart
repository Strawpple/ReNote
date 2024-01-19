import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:renote/components/extensions.dart';
import 'package:renote/components/utils.dart';
import 'package:renote/main.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final CollectionReference account =
      FirebaseFirestore.instance.collection('user_accounts');

  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: RichText(
          text: TextSpan(
            children: [
              WidgetSpan(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                // child: Container(
                //     height: 70, child: Image.asset('lib/assets/images/J.png')),
              )),
            ],
          ),
        ),
      ),
      body: Center(child: loginform()),
    );
  }

  Widget loginform() => Container(
        height: 600,
        width: 600,
        child: Card(
            color: '#F5F5F5'.toColor(),
            // color: '#E3F4F4'.toColor(),
            child: Column(
              children: [
                Container(
                  child: SizedBox(height: 30),
                ),
                Container(
                  height: 200,
                  width: 250,
                  child: Image.asset('lib/assets/images/jmave.png'),
                ),
                Container(
                  child: SizedBox(
                    height: 20,
                  ),
                ),
                Container(
                  child: Text(
                    "ReNote",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  child: SizedBox(height: 20),
                ),
                Container(
                  child: Column(
                    children: [
                      Container(
                        child: SizedBox(
                          width: 300,
                          child: TextFormField(
                            controller: emailController,
                            cursorColor: Colors.white,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(labelText: "Email"),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (email) =>
                                email != null && !EmailValidator.validate(email)
                                    ? 'Enter a valid email'
                                    : null,
                          ),
                        ),
                      ),
                      Container(
                        child: SizedBox(
                            width: 300,
                            child: TextFormField(
                              obscureText: true,
                              controller: passwordController,
                              cursorColor: Colors.white,
                              textInputAction: TextInputAction.next,
                              decoration:
                                  InputDecoration(labelText: "Password"),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) =>
                                  value != null && value.length < 6
                                      ? 'Enter min. 6 characters'
                                      : null,
                            )),
                      ),
                      Container(
                        child: SizedBox(
                          height: 50,
                        ),
                      ),
                      Container(
                        child: SizedBox(
                          width: 200,
                          height: 60,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                minimumSize: Size.fromHeight(40)),
                            icon: Icon(
                              Icons.lock_open,
                              size: 30,
                            ),
                            label: Text(
                              'Sign In',
                              style: TextStyle(fontSize: 24),
                            ),
                            onPressed: signIn,
                          ),
                        ),
                      ),
                      Container(
                        child: SizedBox(height: 15),
                      ),
                      // Container(
                      //   height: 50,
                      //   width: 250,
                      //   child: ElevatedButton(
                      //     onPressed: () async {
                      //       googlesignin();
                      //     },
                      //     child: Row(
                      //       children: [
                      //         Container(
                      //             child: Icon(
                      //           FontAwesomeIcons.google,
                      //           color: Colors.red,
                      //         )

                      //             // FaIcon(
                      //             //   FontAwesomeIcons.google,
                      //             // ),
                      //             ),
                      //         Container(
                      //           child: SizedBox(width: 15),
                      //         ),
                      //         Container(
                      //           child: Text(
                      //             "Sign in Using Google",
                      //             style: TextStyle(color: Colors.black),
                      //           ),
                      //         )
                      //       ],
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                )
              ],
            )),
      );

  Future signIn() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
              child: CircularProgressIndicator(),
            ));
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      print(e);
      Utils.showSnackBar(e.message);
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
