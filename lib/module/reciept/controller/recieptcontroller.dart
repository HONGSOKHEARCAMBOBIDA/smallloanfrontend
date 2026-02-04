import 'package:confetti/confetti.dart';
import 'package:get/get.dart';
import 'package:loanfrontend/core/constant/api_endpoint.dart';
import 'package:loanfrontend/module/reciept/service/recieptservice.dart';
import 'package:loanfrontend/share/widgets/snackbar.dart';

class Recieptcontroller extends GetxController {
  final Recieptservice service = Recieptservice();
  var isLoading = false.obs;
  late ConfettiController confettiController;
  @override
  void onInit() {
    super.onInit();
    confettiController =
        ConfettiController(duration: const Duration(seconds: 2));
  }

  @override
  void onClose() {
    confettiController.dispose();
    super.onClose();
  }

  Future<void> createreciept({required int total, required int id}) async {
    try {
      isLoading.value = true;
      final iscreate = await service.createreciept(total: total, id: id);
      if (iscreate) {
        Get.back();
        confettiController.play();
      }
    } catch (e) {
      CustomSnackbar.error(
        title: Message.Error,
        message: e.toString(),
      );
    } finally {
      isLoading.value = false;
    }
  }
}
