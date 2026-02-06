import 'package:get/get.dart';
import 'package:loanfrontend/core/constant/api_endpoint.dart';
import 'package:loanfrontend/data/models/chataccountmodel.dart';
import 'package:loanfrontend/module/chartaccount/service/chartaccountservice.dart';
import 'package:loanfrontend/share/widgets/snackbar.dart';

class Chartaccountcontroller extends GetxController {
  final Chartaccountservice service = Chartaccountservice();
  var data = <Data>[].obs;
  var isLoading = false.obs;
  @override
  void onInit() {
    getchataccount();
    super.onInit();
  }

  Future<void> getchataccount() async {
    try {
      isLoading.value = true;
      final res = await service.getchataccount();
      data.assignAll(res);
    } catch (e) {
      CustomSnackbar.error(title: Message.Error, message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
