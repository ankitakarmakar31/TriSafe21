import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:down_syndrome/models/user_model.dart';
import 'package:down_syndrome/services/AuthService.dart';
import 'package:down_syndrome/view/DoctorPageView.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:down_syndrome/Screens/LoginUiPage.dart';
import 'package:down_syndrome/Screens/UserProfile.dart';
import 'package:down_syndrome/ServicesfromFirebase/auth.dart';
import 'package:down_syndrome/controller/AccountLoginController.dart';
import 'package:down_syndrome/view/AccountLoginView.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../controller/AccountSignupController.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isActive = false;

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  var controller = Get.put(AccountSignUpController());
//text field state
  TextEditingController email = new TextEditingController();
  String password = '';
  String error = '';
  String name = '';

  TextEditingController docExp = new TextEditingController();
  TextEditingController docLocation = new TextEditingController();
  TextEditingController docFees = new TextEditingController();
  TextEditingController docSpeciality = new TextEditingController();
  TextEditingController docdsExp = new TextEditingController();
  Widget customTypeCard(imageLink, VoidCallback onTap, {type: ''}) {
    return Obx(
      () => InkWell(
        hoverColor: Colors.white,
        borderRadius: BorderRadius.circular(60),
        focusColor: Colors.white,
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

  Widget _customDropDownExample(BuildContext context, selectedItem, title) {
    List<String> imageList = [
      'https://cdn-icons-png.flaticon.com/512/196/196121.png',
      'https://cdn-icons-png.flaticon.com/512/196/196121.png'
    ];

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        child: ListTile(
          leading: (selectedItem != null)
              ? CircleAvatar(
                  backgroundImage: NetworkImage('${imageList[0]}'),
                )
              : null,
          title: Text(
            selectedItem != null ? selectedItem : title,
            style: TextStyle(
                color: (selectedItem != null) ? Colors.black : Colors.grey,
                fontSize: 15),
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
      icon: Icon(Icons.alarm),
      label: Obx(
        () => Text("${controller.selectedTime}".toUpperCase(),
            style: TextStyle(fontSize: 14)),
      ),
      style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.red)))),
      onPressed: () async {
        final TimeOfDay? timeOfDay = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );
        if (timeOfDay != null) {
          controller.selectedTime.value = timeOfDay.format(context).toString();
        }
      },
    );
  }

  Widget weekdaySelector() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: ListView.separated(
          separatorBuilder: (context, index) => SizedBox(width: 10),
          itemCount: controller.weekdayBool.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => InkWell(
                onTap: () {
                  controller.weekdayBool[index] =
                      !controller.weekdayBool[index];
                  controller.weekdayBool.refresh();
                },
                child: Obx(
                  () => CircleAvatar(
                    radius: 25,
                    backgroundColor: controller.weekdayBool.value[index]
                        ? Colors.white
                        : Colors.redAccent,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: controller.weekdayBool[index]
                          ? Colors.redAccent
                          : Colors.white,
                      child: Text('${controller.weekdayList[index]}',
                          style: TextStyle(
                              color: controller.weekdayBool[index]
                                  ? Colors.white
                                  : Colors.redAccent.shade100)),
                    ),
                  ),
                ),
              )),
    );
  }

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
        child: SingleChildScrollView(
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
                child: Obx(
                  () => Column(
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            'Welcome ${controller.currentType.value == 'doctor' ? 'Doctor' : 'User'}!',
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold)),
                      ),
                      // controller.currentType.value == 'doctor'
                      //     ? TextFormField(
                      //         decoration: const InputDecoration(
                      //             hintText: 'Name',
                      //             hintStyle: TextStyle(
                      //                 color: Colors.grey, fontSize: 14),
                      //             prefixIcon: Icon(
                      //               Icons.account_box,
                      //               color: Color(0xfff97d7d),
                      //             )),
                      //         validator: (val) =>
                      //             val!.isEmpty ? "Enter your name" : null,
                      //         onChanged: (val) {
                      //           setState(() => name = val);
                      //         },
                      //       )
                      //     : Container(),
                      TextFormField(
                        controller: email,
                        decoration: const InputDecoration(
                            hintText: 'Email',
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 14),
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              color: Color(0xfff97d7d),
                            )),
                        validator: (val) =>
                            email.text.isEmpty || !email.text.contains("@")
                                ? "Enter a valid Email"
                                : null,
                        onChanged: (val) {},
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      TextFormField(
                        obscureText: true,
                        decoration: const InputDecoration(
                            hintText: 'Password',
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 14),
                            prefixIcon: Icon(
                              Icons.edit,
                              color: Color(0xfff97d7d),
                            ),
                            suffixIcon: Icon(Icons.remove_red_eye)),
                        validator: (val) =>
                            val!.length < 8 ? 'Enter a Strong Password' : null,
                        onChanged: (val) {
                          setState(() => password = val);
                        },
                      ),
                      // TextFormField(
                      //   decoration: const InputDecoration(
                      //       hintText: 'Name',
                      //       hintStyle:
                      //           TextStyle(color: Colors.grey, fontSize: 14),
                      //       prefixIcon: Icon(
                      //         Icons.email_outlined,
                      //         color: Color(0xfff97d7d),
                      //       )),
                      //   validator: (val) =>
                      //       val!.isEmpty ? "Enter your name" : null,
                      //   onChanged: (val) {
                      //     setState(() => email = val);
                      //   },
                      // ),
                      // controller.currentType.value == "doctor"
                      //     ? TextFormField(
                      //         controller: docLocation,
                      //         decoration: const InputDecoration(
                      //             hintText: 'Address',
                      //             hintStyle: TextStyle(
                      //                 color: Colors.grey, fontSize: 14),
                      //             prefixIcon: Icon(
                      //               Icons.account_box,
                      //               color: Color(0xfff97d7d),
                      //             )),
                      //       )
                      //     : Container(),
                      // controller.currentType.value == "doctor"
                      //     ? TextFormField(
                      //         controller: docExp,
                      //         keyboardType: TextInputType.number,
                      //         decoration: const InputDecoration(
                      //             hintText: 'Years of Exp',
                      //             suffix: Text('Yrs'),
                      //             hintStyle: TextStyle(
                      //                 color: Colors.grey, fontSize: 14),
                      //             prefixIcon: Icon(
                      //               Icons.numbers,
                      //               color: Color(0xfff97d7d),
                      //             )),
                      //       )
                      //     : Container(),
                      // controller.currentType.value == "doctor"
                      //     ? TextFormField(
                      //         controller: docdsExp,
                      //         keyboardType: TextInputType.number,
                      //         decoration: const InputDecoration(
                      //             hintText: 'Years of Exp in Down Syndrome',
                      //             suffix: Text('Yrs'),
                      //             hintStyle: TextStyle(
                      //                 color: Colors.grey, fontSize: 14),
                      //             prefixIcon: Icon(
                      //               Icons.numbers,
                      //               color: Color(0xfff97d7d),
                      //             )),
                      //       )
                      //     : Container(),
                      // controller.currentType.value == "doctor"
                      //     ? Padding(
                      //         padding: const EdgeInsets.all(8.0),
                      //         child: TextFormField(
                      //           controller: docFees,
                      //           keyboardType: TextInputType.number,
                      //           decoration: const InputDecoration(
                      //             hintText: 'Consultation Fees',

                      //             hintStyle: TextStyle(
                      //                 color: Colors.grey, fontSize: 14),
                      //             prefixIcon: Text(' \u{20B9}',
                      //                 style: TextStyle(
                      //                     color: Colors.redAccent,
                      //                     fontSize: 30,
                      //                     fontWeight: FontWeight.w300)),

                      //             // Icon(
                      //             //   Icons.account_box,
                      //             //   color: Color(0xfff97d7d),
                      //             // )
                      //           ),
                      //         ),
                      //       )
                      //     : Container(),
                      // gap(h: 10.0),
                      // controller.currentType.value == 'doctor'
                      //     ? customButton()
                      //     : Container(),
                      // gap(h: 10.0),
                      // controller.currentType.value == 'doctor'
                      //     ? Padding(
                      //         padding: const EdgeInsets.all(8.0),
                      //         child: Container(
                      //             width: MediaQuery.of(context).size.width,
                      //             child: Text(
                      //               'Select Available days:',
                      //               style: TextStyle(
                      //                   color: Colors.redAccent.shade100),
                      //             )),
                      //       )
                      //     : Container(),
                      // controller.currentType.value == 'doctor'
                      //     ? weekdaySelector()
                      //     : Container(),

                      // gap(h: 10.0),
                      // controller.currentType.value == "doctor"
                      //     ? Padding(
                      //         padding: const EdgeInsets.all(8.0),
                      //         child: DropdownSearch(
                      //           showClearButton: true,
                      //           onChanged: (s) {
                      //             docSpeciality.value =
                      //                 TextEditingValue(text: '$s');
                      //           },
                      //           dropdownBuilder: (context, selectedItem) =>
                      //               _customDropDownExample(context,
                      //                   selectedItem, "Select Your Speciality"),
                      //           popupShape: RoundedRectangleBorder(
                      //             borderRadius: BorderRadius.circular(20.0),
                      //           ),
                      //           popupItemBuilder: (context, item, isSelected) =>
                      //               Padding(
                      //             padding: const EdgeInsets.all(8.0),
                      //             child: Container(
                      //               child: Column(
                      //                 children: [
                      //                   ListTile(
                      //                     onTap: () {
                      //                       print("pressed $item");
                      //                     },
                      //                     title: Text('$item '),
                      //                     leading: CircleAvatar(
                      //                         backgroundImage: NetworkImage(
                      //                             'https://cdn-icons-png.flaticon.com/512/196/196121.png')
                      //                         // : NetworkImage(
                      //                         //     'https://static.toiimg.com/photo/msid-67586673/67586673.jpg?3918697'),
                      //                         ),
                      //                   ),
                      //                   Divider(
                      //                     height: 5,
                      //                   )
                      //                 ],
                      //               ),
                      //             ),
                      //           ),
                      //           items: [
                      //             "Psychologist",
                      //             "Paediatrician",
                      //             "Physiotherapist",
                      //             "Endocrinologist",
                      //             "Dermatologist"
                      //           ],
                      //           onSaved: (s) {},
                      //         ),
                      //       )
                      //     : Container(),

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
                        child: Obx(
                          () => MaterialButton(
                            color: const Color(0xfff97d7d),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            child: (controller.isRegisterLoading.value)
                                ? CircularProgressIndicator(color: Colors.white)
                                : Text(
                                    controller.currentType.value == "doctor"
                                        ? 'Register'
                                        : 'Next',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                            onPressed: () async {
                              if (controller.currentType.value == "patient") {
                                if (_formKey.currentState!.validate()) {
                                  dynamic result =
                                      await _auth.registerWithEmailAndPassword(
                                          email.text, password);

                                  if (result == null) {
                                    setState(() => error =
                                        'please supply valid credentials');
                                  } else {
                                    await FirebaseAuth.instance.currentUser!
                                        .updatePhotoURL('user');
                                    await FirebaseFirestore.instance
                                        .collection('Users')
                                        .doc(FirebaseAuth
                                            .instance.currentUser!.uid)
                                        .set({"type": "user"});

                                    Navigator.pop(context);
                                    // Navigator.pop(context);
                                    // await Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) =>
                                    //           const UserProfile()),
                                    // );
                                  }
                                }
                                return;
                              } else {
                                if (_formKey.currentState!.validate()) {
                                  dynamic result =
                                      await _auth.registerWithEmailAndPassword(
                                          email.text, password);

                                  if (result == null) {
                                    setState(() => error =
                                        'please supply valid credentials');
                                  } else {
                                    await FirebaseFirestore.instance
                                        .collection('Users')
                                        .doc(FirebaseAuth
                                            .instance.currentUser!.uid)
                                        .set({"type": "doctor"});

                                    Navigator.pop(context);
                                    // Navigator.pop(context);
                                    // await Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) =>
                                    //           const UserProfile()),
                                    // );
                                  }
                                }
                                return;
                              }
                              // controller.isRegisterLoading.value = true;
                              // Map<String, dynamic> data = {};
                              // data.addAll({
                              //   "type": "doctor",
                              //   "docName": name,
                              //   "docExp": docExp.value.text,
                              //   "docLocation": docLocation.value.text,
                              //   "docdsExp": docdsExp.value.text,
                              //   "docFees": docFees.value.text,
                              //   "docSpeciality": docSpeciality.value.text,
                              //   "docTime": controller.selectedTime.value ==
                              //           'Select Time'
                              //       ? ''
                              //       : controller.selectedTime.value,
                              //   "docDays": controller.weekdayBool.value,
                              // });
                              // if (controller.currentType.value == 'doctor') {
                              //   var authResult;
                              //   try {
                              //     authResult =
                              //         await AuthServiceHandler.registerUser(
                              //             email.text.trim(),
                              //             password,
                              //             "doctor",
                              //             data);

                              //     Navigator.of(context).pop();
                              //   } catch (e) {
                              //     controller.isRegisterLoading.value = false;
                              //   }

                              //   return;
                              // }

                              // dynamic result = await _auth
                              //     .registerWithEmailAndPassword(email, password);
                              // print("result of register ${result.uid}");

                              // Navigator.pop(context);
                              // Get.showSnackbar(GetSnackBar(
                              //   snackPosition: SnackPosition.TOP,
                              //   duration: Duration(seconds: 2),
                              //   messageText: Text('Success'),
                              //   message: 'Registered Success fully',
                              //   icon: Icon(Icons.check, color: Colors.green),
                              // ));
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                          height: 30,
                          child: Text(
                            error,
                            style: const TextStyle(
                                color: Colors.red, fontSize: 14),
                          )),
                      RichText(
                          text: TextSpan(
                              text: 'Back to Login',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginUiPage(),
                                      ));
                                },
                              style: const TextStyle(
                                  color: Color(0xffee0f37),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12)))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
