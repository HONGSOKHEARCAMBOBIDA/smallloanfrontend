import 'package:get/get.dart';
import 'package:loanfrontend/module/documenttype/controller/documenttyecontroller.dart';

class Documenttypebinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<Documenttyecontroller>(() => Documenttyecontroller());
  }
}
