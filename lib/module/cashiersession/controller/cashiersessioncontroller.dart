import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:confetti/confetti.dart';
import 'package:loanfrontend/core/constant/api_endpoint.dart';
import 'package:loanfrontend/data/models/cashiersession.dart';
import 'package:loanfrontend/module/cashiersession/service/cashiersessionservice.dart';
import 'package:loanfrontend/share/widgets/snackbar.dart';

class Cashiersessioncontroller extends GetxController {
  final Cashiersessionservice service = Cashiersessionservice();

  var session = <Data>[].obs;
  var isLoading = false.obs;

  late ConfettiController confettiController;

  @override
  void onInit() {
    super.onInit();
    confettiController =
        ConfettiController(duration: const Duration(seconds: 2));
    getcashiersession();
  }

  @override
  void onClose() {
    confettiController.dispose();
    super.onClose();
  }

  Future<void> createcashiersession() async {
    try {
      isLoading.value = true;

      final iscreate = await service.createcashiersession();
      if (iscreate) {
        await getcashiersession();
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

  Future<void> getcashiersession() async {
    try {
      isLoading.value = true;
      final result = await service.getcashiersession();
      session.assignAll(result);
    } catch (e) {
      CustomSnackbar.error(
        title: Message.Error,
        message: e.toString(),
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> verify(int id) async {
    try {
      isLoading.value = true;
      final verify = await service.verify(id);
      if (verify) {
        await getcashiersession();
        CustomSnackbar.success(
            title: Message.Success, message: Message.Verifysuccess);
      }
    } catch (e) {
      CustomSnackbar.error(title: Message.Error, message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
