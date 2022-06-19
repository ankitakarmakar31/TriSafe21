import 'package:down_syndrome/controller/UserDashboardController.dart';
import 'package:down_syndrome/view/DoctorDetail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../controller/SwitchUserController.dart';

class UserDashboard extends StatefulWidget {
  const UserDashboard({Key? key}) : super(key: key);

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  var controller = Get.put(UserDashboardController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent.shade100,
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.redAccent,
              ),
              child: Text(''),
            ),
            ListTile(
              title: const Text('My Appointments'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('My Health Record'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Logout'),
              onTap: () async {
                Get.delete<UserDashboardController>();
                Get.delete<SwitchUserController>();
                Navigator.of(context).pop();
                await FirebaseAuth.instance.signOut();
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
          title: Text('User Dashboard'),
          elevation: 0,
          backgroundColor: Colors.redAccent.shade100),
      body: Sizer(
          builder: (context, orientation, deviceType) => Obx(
                () => Container(
                    height: 100.0.h,
                    width: 100.0.w,
                    child: controller.doctorList.value.length == 0
                        ? Center(
                            child:
                                CircularProgressIndicator(color: Colors.white),
                          )
                        : ListView.separated(
                            padding: EdgeInsets.all(8),
                            separatorBuilder: (context, index) =>
                                SizedBox(height: 1.5.h),
                            itemCount: controller.doctorList.length,
                            itemBuilder: (context, index) => ListTile(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => DoctorDetailPage(
                                          controller: controller,
                                          doctor: controller.doctorList[index],
                                        )));
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(2.0.h))),
                              tileColor: Colors.white,
                              contentPadding: EdgeInsets.all(8),
                              // trailing: InkWell(
                              //   child: Padding(
                              //     padding: const EdgeInsets.all(8.0),
                              //     child: ClipRRect(
                              //       borderRadius: BorderRadius.all(
                              //           Radius.circular(2.0.w)),
                              //       child: Container(
                              //         width: 20.0.w,
                              //         color: Colors.redAccent.shade100,
                              //         child: Padding(
                              //           padding: const EdgeInsets.all(8.0),
                              //           child: FittedBox(
                              //               child: Text('Book an appointment')),
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              leading: CircleAvatar(
                                  radius: 40,
                                  backgroundColor: Colors.redAccent.shade100,
                                  child: Text(
                                      '${controller.doctorList[index].PName}'[0]
                                          .toUpperCase())),
                              title: Text(
                                  'DR.${controller.doctorList[index].PName.toUpperCase()}'),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      '${controller.doctorList[index].docSpeciality}'),
                                  Text(
                                      'Down Syndrome Exp:${controller.doctorList[index].docDsExp}'),
                                  Text('Rating:0')
                                ],
                              ),
                            ),
                          )),
              )),
    );
  }
}
