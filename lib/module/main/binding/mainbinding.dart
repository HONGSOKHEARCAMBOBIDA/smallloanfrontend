import 'package:get/get.dart';
import 'package:loanfrontend/module/main/maincontroller/maincontroller.dart';

class MainBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainController(), fenix: true);
    // // Add other controllers like this:
    // Get.lazyPut(() => Branchcontroller());
    // Get.lazyPut(() => Usercontroller());
    // Get.lazyPut(() => Loancontroller());
  }
}