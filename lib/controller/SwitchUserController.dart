import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SwitchUserController extends GetxController {
  var currentUserType = ''.obs;
  var isCreated = false.obs;
  void getUserDetails() async {
    var usertype = await Future.delayed(
      Duration(seconds: 2),
      () async {
        return FirebaseFirestore.instance
            .collection('Users')
            .doc('${FirebaseAuth.instance.currentUser!.uid}')
            .get()
            .then((value) {
          print("usertype=${value.data()}");
          isCreated.value = value.data()!['profile_created'];
          return value.data()!['type'];
        });
      },
    );

    print("user details after login=${usertype}");
    currentUserType.value = usertype;
  }

  @override
  void onInit() {
    getUserDetails();
    // FirebaseAuth.instance.signOut();
    super.onInit();
  }
}
