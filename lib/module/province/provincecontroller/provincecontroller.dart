import 'package:get/get.dart';
import 'package:loanfrontend/core/constant/api_endpoint.dart';
import 'package:loanfrontend/data/models/provincemodel.dart';
import 'package:loanfrontend/module/province/provinceservice/provinceservice.dart';
import 'package:loanfrontend/share/widgets/snackbar.dart';

class Provincecontroller extends GetxController {
  final Provinceservice provinceservice = Provinceservice();

  var provinces = <Data>[].obs; // ✅ Correct type

  @override
  void onInit() {
    fetchprovince();
    super.onInit();
  }

  Future<void> fetchprovince() async {
    try {
      final result = await provinceservice.getProvince();
      provinces.assignAll(result);
    } catch (e) {
      CustomSnackbar.error(title: Message.Error, message: e.toString());
    }
  }
}
