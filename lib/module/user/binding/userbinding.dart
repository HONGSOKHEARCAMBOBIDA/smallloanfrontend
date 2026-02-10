import 'package:get/get.dart';
import 'package:loanfrontend/module/user/controller/usercontroller.dart';

class Userbinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<Usercontroller>(() => Usercontroller());
  }
}
