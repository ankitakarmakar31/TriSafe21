import 'package:down_syndrome/services/FirestoreHelper.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServiceHandler {
  static Future<dynamic> registerUser(email, password, type, data) async {
    UserCredential result;

    print("register result email=${email} pass=${password}");

    result = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    print("auth result final=${result}");

    if (type == "doctor") {
      await FirestoreHelper.addUser('Doctors_data', data, "doctor");
    } else {
      await FirestoreHelper.addUser(
          'Users',
          {
            "type": "user",
          },
          "patient");
    }
    // await FirebaseAuth.instance
    //     .signInWithCredential(result.credential!)
    //     .then((_) async {

    //   print("sign in cred");

    //   print("register success login ${_.additionalUserInfo}");
    // });
    return result;
  }
}
