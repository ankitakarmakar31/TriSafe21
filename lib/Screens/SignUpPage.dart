import 'dart:ui';

import 'package:down_syndrome/Screens/LoginUiPage.dart';
import 'package:down_syndrome/Screens/UserProfile.dart';
import 'package:down_syndrome/ServicesfromFirebase/auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isActive = false;

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
      /*appBar: AppBar(
        title: Text("Welcome"),
        centerTitle: true,
        backgroundColor: Colors.redAccent[200],
      ),*/
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
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .06,
                  ),
                  Image.asset(
                    'Assets/Images/signup.png',
                    width: 200,
                    height: 180,
                    fit: BoxFit.fill,
                  ),
                  const SizedBox(
                    height: 34,
                  ),
                  const Text(
                    'Welcome to TriSafe21',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                        color: Colors.indigo),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  /*const TextField(
                    decoration: InputDecoration(
                        hintText: 'Full Name',
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                        prefixIcon: Icon(
                          Icons.person_outline_sharp,
                          size: 22,
                          color: Color(0xfff97d7d),
                        )),
                  ),
                  const SizedBox(
                    height: 14,
                  ),*/
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
                      setState ( () => email = val);
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
                        ),
                        suffixIcon: Icon(Icons.remove_red_eye)
                    ),
                    validator: (val) => val!.length<8 ? 'Enter a Strong Password' : null,
                    onChanged: (val) {
                      setState ( () => password = val);
                    },

                  ),
                  /*Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(
                        value: isActive,
                        onChanged: (value) => setState(() {
                          isActive = value!;
                        }),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: Text(
                          'I agree whit the terms and conditions\nand privacy policy',
                          style: TextStyle(color: Colors.grey[400] , fontSize: 10),
                        ),
                      ),
                    ],
                  ),*/
                  const SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    child: MaterialButton(
                      color: const Color(0xfff97d7d),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      child: const Text(
                        'Register',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          dynamic result = await _auth
                              .registerWithEmailAndPassword(email, password);
                          if (result == null) {
                            setState(() =>
                            error = 'please supply valid credentials');
                          }
                        }
                        Navigator.pop(context);
                        await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const UserProfile()),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30,
                    child: Text(
                      error,
                      style: const TextStyle(color : Colors.red, fontSize : 14),
                    )
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Back to Login',
                      recognizer: TapGestureRecognizer()..onTap = () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginUiPage(),
                            )
                        );
                      },
                    style: const TextStyle(
                        color: Color(0xffee0f37),
                        fontWeight: FontWeight.w700,
                        fontSize: 12
                    )
                    )
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}