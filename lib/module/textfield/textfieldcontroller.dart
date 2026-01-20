import 'package:get/get.dart';

class TextFieldController extends GetxController {
  var obscureText = false.obs;
  
  void toggleObscureText() {
    obscureText.value = !obscureText.value;
  }
}