import 'package:down_syndrome/Screens/DoctorProfile.dart';
import 'package:down_syndrome/controller/AccountLoginController.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:sizer/sizer.dart';

import '../Screens/SignUpPage.dart';

class AccountLogin extends StatefulWidget {
  const AccountLogin({Key? key}) : super(key: key);

  @override
  State<AccountLogin> createState() => AccountLoginState();
}

class AccountLoginState extends State<AccountLogin> {
  var controller = AccountLoginController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  Widget customTypeCard(imageLink, VoidCallback onTap, {type: ''}) {
    return Obx(
      () => InkWell(
        onTap: onTap,
        child: CircleAvatar(
          radius: 65,
          backgroundColor: Colors.white,
          child: CircleAvatar(
            radius: 60,
            backgroundColor: controller.currentType == type
                ? Colors.redAccent[100]
                : Colors.white,
            child: CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(imageLink),
              // child: Image.network(imageLink, fit: BoxFit.fill),
            ),
          ),
        ),
      ),
    );
  }

  Widget gap({h: 0.0, w: 0.0}) {
    return SizedBox(height: h, width: w);
  }

  Widget customButton() {
    return TextButton.icon(
      onPressed: () async {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email.text, password: password.text);
      },
      icon: Icon(Icons.arrow_circle_right_sharp, color: Colors.black),
      label: Text('Login'.toUpperCase(), style: TextStyle(color: Colors.black)),
      style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.black)))),
    );
  }

  Widget customTextField(
    controller, {
    hintText: '',
    icon: Icons.access_alarms_rounded,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width / 1.2,
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
              focusColor: Colors.white,
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.white)),
              prefixIcon: Icon(icon, color: Colors.redAccent[100]),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.redAccent.shade100)),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.redAccent.shade100)),
              filled: true,
              hintStyle: TextStyle(color: Colors.grey[800]),
              hintText: hintText,
              fillColor: Colors.white70),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.redAccent[100],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(children: [
            Center(
                child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Choose Account Type',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            )),
            gap(h: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  customTypeCard(
                      'https://cdn-icons-png.flaticon.com/512/3209/3209993.png',
                      () {
                    controller.currentType.value = 'patient';
                    controller.setCurrentType('patient');
                  }, type: 'patient'),
                  SizedBox(
                    width: 30,
                  ),
                  customTypeCard(
                      'https://media.istockphoto.com/vectors/doctor-with-stethoscope-and-medical-test-medic-icon-in-flat-style-vector-id1129223269?k=20&m=1129223269&s=612x612&w=0&h=rfQO9jF2s8OZCtxV4CcRhF4hMPxg6_h2Au7D7bcBTwk=',
                      () {
                    controller.currentType.value = 'doctor';
                    controller.setCurrentType('doctor');
                  }, type: 'doctor'),
                ],
              ),
            ),
            Obx(() => Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    '${controller.welcomeText}',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                )),
            customTextField(
              email,
              hintText: "Enter your username",
              icon: Icons.person_outline,
            ),
            customTextField(password,
                hintText: "Enter your password", icon: Icons.lock),
            gap(h: 10.0),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text('No Account?'),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (c, a1, a2) =>
                                    //  DoctorProfile()
                                    const SignUpPage(),
                                transitionsBuilder: (c, anim, a2, child) =>
                                    FadeTransition(opacity: anim, child: child),
                                transitionDuration:
                                    const Duration(milliseconds: 1000),
                              ),
                            );
                          },
                          child: Text(
                            'Register',
                            style: TextStyle(color: Colors.white),
                          )),
                    ],
                  ),
                  customButton()
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
