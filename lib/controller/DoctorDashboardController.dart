import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:down_syndrome/Screens/UserProfile.dart' as userprofile;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class DoctorDashboardController extends GetxController {
  var userlistdata = <userprofile.User>[].obs;

  void getUserList() async {
    print("doc dash=main=${FirebaseAuth.instance.currentUser!.uid}");
    var userlist = await FirebaseFirestore.instance
        .collection('Users')
        .doc('${FirebaseAuth.instance.currentUser!.uid}')
        .collection('Appointments')
        .get()
        .then((value) => value.docs);
    userlist.forEach((element) async {
      var uid = element.data()['patient_id'];
      var userdet = await FirebaseFirestore.instance
          .collection('Users')
          .doc(uid)
          .get()
          .then((value) => value);
      print("doc dash=${userdet.id}");
      userlistdata.add(userprofile.User(
        Addr: userdet.data()!['addr'],
        Age: userdet.data()!['age'],
        GName: userdet.data()!['gname'],
        Gender: userdet.get('gender'),
        Lang: userdet.get('lang'),
        PName: userdet.get('pname'),
        Phone: userdet.get('phone'),
        dsFamilyStatus: userdet.get('ds_family_status'),
        dsStatus: userdet.get('ds_status'),
        dsType: userdet.get('ds_type'),
        extraHealthIssue: userdet.get('extra_health_issue'),
        extraHealthIssueSub: userdet.get('extra_health_issue_sub'),
        id: userdet.get('id'),
        // isCreated: userdet.get('is_created'),
        isCritical: userdet.get('is_critical'),
        specialist: [],
      ));
      userlistdata.refresh();
    });
  }

  @override
  void onInit() {
    getUserList();
    super.onInit();
  }
}
