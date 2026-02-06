import 'package:get/get.dart';
import 'package:loanfrontend/module/chartaccount/controller/chartaccountcontroller.dart';

class Chartaccountbinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<Chartaccountcontroller>(() => Chartaccountcontroller());
  }
}
