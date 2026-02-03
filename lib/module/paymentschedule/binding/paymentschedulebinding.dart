import 'package:get/get.dart';
import 'package:loanfrontend/module/paymentschedule/controller/paymentschedulecontroller.dart';

class Paymentschedulebinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<Paymentschedulecontroller>(() => Paymentschedulecontroller());
  }
}
