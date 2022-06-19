import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/QuestionModel.dart';

class UserHealthRecordCurrentController extends GetxController {
  var questionList = [
    "Is your Child affected with down syndrome?",
    "Type of DS ",
    "Do any other family member is affected?",
    "Have your child ever diagnosed with the condition list below"
  ];
  var answerList = [
    "Yes~No~Not Sure",
    "Trisomy 21~Translocation DS~Mosaic DS~Not Sure~Not Sure",
    "Yes~No~Not Sure",
    "CHD~Gastro or Stomach Problem~Skin or Dental Problem~Neurologic Problem~Thyroid ~Eye~Hearing~Sleep"
  ];

  var extraQuestion = <QuestionModel>[].obs;
  var ans0 = [false, false, false].obs;
  var ans1 = [false, false, false, false, false].obs;
  var ans2 = [false, false, false].obs;
  var ans3 = [false, false, false, false, false, false, false, false].obs;
  var extraQuestionChoice = {}.obs;
  var isCritical = false.obs;
  // void getSubQuestionList()async{
  //   List<QuestionModel> subQue
  // }
  void getQuestionList() async {
    List<QueryDocumentSnapshot> list = await FirebaseFirestore.instance
        .collection('QuestionsFinal')
        .get()
        .then((value) => value.docs);
    var x = QuestionList.fromJson(list);
    for (var element in x.questionList) {
      extraQuestionChoice.addAll(
          {"${element.id}": element.quesOptions.map((e) => false).toList()});

      // assign();
      print("extraquestion.lenbgth=${extraQuestionChoice.length}");
    }
    extraQuestion.refresh();
    print(
        "final map =${extraQuestionChoice.length} x=${x.questionList.length}");

    extraQuestion.value = x.questionList;

    print('list first=${x.questionList[0].quesOptions}');
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getQuestionList();
    super.onInit();
  }
}
