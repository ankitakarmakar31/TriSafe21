import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:down_syndrome/Screens/DoctorProfile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserDashboardController extends GetxController {
  var doctorList = <UserDoctor>[].obs;
  var selecteddays = {}.obs;
  void getUserDetails() async {
    var speciality = await FirebaseFirestore.instance
        .collection('Users')
        .doc('${FirebaseAuth.instance.currentUser!.uid}')
        .get()
        .then((value) => value.data()!['specialist'][0]);
    var data = await FirebaseFirestore.instance
        .collection('Users')
        .where("type", isEqualTo: "doctor")
        .where("doc_speciality", isEqualTo: speciality)
        .get()
        .then((value) {
      return value.docs;
    });
    doctorList.value = data
        .map((e) => UserDoctor(
            docSpeciality: e.data()['doc_speciality'],
            docDays: e.data()['doc_days'],
            PName: e.data()['doc_name'],
            docAdd: e.data()['doc_add'],
            password: e.data()['password'],
            docExp: e.data()['doc_exp'],
            docDsExp: e.data()['doc_ds_exp'],
            docFees: e.data()['doc_fees'],
            docTime: e.data()['doc_time'],
            docPhone: e.data()['doc_phone'],
            selectedDay: "-1",
            id: e.data()['id']))
        .toList();
    doctorList.value.sort((b, a) => int.parse(a.docDsExp).compareTo(
          int.parse(b.docDsExp),
        ));
    doctorList.forEach((element) {
      selecteddays.addAll(
          {"${element.id}": element.docTime.map((e) => false).toList()});
      print("selected days=${selecteddays}");
    });

    selecteddays.refresh();
    doctorList.refresh();
    print('doc list=${doctorList}');
  }

  @override
  void onInit() {
    getUserDetails();

    super.onInit();
  }
}
