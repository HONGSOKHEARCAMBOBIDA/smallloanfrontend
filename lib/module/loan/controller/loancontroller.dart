import 'package:get/get.dart';
import 'package:loanfrontend/core/constant/api_endpoint.dart';
import 'package:loanfrontend/module/loan/service/loanservice.dart';
import 'package:loanfrontend/share/widgets/snackbar.dart';

class LoanController extends GetxController {
  final Loanservice service = Loanservice();
  var isLoading = false.obs;

  Future<void> createloan({
    required int clientid,
    required int loanproductid,
    required double loanamount,
    required String purpose,
    required int documenttypeid,
    required int checkby,
    required int approveby,
    required List<Map<String, dynamic>> guarantors,
  }) async {
    try {
      isLoading.value = true;

      final success = await service.createloan(
        clientid: clientid,
        loanproductid: loanproductid,
        loanamount: loanamount,
        purpose: purpose,
        documenttypeid: documenttypeid,
        checkby: checkby,
        approveby: approveby,
        guarantors: guarantors,
      );

      if (success) {
        Get.back();
        CustomSnackbar.success(
          title: Message.Success,
          message: Message.CreateSuccess,
        );
      } else {
        CustomSnackbar.error(
          title: Message.Error,
          message: Message.CreateError,
        );
      }
    } catch (e) {
      CustomSnackbar.error(title: "Error", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
