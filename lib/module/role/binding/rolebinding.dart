import 'package:get/get.dart';
import 'package:loanfrontend/module/role/controller/rolecontroller.dart';

class Rolebinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<Rolecontroller>(() => Rolecontroller());
  }
}
