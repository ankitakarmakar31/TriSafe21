import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:down_syndrome/Screens/DoctorProfile.dart';
import 'package:down_syndrome/controller/UserDashboardController.dart';
import 'package:down_syndrome/view/UserDashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class DoctorDetailPage extends StatefulWidget {
  UserDoctor doctor;
  UserDashboardController controller;
  DoctorDetailPage({Key? key, required this.doctor, required this.controller})
      : super(key: key);

  @override
  State<DoctorDetailPage> createState() => _DoctorDetailPageState();
}

class _DoctorDetailPageState extends State<DoctorDetailPage> {
  String getDay(var day) {
    switch (day) {
      case 0:
        return 'Mon';

      case 1:
        return 'Tue';
      case 2:
        return 'Wed';
      case 3:
        return 'Thu';
      case 4:
        return 'Fri';
      case 5:
        return 'Sat';
      case 6:
        return 'Sun';
      default:
        return 'Mon';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.redAccent.shade100),
      body: Sizer(
        builder: (context, orientation, deviceType) => SingleChildScrollView(
          child: Container(
            height: 200.h,
            width: 100.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 100,
                    backgroundImage: NetworkImage(
                        'https://media.istockphoto.com/vectors/doctor-with-stethoscope-and-medical-test-medic-icon-in-flat-style-vector-id1129223269?k=20&m=1129223269&s=612x612&w=0&h=rfQO9jF2s8OZCtxV4CcRhF4hMPxg6_h2Au7D7bcBTwk='),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('DR.${widget.doctor.PName.toUpperCase()}'),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('${widget.doctor.docSpeciality.toUpperCase()}'),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Select appointment day :')),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.doctor.docTime.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => ListTile(
                    onTap: () {
                      if (widget.doctor.selectedDay == "-1") {
                        widget.doctor.selectedDay = "$index";
                      }
                    },
                    contentPadding: EdgeInsets.all(8),
                    leading: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.redAccent.shade100,
                      child: Text('${getDay(index)}'),
                    ),
                    trailing: widget.doctor.docTime[index].contains('Select')
                        ? Container(
                            height: 0,
                            width: 0,
                          )
                        : Obx(
                            () => Radio<dynamic>(
                                value: widget.controller
                                    .selecteddays['${widget.doctor.id}'][index],
                                groupValue: true,
                                toggleable: true,
                                onChanged: (_) {
                                  print('sel');
                                  widget.controller
                                          .selecteddays['${widget.doctor.id}']
                                      [index] = !widget.controller
                                          .selecteddays['${widget.doctor.id}']
                                      [index];

                                  print(
                                      "sel ${widget.controller.selecteddays['${widget.doctor.id}'][index]}");
                                  widget.controller.selecteddays.refresh();
                                }),
                          ),
                    title: Text(
                        '${widget.doctor.docTime[index].contains('Select') ? 'Not Available' : widget.doctor.docTime[index]}'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Sizer(
        builder: (context, orientation, deviceType) => InkWell(
          onTap: () async {
            print(
                'doc id=${widget.doctor.id} ${widget.controller.selecteddays[widget.doctor.id]}');
            var selectedtime = '';
            var selectedDays = '';
            for (int i = 0;
                i < widget.controller.selecteddays[widget.doctor.id].length;
                i++) {
              if (widget.controller.selecteddays[widget.doctor.id][i] == true) {
                selectedtime += '${widget.doctor.docTime[i]} -';
                selectedDays += '${getDay(i)}-${selectedtime}';
              }
            }

            await FirebaseFirestore.instance
                .collection('Users')
                .doc('${FirebaseAuth.instance.currentUser!.uid}')
                .collection('Appointments')
                .add({
              "doc_id": widget.doctor.id,
              "doc_day": "${selectedDays}",
              "doc_time": "${selectedtime}"
            });

            await FirebaseFirestore.instance
                .collection('Users')
                .doc(widget.doctor.id)
                .collection('Appointments')
                .add({
              "patient_id": FirebaseAuth.instance.currentUser!.uid,
              "patient_day": "Monday",
              "patient_time": "$selectedtime"
            });
            // Get.showSnackbar(GetSnackBar(
            //   message: "Booked Succesfully",
            //   padding: EdgeInsets.all(8),
            //   duration: Duration(seconds: 2),
            //   snackPosition: SnackPosition.BOTTOM,
            // ));

            Navigator.of(context).pop();
          },
          child: Container(
            height: 7.0.h,
            color: Colors.redAccent.shade100,
            width: 100.0.w,
            child: Center(
                child: Text(
              'Book Appointment'.toUpperCase(),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 2.h,
                  fontWeight: FontWeight.bold),
            )),
          ),
        ),
      ),
    );
  }
}
