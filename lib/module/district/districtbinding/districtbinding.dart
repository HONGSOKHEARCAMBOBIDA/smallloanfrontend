import 'package:get/get.dart';
import 'package:loanfrontend/module/district/districtcontroller/districtcontroller.dart';

class Districtbinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<Districtcontroller>(() => Districtcontroller());
  }
}
