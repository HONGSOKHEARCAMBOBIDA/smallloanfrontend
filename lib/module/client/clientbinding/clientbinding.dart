import 'package:get/get.dart';
import 'package:loanfrontend/module/client/clientcontroller/clientcontroller.dart';

class Clientbinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClientController>(() => ClientController());
  }
}
