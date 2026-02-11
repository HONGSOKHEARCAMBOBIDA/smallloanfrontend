import 'package:get/get.dart';
import 'package:loanfrontend/module/role/binding/rolebinding.dart';
import 'package:loanfrontend/module/user/binding/userbinding.dart';

class Updateuserbinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Userbinding().dependencies();
    Rolebinding().dependencies();
  }
}
