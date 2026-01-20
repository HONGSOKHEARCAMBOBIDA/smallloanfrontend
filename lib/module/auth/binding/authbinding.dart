import 'package:get/get.dart';
import 'package:loanfrontend/module/auth/controller/authcontroller.dart';
class Authbinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(()=>AuthController());
  }
}