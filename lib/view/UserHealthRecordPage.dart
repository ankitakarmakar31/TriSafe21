import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:down_syndrome/controller/UserHealthRecordController.dart';
import 'package:down_syndrome/models/QuestionModel.dart';
import 'package:down_syndrome/services/FirestoreHelper.dart';
import 'package:down_syndrome/view/CurrentHealthRecord.dart';
import 'package:down_syndrome/view/PastHealthRecord.dart';
import 'package:down_syndrome/view/UserDashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:sizer/sizer.dart';

import '../controller/UserHealthControllerCurrent.dart';

class UserHealthRecordView extends StatefulWidget {
  const UserHealthRecordView({Key? key}) : super(key: key);

  @override
  State<UserHealthRecordView> createState() => _UserHealthRecordViewState();
}

class _UserHealthRecordViewState extends State<UserHealthRecordView>
    with TickerProviderStateMixin {
  var questionController = Get.put(UserHealthRecordController());
  var questionController2 = Get.put(UserHealthRecordCurrentController());
  late TabController tabController;
  Widget questionCard(questionIndex) {
    return Sizer(
      builder: (context, orientation, deviceType) => Padding(
        padding: EdgeInsets.all(8),
        child: Container(
          width: 100.0.w,
          height: 20,
          child: Text(
            questionController.questionList[questionIndex],
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget answerCard(questionIndex) {
    var answerOption = questionController.answerList[questionIndex].split('~');
    print("answerOpttion=${answerOption}");
    var currentAnswer = questionIndex == 0
        ? questionController.ans0
        : questionIndex == 1
            ? questionController.ans1
            : questionController.ans2;
    return Sizer(
        builder: (context, orientation, deviceType) => ListView.separated(
              separatorBuilder: (context, index) => SizedBox(height: 10),
              shrinkWrap: true,
              itemCount: 3,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => Container(
                  child: Container(
                child: Obx(
                  () => RadioListTile(
                      activeColor: Colors.white,
                      title: Text(answerOption[index]),
                      value: currentAnswer[index],
                      groupValue: true,
                      selected: currentAnswer[index],
                      onChanged: (xc) {
                        print("ans=");
                        currentAnswer[index] = !currentAnswer[index];
                        if (currentAnswer[index] == true) {
                          if (questionIndex == 0) {
                            questionController.selectedans0.value =
                                answerOption[index];
                            print(
                                'ans=${questionController.selectedans0.value}');
                          } else if (questionIndex == 1) {
                            questionController.selectedans1.value =
                                answerOption[index];
                          } else {
                            questionController.selectedans3.value =
                                answerOption[index];
                          }
                        }
                        for (int i = 0; i < currentAnswer.length; i++) {
                          if (i != index) {
                            currentAnswer[i] = false;
                          }
                        }
                      },
                      toggleable: true),
                ),
              )),
            ));
  }

  void getQuestionList() async {
    List<QueryDocumentSnapshot> list = await FirebaseFirestore.instance
        .collection('QuestionsFinal')
        .get()
        .then((value) => value.docs);
    var x = QuestionList.fromJson(list);
    questionController.extraQuestion.value = x.questionList;
    print('list first=${x.questionList[0].quesOptions}');
  }

  @override
  void initState() {
    // TODO: implement initState
    tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    getQuestionList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('User Health Record'),
          backgroundColor: Colors.redAccent.shade100,
          elevation: 0,
          bottom: TabBar(
            controller: tabController,
            indicatorColor: Colors.black,
            tabs: <Tab>[
              Tab(
                child: Text(
                  "Past Health Record",
                  style: TextStyle(color: Colors.white, fontSize: 8.0.sp),
                ),
              ),
              Tab(
                child: Text(
                  "Current Health Record",
                  style: TextStyle(color: Colors.white, fontSize: 8.0.sp),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.redAccent.shade100,
        body: SingleChildScrollView(
          child: Container(
              height: MediaQuery.of(context).size.height * 3,
              width: MediaQuery.of(context).size.width,
              child: DefaultTabController(
                length: 2,
                initialIndex: 0,
                child: TabBarView(
                  controller: tabController,
                  children: [
                    PastHealthView(questionController: questionController),
                    PresentHealthView(
                      questionController: questionController2,
                    )
                  ],
                ),
              )
              // Column(children: [
              //   questionCard(0),
              //   answerCard(0),
              //   Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: Container(
              //         width: 100.0.w,
              //         child: Text(
              //           'Child\'s Age:',
              //           style: TextStyle(color: Colors.white),
              //         )),
              //   ),
              //   questionCard(1),
              //   answerCard(1),
              //   questionCard(2),
              //   answerCard(2),
              // ]),
              ),
        ),
        bottomNavigationBar: Sizer(
          builder: (context, orientation, deviceType) => InkWell(
            onTap: () async {
              // await FirebaseAuth.instance.signOut();
              await FirestoreHelper.addData(
                  'Users', '${FirebaseAuth.instance.currentUser!.uid}', {
                "ds_status": questionController.selectedans0.value,
                "specialist": questionController.specialist,
                "ds_type": questionController.selectedans1.value,
                "extra_health_issue": questionController.selectedans3.value,
                "extra_health_issue_sub": questionController.selectedans4.value,
                "ds_family_status": questionController.selectedans2.value,
                "is_critical": questionController2.isCritical.value
              });
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserDashboard(),
                  ));
            },
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20)),
              child: Container(
                height: 6.0.h,
                width: 100.0.w,
                color: Colors.white,
                child: Center(
                    child: Text(
                  'Save',
                  style: TextStyle(
                      color: Colors.redAccent.shade100, fontSize: 2.0.h),
                )),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
