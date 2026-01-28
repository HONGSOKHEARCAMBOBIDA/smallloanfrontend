import 'package:get/get.dart';
import 'package:loanfrontend/module/loanproduct/controller/loanproductcontroller.dart';

class Loanproductbinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Loanproductcontroller>(() => Loanproductcontroller());
  }
}
