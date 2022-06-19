import 'package:down_syndrome/controller/DoctorDashboardController.dart';
import 'package:down_syndrome/view/UserDetailsDoctor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:sizer/sizer.dart';

import '../controller/SwitchUserController.dart';

class DoctorDashboardView extends StatefulWidget {
  String email;
  DoctorDashboardView({Key? key, this.email = ''}) : super(key: key);

  @override
  State<DoctorDashboardView> createState() => _DoctorDashboardViewState();
}

class _DoctorDashboardViewState extends State<DoctorDashboardView> {
  var controller = Get.put(DoctorDashboardController());
  // ignore: non_constant_identifier_names

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
              title: const Text('Logout'),
              onTap: () async {
                Get.delete<DoctorDashboardController>();
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
          elevation: 0,
          title: Text('Your Dashboard'),
          backgroundColor: Colors.redAccent.shade100),
      body: Sizer(
        builder: (context, orientation, deviceType) => SingleChildScrollView(
            child: Obx(() => controller.userlistdata.length == 0
                ? Container(
                    height: 100.0.h,
                    width: 100.0.w,
                    child: Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    ),
                  )
                : ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.all(8),
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 1.5.h),
                    shrinkWrap: true,
                    itemCount: controller.userlistdata.length,
                    itemBuilder: (context, index) => ListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => UserDetailsDoctor(
                                  user: controller.userlistdata[index],
                                )));
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(2.0.h))),
                      contentPadding: EdgeInsets.all(8),
                      leading: CircleAvatar(
                          radius: 40,
                          child: Text(
                              '${controller.userlistdata[index].PName[0].toUpperCase()}'),
                          backgroundColor: Colors.redAccent.shade100),
                      title: Text('${controller.userlistdata[index].PName}'),
                      subtitle: controller.userlistdata[index].isCritical
                          ? Text(
                              'Condition is critical',
                              style: TextStyle(color: Colors.red),
                            )
                          : Text(''),
                      trailing: controller.userlistdata[index].isCritical
                          ? Icon(
                              Icons.error,
                              color: Colors.red,
                            )
                          : Container(),
                      tileColor: Colors.white,
                    ),
                  ))),
      ),
    );
  }
}
