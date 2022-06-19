// class QuestionModel{
//   String question;
//   bool
//   QuestionModel()
// }
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class QuestionModel {
  var quesTag = '';
  var quesText = '';
  var symptoms = [];
  var quesOptions;
  var id;
  var isSelected = false.obs;
  var isSelectedSub = false.obs;
  var selectedIndex = 0.obs;
  var speciality = [];
  QuestionModel(
      {required this.quesTag,
      required this.quesText,
      required this.symptoms,
      required this.speciality,
      this.id,
      required this.isSelectedSub,
      required this.isSelected,
      required this.selectedIndex,
      this.quesOptions});
}

class QuestionList {
  List<QuestionModel> questionList;
  QuestionList(this.questionList);
  factory QuestionList.fromJson(List<QueryDocumentSnapshot> parsed) {
    // ignore: deprecated_member_use
    List<QuestionModel>? question = [];
    question = parsed
        .map((e) => QuestionModel(
            quesTag: e.get('quesTag'),
            quesText: e.get('quesText'),
            symptoms: e.get('symptoms'),
            id: e.id,
            isSelected: false.obs,
            isSelectedSub: false.obs,
            selectedIndex: 0.obs,
            speciality: e.get('specialist'),
            quesOptions: e.get('quesOptions')))
        .toList();
    print("total no of docs=${parsed.length}");
    return QuestionList(question);
  }
}
