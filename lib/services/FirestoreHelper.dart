import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreHelper {
  static Future<dynamic> addUser(
      String collectionPath, Map<String, dynamic> data, type) async {
    // print("")
    if (type == 'doctor') {
      print("add user called ${data['docDays']}");
      try {
        await FirebaseFirestore.instance.collection(collectionPath).add({
          "docName": data['docName'],
          "docExp": data['docExp'],
          "docSpeciality": data['docSpeciality'],
          "docLocation": data['docLocation'],
          "docFees": data['docFees'],
          "type": type,
          "docDays": data['docDays'],
          "docTime": data['docTime'],
        }).then((value) => value);
      } catch (e) {
        print("add user exception $e");
      }
    }
    return "success";
  }

  static Future<bool> addData(
      collectionPath, docName, Map<String, dynamic> data) async {
    await FirebaseFirestore.instance
        .collection(collectionPath)
        .doc(docName)
        .update(data)
        .timeout(
          const Duration(seconds: 2),
          onTimeout: () => false,
        );

    return true;
  }
}
