import 'package:get/get.dart';
import 'package:loanfrontend/module/journal/controller/journalcontroller.dart';
class Journalbinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<Journalcontroller>(()=>Journalcontroller());
  }
}