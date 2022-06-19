import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:down_syndrome/Screens/DoctorProfile.dart';
import 'package:down_syndrome/controller/SwitchUserController.dart';
import 'package:down_syndrome/view/DoctorPageView.dart';
import 'package:down_syndrome/view/UserDashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Screens/UserProfile.dart';

class SwitchUser extends StatefulWidget {
  const SwitchUser({Key? key}) : super(key: key);

  @override
  State<SwitchUser> createState() => _SwitchUserState();
}

class _SwitchUserState extends State<SwitchUser> {
  var currentUserController;

  @override
  Widget build(BuildContext context) {
    SwitchUserController currentUserController =
        Get.put(SwitchUserController());
    return Obx(() => currentUserController.currentUserType.value == ''
        ? Scaffold(
            backgroundColor: Colors.redAccent.shade100,
            appBar: AppBar(
              toolbarHeight: 0,
            ),
            body: Center(
                child: CircularProgressIndicator(
              color: Colors.white,
            )),
          )
        : currentUserController.currentUserType.value == 'user' &&
                !currentUserController.isCreated.value
            ? UserProfile()
            : currentUserController.currentUserType.value == 'user' &&
                    currentUserController.isCreated.value
                ? UserDashboard()
                : currentUserController.currentUserType.value == 'doctor' &&
                        !currentUserController.isCreated.value
                    ? DoctorProfile()
                    : DoctorDashboardView(email: ''));
  }
}
