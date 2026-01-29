import 'package:get/get.dart';
import 'package:loanfrontend/data/models/documenttypemodel.dart';
import 'package:loanfrontend/module/documenttype/service/documenttypeservice.dart';
import 'package:loanfrontend/share/widgets/snackbar.dart';

class Documenttyecontroller extends GetxController {
  final Documenttypeservice service = Documenttypeservice();
  var documenttype = <Data>[].obs;
  @override
  void onInit() {
    getdocumenttype();
    super.onInit();
  }

  Future<void> getdocumenttype() async {
    try {
      final result = await service.getdocumenttype();
      documenttype.assignAll(result);
    } catch (e) {
      CustomSnackbar.error(title: "មានបញ្ហា", message: e.toString());
    }
  }
}
