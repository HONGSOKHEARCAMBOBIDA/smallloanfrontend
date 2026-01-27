import 'package:get/get.dart';
import 'package:loanfrontend/module/client/clientbinding/clientbinding.dart';
import 'package:loanfrontend/module/communce/communcebinding/communcebinding.dart';
import 'package:loanfrontend/module/district/districtbinding/districtbinding.dart';
import 'package:loanfrontend/module/province/provincebinding/provincebinding.dart';
import 'package:loanfrontend/module/village/villagebinding/villagebinding.dart';

class Updateclientbinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Clientbinding().dependencies();
    Provincebinding().dependencies();
    Districtbinding().dependencies();
    Communcebinding().dependencies();
    Villagebinding().dependencies();
  }
}
