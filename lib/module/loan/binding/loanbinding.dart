import 'package:get/get.dart';
import 'package:loanfrontend/module/loan/controller/loancontroller.dart';

class Loanbinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<LoanController>(() => LoanController());
  }
}
