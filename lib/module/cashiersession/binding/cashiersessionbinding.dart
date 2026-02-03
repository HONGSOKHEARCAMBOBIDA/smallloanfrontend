import 'package:get/get.dart';
import 'package:loanfrontend/module/cashiersession/controller/cashiersessioncontroller.dart';

class Cashiersessionbinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<Cashiersessioncontroller>(() => Cashiersessioncontroller());
  }
}
