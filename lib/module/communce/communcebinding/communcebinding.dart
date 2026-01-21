import 'package:get/get.dart';
import 'package:loanfrontend/module/communce/communcecontroller/communcecontroller.dart';

class Communcebinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Communcecontroller>(() => Communcecontroller());
  }
}
