import 'package:get/get.dart';

class DoctorProfileController extends GetxController {
  var currentType = 'patient'.obs;
  var isRegisterLoading = false.obs;
  var weekdayList = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
  var weekdayBool = [false, false, false, false, false, false, false].obs;
  var weekdayIndex = 7.obs;

  List<String> mergerTime() {
    List<String> test = [];
    for (int i = 0; i < weekdayTimeFrom.length; i++) {
      test.add('${weekdayTimeFrom[i]}-${weekdayTimeTo[i]}');
    }
    return test;
  }

  var weekdayTimeFrom = [
    "Select Time",
    "Select Time",
    "Select Time",
    "Select Time",
    "Select Time",
    "Select Time",
    "Select Time"
  ].obs;
  var weekdayTimeTo = [
    "Select Time",
    "Select Time",
    "Select Time",
    "Select Time",
    "Select Time",
    "Select Time",
    "Select Time"
  ].obs;
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

  var selectedTime = 'Select Time'.obs;
  var welcomeText =
      'Hello patient \n Please enter your details to get started'.obs;
  void setCurrentType(type) {
    if (type == 'patient') {
      currentType.value = 'patient';
      welcomeText.value =
          'Hello patient, \n Please enter your details to get started';
    } else {
      currentType.value = 'doctor';
      welcomeText.value =
          'Hello doctor, \n Please enter your details to get started';
    }
  }
}
