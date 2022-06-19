//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:down_syndrome/Screens/MedicalProfile.dart';
import 'package:down_syndrome/view/DoctorPageView.dart';
import 'package:down_syndrome/view/UserHealthRecordPage.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/DoctorProfileController.dart';

class DoctorProfile extends StatefulWidget {
  const DoctorProfile({Key? key}) : super(key: key);

  @override
  State<DoctorProfile> createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  final controllerPName = TextEditingController();
  final controllerAddress = TextEditingController();
  final controllerGender = TextEditingController();
  final controllerExp = TextEditingController();
  final controllerDSExp = TextEditingController();
  final controllerLang = TextEditingController();
  final controllerAddr = TextEditingController();
  final controllerPhone = TextEditingController();
  TextEditingController docSpeciality = new TextEditingController();
  TextEditingController docFees = new TextEditingController();
  var controller = Get.put(DoctorProfileController());
  @override
  Widget build(BuildContext context) {
    Widget customButton(index, {type = 'from'}) {
      return Obx(() => controller.weekdayBool.value[index]
          ? TextButton.icon(
              icon: Icon(Icons.alarm),
              label: Obx(
                () => Text(
                    "${type == 'from' ? controller.weekdayTimeFrom.value[index] : controller.weekdayTimeTo.value[index]} for ${controller.getDay(index)}"
                        .toUpperCase(),
                    style: TextStyle(fontSize: 14)),
              ),
              style: ButtonStyle(
                  padding:
                      MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
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
                  if (type == 'from') {
                    controller.weekdayTimeFrom.value[index] =
                        timeOfDay.format(context).toString();
                    controller.weekdayTimeFrom.refresh();
                  } else {
                    controller.weekdayTimeTo.value[index] =
                        timeOfDay.format(context).toString();
                    controller.weekdayTimeTo.refresh();
                  }
                }
              },
            )
          : Container());
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

// Widget timeSelector(){
//   return Container(
//     width: MediaQuery.of(context).size.width,
//         height: 50,
//     child:
//   )
// }
    Widget weekdaySelector() {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: 100,
        child: ListView.separated(
            separatorBuilder: (context, index) => SizedBox(width: 10),
            itemCount: controller.weekdayBool.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => InkWell(
                onTap: () {
                  controller.weekdayBool[index] =
                      !controller.weekdayBool[index];
                  if (controller.weekdayBool[index]) {
                    controller.weekdayIndex.value = index;
                  } else {
                    controller.weekdayIndex.value =
                        controller.weekdayBool.length;
                  }
                  controller.weekdayBool.refresh();
                },
                child: Column(
                  children: [
                    Obx(
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
                    // Container(
                    //   height: 20,
                    //   color: Colors.pink,
                    //   child: Center(child: customButton(index)),
                    // )
                  ],
                ))),
      );
    }

    Widget weekdayTimeSelector() {
      return Obx(
        () => controller.weekdayIndex.value != 7
            ? Column(
                children: [
                  Text('From'),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: 100,
                      child: Center(
                        child: customButton(controller.weekdayIndex.value),
                      )),
                  Text('To'),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: 100,
                      child: Center(
                        child: customButton(controller.weekdayIndex.value,
                            type: 'to'),
                      ))
                ],
              )
            : Container(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Doctor Profile"),
        centerTitle: true,
        backgroundColor: Colors.redAccent[200],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .02,
              ),
              Image.network(
                'https://cdn-icons-png.flaticon.com/512/3209/3209993.png',
                width: 250,
                height: 180,
                fit: BoxFit.fill,
              ),
              // Image.asset(
              //   'Assets/Images/DoctorProfile.jfif',
              // width: 250,
              // height: 180,
              // fit: BoxFit.fill,
              // ),
              const SizedBox(
                height: 14,
              ),
              TextField(
                controller: controllerPName,
                decoration: const InputDecoration(
                  hintText: 'Doctor Name',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                  prefixIcon: Icon(
                    Icons.person_outline_sharp,
                    size: 22,
                    color: Color(0xfff97d7d),
                  ),
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              TextField(
                controller: controllerAddress,
                decoration: const InputDecoration(
                  hintText: 'Address',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                  prefixIcon: Icon(
                    Icons.person_outline_sharp,
                    size: 22,
                    color: Color(0xfff97d7d),
                  ),
                ),
              ),
              const SizedBox(
                height: 14,
              ),

              TextField(
                controller: controllerExp,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Years of Exp',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                  prefixIcon: Icon(
                    Icons.person_outline_sharp,
                    size: 22,
                    color: Color(0xfff97d7d),
                  ),
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              TextField(
                controller: controllerDSExp,
                decoration: const InputDecoration(
                  hintText: 'Years of Exp in Down Syndrome',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                  prefixIcon: Icon(
                    Icons.person_outline_sharp,
                    size: 22,
                    color: Color(0xfff97d7d),
                  ),
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              TextField(
                controller: controllerAddr,
                decoration: const InputDecoration(
                  hintText: 'Address',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                  prefixIcon: Icon(
                    Icons.person_outline_sharp,
                    size: 22,
                    color: Color(0xfff97d7d),
                  ),
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              TextField(
                controller: controllerPhone,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Phone number',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                  prefixIcon: Icon(
                    Icons.person_outline_sharp,
                    size: 22,
                    color: Color(0xfff97d7d),
                  ),
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: docFees,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Consultation Fees',

                    hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                    prefixIcon: Text(' \u{20B9}',
                        style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 30,
                            fontWeight: FontWeight.w300)),

                    // Icon(
                    //   Icons.account_box,
                    //   color: Color(0xfff97d7d),
                    // )
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      'Select Available days:',
                      style: TextStyle(color: Colors.redAccent.shade100),
                    )),
              ),
              weekdaySelector(),
              weekdayTimeSelector(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownSearch(
                  showClearButton: true,
                  onChanged: (s) {
                    docSpeciality.value = TextEditingValue(text: '$s');
                  },
                  dropdownBuilder: (context, selectedItem) =>
                      _customDropDownExample(
                          context, selectedItem, "Select Your Speciality"),
                  popupShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  popupItemBuilder: (context, item, isSelected) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Column(
                        children: [
                          ListTile(
                            onTap: () {
                              print("pressed $item");
                            },
                            title: Text('$item '),
                            leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    'https://cdn-icons-png.flaticon.com/512/196/196121.png')
                                // : NetworkImage(
                                //     'https://static.toiimg.com/photo/msid-67586673/67586673.jpg?3918697'),
                                ),
                          ),
                          Divider(
                            height: 5,
                          )
                        ],
                      ),
                    ),
                  ),
                  items: [
                    "Psychologist",
                    "Paediatrician",
                    "Physiotherapist",
                    "Endocrinologist",
                    "Dermatologist",
                    "Dentist",
                    "Ophthalmologist",
                    "Cardiologist",
                    "ENT",
                    "General Physician",
                    "Gastroenterologist",
                    "Orthopedician",
                  ],
                  onSaved: (s) {},
                ),
              ),
              SizedBox(
                child: ElevatedButton(
                  onPressed: () async {
                    //user object
                    // await FirebaseAuth.instance.signOut();
                    mergerTime() {}
                    final user = UserDoctor(
                        PName: controllerPName.text,
                        // GName: controllerGName.text,
                        id: '${FirebaseAuth.instance.currentUser!.uid}',
                        docDays: controller.weekdayBool.value,
                        docSpeciality: docSpeciality.text,
                        docAdd: controllerAddress.text,
                        password: 'pass',
                        docExp: controllerExp.text,
                        docDsExp: controllerDSExp.text,
                        docFees: docFees.text,
                        docPhone: controllerPhone.text,
                        docTime: controller.mergerTime(),
                        isCreated: true);
                    //write userdata into firebase server
                    await createUser(user);

                    // Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DoctorDashboardView(
                                email: '',
                              )

                          //  const MedicalProfile()

                          ),
                    );
                  },
                  child: const Text(
                    'Create Profile',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                      // elevation: 30,
                      shadowColor: Colors.redAccent,
                      primary: Colors.redAccent[200]),
                ),
              ),
              const SizedBox(
                height: 14,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future createUser(UserDoctor user) async {
    final docUser = FirebaseFirestore.instance
        .collection('Users')
        .doc('${FirebaseAuth.instance.currentUser!.uid}')
        .update(user.toJson());
    // user.id = docUser.id;

    // final json = user.toJson();
    // await docUser.set(json);
  }
}

//model object class
class UserDoctor {
  String id;
  final String PName;

  final String docExp;
  final String docAdd;
  final String docDsExp;
  final String docFees;
  List<dynamic> docDays;

  final List<dynamic> docTime;
  final String docPhone;
  final String docSpeciality;
  String password;
  bool isCreated;
  String selectedDay = '';
  var docRating;
  UserDoctor({
    this.docRating = "0",
    this.isCreated = false,
    this.id = '',
    required this.docSpeciality,
    required this.docDays,
    required this.PName,
    required this.docAdd,
    required this.password,
    required this.docExp,
    required this.docDsExp,
    required this.docFees,
    required this.docTime,
    this.selectedDay = '',
    required this.docPhone,
  });

  Map<String, dynamic> toJson() => {
        'doc_rating': docRating,
        'profile_created': isCreated,
        'id': id,
        'doc_name': PName,
        'doc_add': docAdd,
        'doc_exp': docExp,
        "doc_ds_exp": docDsExp,
        "doc_phone": docPhone,
        'doc_time': docTime,
        "doc_fees": docFees,
        'doc_days': docDays,
        "password": password,

        // "docTime": docTime,
        "doc_speciality": docSpeciality,
      };

  Map<String, dynamic> fromJson() => {
        'profile_created': isCreated,
        'id': id,
        'doc_name': PName,
        'doc_add': docAdd,
        'doc_exp': docExp,
        "doc_ds_exp": docDsExp,
        "doc_phone": docPhone,
        'doc_time': docTime,
        "doc_fees": docFees,
        'doc_days': docDays,
        "password": password,
        // "docTime": docTime,
        "doc_speciality": docSpeciality
      };
}
