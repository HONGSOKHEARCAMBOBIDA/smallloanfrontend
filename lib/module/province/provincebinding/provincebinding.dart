import 'package:get/get.dart';
import 'package:loanfrontend/module/province/provincecontroller/provincecontroller.dart';

class Provincebinding extends Bindings {
  @override
  void dependencies() {
    // Lazy put: creates the controller only when it's used
    Get.lazyPut<Provincecontroller>(() => Provincecontroller());
  }
}
