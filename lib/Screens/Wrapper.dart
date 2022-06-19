import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:down_syndrome/Screens/Authentication/Authenticate.dart';
import 'package:down_syndrome/Screens/DashBoard.dart';
import 'package:down_syndrome/Screens/Home/HomePage.dart';
import 'package:down_syndrome/models/user_model.dart';
import 'package:down_syndrome/view/AccountLoginView.dart';
import 'package:down_syndrome/view/SwitchUser.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view/DoctorPageView.dart';
import '../view/UserHealthRecordPage.dart';
import 'LoginUiPage.dart';
import 'UserProfile.dart' as usp;

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
    // return either home or authenticate widget

    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print(
              "logged in ${FirebaseAuth.instance.currentUser!.photoURL} ${snapshot.data}");

          return const SwitchUser();
          // return DoctorDashboardView(
          //   email: snapshot.data!.email.toString(),
          // );
          // Navigator.of(context)
          //     .push(MaterialPageRoute(builder: (context) => SwitchUser()));

          // if (FirebaseAuth.instance.currentUser!.photoURL == "user") {
          //   Navigator.of(context).push(MaterialPageRoute(
          //       builder: (context) => const usp.UserProfile()));

          //   // return const UserHealthRecordView();
          // } else {
          //   Navigator.of(context).push(MaterialPageRoute(
          //       builder: (context) => DoctorDashboardView(
          //             email: snapshot.data!.email.toString(),
          //           )));
          //   // return DoctorDashboardView(
          //   //   email: snapshot.data!.email.toString(),
          //   // );
          // }
          // return Scaffold(
          //   appBar: AppBar(),
          //   body: Container(
          //     child: Center(
          //         child: Row(
          //       children: [
          //         Text('Logged in'),
          //         TextButton(
          //             onPressed: () async {
          //               FirebaseAuth.instance.signOut();
          //             },
          //             child: Text('Logout'))
          //       ],
          //     )),
          //   ),
          // );
        }
        print("not logged in yet");
        // Navigator.of(context).pushReplacement(MaterialPageRoute(
        //   builder: (context) => AccountLogin(),
        // ));
        // return AccountLogin();
        // UserHealthRecordView();
        return AccountLogin();
      },
    );

    if (user == null) {
      return Authenticate();
    } else {
      return AccountLogin();
      // return LoginUiPage();
    }
  }
}
