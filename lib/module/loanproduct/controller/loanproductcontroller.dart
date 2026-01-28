import 'package:get/get.dart';
import 'package:loanfrontend/data/models/loanproductmodel.dart';
import 'package:loanfrontend/module/loanproduct/service/loanproductservice.dart';
import 'package:loanfrontend/share/widgets/snackbar.dart';

class Loanproductcontroller extends GetxController {
  final Loanproductservice service = Loanproductservice();
  var loanproduct = <Data>[].obs;
  @override
  void onInit() {
    getloanproduct();
    super.onInit();
  }

  Future<void> getloanproduct() async {
    try {
      final result = await service.getloanproduct();
      loanproduct.assignAll(result);
    } catch (e) {
      CustomSnackbar.error(title: "មានបញ្ហា", message: e.toString());
    }
  }
}
