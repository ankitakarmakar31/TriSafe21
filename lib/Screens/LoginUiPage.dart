import 'dart:ui';

import 'package:down_syndrome/Screens/DashBoard.dart';
import 'package:down_syndrome/Screens/SignUpPage.dart';
import 'package:down_syndrome/ServicesfromFirebase/auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginUiPage extends StatefulWidget {
  const LoginUiPage({Key? key}) : super(key: key);

  @override
  State<LoginUiPage> createState() => _LoginUiPageState();
}

class _LoginUiPageState extends State<LoginUiPage> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

//text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent[100],
      body: Center(
        child: Card(
          margin: EdgeInsets.all(20),
          color: Colors.white,
          shadowColor: Colors.transparent,
          elevation: 1.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .06,
                  ),
                  Image.asset(
                    'Assets/Images/welcome_login.jpg',
                    width: 200,
                    height: 180,
                    fit: BoxFit.fill,
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        hintText: 'Email',
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: Color(0xfff97d7d),
                        )),
                    validator: (val) => val!.isEmpty || !val.contains("@")
                        ? "Enter a valid Email"
                        : null,
                    onChanged: (val) {
                      setState(() => email = val);
                    },
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                        hintText: 'Password',
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                        prefixIcon: Icon(
                          Icons.edit,
                          color: Color(0xfff97d7d),
                        )),
                    validator: (val) =>
                        val!.length < 8 ? 'Enter the correct Password' : null,
                    onChanged: (val) {
                      setState(() => password = val);
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    child: MaterialButton(
                      color: const Color(0xfff97d7d),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      child: const Text(
                        'Sign In',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      onPressed: () async {
                        // print("sign in clicked ${}");
                        if (_formKey.currentState!.validate()) {
                          dynamic result = await _auth
                              .signInWithEmailAndPassword(email, password);
                          print("sign in result=${result}");

                          if (result == null) {
                            setState(() => error =
                                'could not sign in with those credentials');
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const DashBoard()),
                            );
                          }
                        }
                      },
                    ),
                  ),
                  SizedBox(
                      height: 30,
                      child: Text(
                        error,
                        style: const TextStyle(color: Colors.red, fontSize: 14),
                      )),
                  const SizedBox(
                    height: 30,
                  ),
                  RichText(
                    text: TextSpan(children: [
                      const TextSpan(
                        text: "I don't have an account! ",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 13),
                      ),
                      TextSpan(
                        text: 'Register',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (c, a1, a2) => const SignUpPage(),
                                transitionsBuilder: (c, anim, a2, child) =>
                                    FadeTransition(opacity: anim, child: child),
                                transitionDuration:
                                    const Duration(milliseconds: 1000),
                              ),
                            );
                          },
                        style: const TextStyle(
                            color: Color(0xffee0f37),
                            fontWeight: FontWeight.w700,
                            fontSize: 16),
                      ),
                    ]),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
