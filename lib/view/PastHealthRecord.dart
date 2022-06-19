import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../controller/UserHealthRecordController.dart';

class PastHealthView extends StatefulWidget {
  UserHealthRecordController questionController;
  PastHealthView({Key? key, required this.questionController})
      : super(key: key);

  @override
  State<PastHealthView> createState() => _PastHealthViewState();
}

class _PastHealthViewState extends State<PastHealthView> {
  @override
  Widget build(BuildContext context) {
    var questionController = widget.questionController;

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

    Widget extraQuestionCard(questionIndex) {
      return Sizer(
        builder: (context, orientation, deviceType) => Padding(
          padding: EdgeInsets.all(8),
          child: Container(
            width: 100.0.w,
            height: 20,
            child: Text(
              questionController.extraQuestion[questionIndex].quesText,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      );
    }

    Widget extraanswerCard(questionIndex) {
      var answerOption =
          questionController.extraQuestion[questionIndex].quesOptions;

      // print(
      //     "answerOpttion=${answerOption}, result=${questionController.extraQuestionChoice[answerReal.id]}");
      // var currentAnswer = answerOption;

      return Sizer(
          builder: (context, orientation, deviceType) => ListView.separated(
                separatorBuilder: (context, index) => SizedBox(height: 10),
                shrinkWrap: true,
                itemCount: answerOption.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => Container(
                    child: Container(
                  child: Obx(
                    () => RadioListTile<bool>(
                        title: Text(
                            // answerOption[index]

                            questionController.extraQuestion[questionIndex]
                                .quesOptions[index]),
                        value: (questionController.extraQuestion[questionIndex]
                                    .isSelectedSub.value &&
                                index ==
                                    questionController
                                        .extraQuestion[questionIndex]
                                        .selectedIndex
                                        .value)
                            ? true
                            : false,
                        groupValue: true,
                        // selected: questionController.extraQuestion[questionIndex]
                        //         .isSelectedSub.value &&
                        //     questionIndex ==
                        //         questionController.extraQuestion[questionIndex]
                        //             .selectedIndex.value,
                        // subtitle:
                        //     questionController.extraQuestionChoice[answerReal.id] ==
                        //             true
                        //         ? Column(
                        //             children: [
                        //               extraQuestionCard(2),
                        //               extraanswerCard(2)
                        //             ],
                        //           )
                        //         : Container(),

                        onChanged: (xc) {
                          questionController.extraQuestion[questionIndex]
                                  .isSelectedSub.value =
                              !questionController.extraQuestion[questionIndex]
                                  .isSelectedSub.value;
                          if (questionController.extraQuestion[questionIndex]
                              .isSelectedSub.value) {
                            questionController.selectedans4.value =
                                questionController.extraQuestion[questionIndex]
                                    .quesOptions[index];
                          }

                          questionController.extraQuestion[questionIndex]
                              .selectedIndex.value = index;

                          questionController.extraQuestion.refresh();
                        },
                        toggleable: true),
                  ),
                )),
              ));
    }

    Widget extraanswerCardList() {
      var questionList = questionController.extraQuestion.value;
      // var subQuestionList = questionController.extraQuestionChoice.value;
      // var currentAnswer = questionController.extraQuestionChoice.value;
      print("final list=${questionList.length}");
      return Sizer(
          builder: (context, orientation, deviceType) => ListView.separated(
                separatorBuilder: (context, index) => SizedBox(height: 10),
                shrinkWrap: true,
                itemCount: questionList.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => Container(
                    child: Container(
                  child: Obx(
                    () => RadioListTile<bool>(
                        title: Text(
                            // answerOption[index]
                            questionController.extraQuestion[index].quesTag),
                        value: questionController
                            .extraQuestion[index].isSelected.value,
                        // subtitle: subQuestionList.length != 0
                        //     ? Column(children: [
                        //         extraQuestionCard(2),
                        //         extraanswerCard(2)
                        //       ])
                        //     : Container(),
                        groupValue: true,
                        subtitle: questionController
                                    .extraQuestion[index].isSelected.value ==
                                true
                            ? Column(
                                children: [
                                  extraQuestionCard(index),
                                  extraanswerCard(index)
                                ],
                              )
                            : Container(),
                        selected: questionController
                            .extraQuestion[index].isSelected.value,
                        onChanged: (xc) {
                          questionController
                                  .extraQuestion[index].isSelected.value =
                              !questionController
                                  .extraQuestion[index].isSelected.value;
                          if (questionController
                              .extraQuestion[index].isSelected.value) {
                            print('ans=3=');

                            questionController.specialist.value =
                                questionController
                                    .extraQuestion[index].speciality;
                            print(
                                "subques speciality-${questionController.extraQuestion[index].speciality}");
                            questionController.selectedans3.value =
                                questionController.extraQuestion[index].quesTag;
                          }

                          for (int i = 0;
                              i < questionController.extraQuestion.length;
                              i++) {
                            if (i != index) {
                              questionController
                                  .extraQuestion[i].isSelected.value = false;
                            }
                          }
                          questionController.extraQuestion.refresh();
                          // print("answer=${currentAnswer[index]}");
                          // currentAnswer[
                          //         questionController.extraQuestion[index].id] =
                          //     !currentAnswer[
                          //         questionController.extraQuestion[index].id];

                          // // currentAnswer[index] = !currentAnswer[index];
                          // for (int i = 0; i < currentAnswer.length; i++) {
                          //   if (i != index) {
                          //     currentAnswer[i] = false;
                          //   }
                          // }
                          // questionController.extraQuestionChoice.refresh();
                        },
                        toggleable: true),
                  ),
                )),
              ));
    }

    Widget answerCard(questionIndex) {
      var answerOption =
          questionController.answerList[questionIndex].split('~');
      print("answerOpttion=${answerOption}");
      var currentAnswer = questionIndex == 0
          ? questionController.ans0
          : questionIndex == 1
              ? questionController.ans1
              : questionIndex == 2
                  ? questionController.ans2
                  : questionController.ans3;
      return Sizer(
          builder: (context, orientation, deviceType) => ListView.separated(
                separatorBuilder: (context, index) => SizedBox(height: 10),
                shrinkWrap: true,
                itemCount: answerOption.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => Container(
                    child: Container(
                  child: Obx(
                    () => RadioListTile<bool>(
                        subtitle: questionController.extraQuestion.isNotEmpty &&
                                questionIndex == 3 &&
                                currentAnswer[index]
                            ? Column(children: [
                                extraQuestionCard(2),
                                extraanswerCard(2)
                              ])
                            : Container(),
                        title: Text(answerOption[index]),
                        value: currentAnswer[index],
                        groupValue: true,
                        selected: currentAnswer[index],
                        onChanged: (xc) {
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
                              questionController.selectedans2.value =
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

    return Sizer(
      builder: (context, orientation, deviceType) => Column(children: [
        questionCard(0),
        answerCard(0),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              width: 100.0.w,
              child: Text(
                'Child\'s Age:',
                style: TextStyle(color: Colors.white),
              )),
        ),
        questionCard(1),
        answerCard(1),
        questionCard(2),
        answerCard(2),
        // extraanswerCard(0),
        questionCard(3),
        Obx(() => questionController.extraQuestion.value.length > 0
            ? extraanswerCardList()
            : Container())

        // answerCard(3),
        // Obx(() => questionController.extraQuestion.length != 0
        //     ? Column(
        //         children: [extraQuestionCard(2), extraanswerCard(2)],
        //       )
        //     : Container())
      ]),
    );
  }
}
