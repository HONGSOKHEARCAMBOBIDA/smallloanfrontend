import 'package:get/get.dart';
import 'package:loanfrontend/module/reciept/controller/recieptcontroller.dart';

class Recieptbinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<Recieptcontroller>(() => Recieptcontroller());
  }
}
