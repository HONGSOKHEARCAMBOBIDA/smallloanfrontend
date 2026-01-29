import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loanfrontend/core/constant/api_endpoint.dart';
import 'package:loanfrontend/module/auth/authservice/authservice.dart';
import 'package:loanfrontend/module/main/binding/mainbinding.dart';
import 'package:loanfrontend/module/main/mainview/mainview.dart';
import 'package:loanfrontend/share/widgets/snackbar.dart';
import 'package:loanfrontend/data/models/usermodel.dart' as usermodel;

class AuthController extends GetxController {
  final AuthService authService = AuthService();
  var isLoading = false.obs;
  final GetStorage box = GetStorage();
  var user = <usermodel.Data>[].obs;
  Future<void> login(
      {required String username, required String password}) async {
    isLoading.value = true;
    try {
      final response =
          await authService.login(username: username, password: password);
      if (response.data?.token != null && response.data!.token!.isNotEmpty) {
        await box.write('token', response.data!.token);

        CustomSnackbar.success(
          title: "ជោគជ័យ",
          message: "ចូលបានសម្រេច",
        );

        Get.offAll(() => MainView(), binding: MainBinding());
      } else {
        CustomSnackbar.error(
          title: "បរាជ័យ",
          message: "លេខទូរសព្ទ ឬលេខសម្ងាត់ មិនត្រឹមត្រូវ",
        );
      }
    } catch (e) {
      CustomSnackbar.error(
        title: "បរាជ័យ",
        message: e.toString(),
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getuser() async {
    try {
      final result = await authService.getuser();
      user.assignAll(result);
    } catch (e) {
      CustomSnackbar.error(title: Message.Error, message: e.toString());
    }
  }
}
