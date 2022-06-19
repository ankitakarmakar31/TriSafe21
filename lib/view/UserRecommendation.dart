import 'package:down_syndrome/controller/UserDashboardController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class UserDoctorRecommendation extends StatefulWidget {
  const UserDoctorRecommendation({Key? key}) : super(key: key);

  @override
  State<UserDoctorRecommendation> createState() =>
      UserDoctorRecommendationState();
}

class UserDoctorRecommendationState extends State<UserDoctorRecommendation> {
  UserDashboardController controller = Get.put(UserDashboardController());
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Sizer(
        builder: (context, orientation, deviceType) => Container(
          height: 100.0.h,
          width: 100.0.w,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: 10,
            itemBuilder: (context, index) => ListTile(
              leading: CircleAvatar(radius: 40),
              title: Text('hey'),
              isThreeLine: true,
              subtitle: Column(
                children: [],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
