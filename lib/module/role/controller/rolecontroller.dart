import 'package:get/get.dart';
import 'package:loanfrontend/core/constant/api_endpoint.dart';
import 'package:loanfrontend/data/models/rolemodel.dart';
import 'package:loanfrontend/module/role/service/roleservice.dart';
import 'package:loanfrontend/share/widgets/snackbar.dart';

class Rolecontroller extends GetxController {
  final service = Roleservice();
  var data = <Data>[].obs;
  var isLoading = false.obs;
  @override
  void onInit() {
    getrole();
    super.onInit();
  }

  Future<void> getrole() async {
    try {
      isLoading.value = true;
      final result = await service.getrole();
      data.assignAll(result);
    } catch (e) {
      CustomSnackbar.error(title: Message.Error, message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
