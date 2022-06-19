// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:get/get.dart';

// class SubQuestionModel {
//   var quesTag = '';
//   var quesText = '';
//   var symptoms = [];
//   var quesOptions;
//   var id;
//   var isSelected = false.obs;

//   SubQuestionModel(
//       {required this.quesTag,
      
//       this.id,
//       required this.isSelected,
//       this.quesOptions});
// }

// class QuestionList {
//   List<SubQuestionModel> questionList;
//   QuestionList(this.questionList);
//   factory QuestionList.fromJson(List<QueryDocumentSnapshot> parsed) {

//     List<SubQuestionModel>? question = [];
//     question = parsed
//         .map((e) => SubQuestionModel(
//             quesTag: e.get('quesTag'),
//             quesText: e.get('quesText'),
//             symptoms: e.get('symptoms'),
//             id: e.id,
//             isSelected: false.obs,
//             quesOptions: e.get('quesOptions')))
//         .toList();
//     print("total no of docs=${parsed.length}");
//     return QuestionList(question);
//   }
// }
