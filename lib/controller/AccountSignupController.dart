import 'package:get/get.dart';

class AccountSignUpController extends GetxController {
  var currentType = 'patient'.obs;
  var isRegisterLoading = false.obs;
  var weekdayList = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
  var weekdayBool = [false, false, false, false, false, false, false].obs;

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
