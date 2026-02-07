import 'package:get/get.dart';
import 'package:loanfrontend/module/chartaccount/binding/chartaccountbinding.dart';
import 'package:loanfrontend/module/journal/binding/journalbinding.dart';

class Updatejournalbinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Journalbinding().dependencies();
    Chartaccountbinding().dependencies();
  }
}
