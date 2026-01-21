import 'package:get/get.dart';
import 'package:loanfrontend/module/village/villagecontroller/villagecontroller.dart';

class Villagebinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Villagecontroller>(() => Villagecontroller());
  }
}
