import 'package:get/get.dart';
import 'package:loanfrontend/core/constant/api_endpoint.dart';
import 'package:loanfrontend/data/models/usermodel.dart';
import 'package:loanfrontend/module/user/service/userservice.dart';
import 'package:loanfrontend/share/widgets/snackbar.dart';

class Usercontroller extends GetxController {
  final service = Userservice();
  var data = <Data>[].obs;
  var isLoading = false.obs;
  @override
  void onInit() {
    getuser();
    super.onInit();
  }

  Future<void> register(
      {required String name,
      required String password,
      required int roleid,
      required String phone}) async {
    try {
      isLoading.value = true;
      final iscreate = await service.register(
          name: name, password: password, roleid: roleid, phone: phone);
      if (iscreate) {
        CustomSnackbar.success(
            title: Message.Success, message: Message.CreateSuccess);
        Get.back();
      } else {
        CustomSnackbar.error(
            title: Message.Error, message: Message.CreateError);
      }
    } catch (e) {
      CustomSnackbar.error(title: Message.Error, message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateuser(
      {required int id,
      required String name,
      required String username,
      required int role_id,
      required String email,
      required String phone}) async {
    try {
      isLoading.value = true;
      final isupdate = await service.updateuser(
          id: id,
          name: name,
          username: username,
          role_id: role_id,
          email: email,
          phone: phone);
      if (isupdate) {
        CustomSnackbar.success(
            title: Message.Success, message: Message.UpdateSuccess);
      } else {
        CustomSnackbar.error(
            title: Message.Error, message: Message.UpdateError);
      }
    } catch (e) {
      CustomSnackbar.error(title: Message.Error, message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getuser() async {
    try {
      isLoading.value = true;
      final result = await service.getuser();
      data.assignAll(result);
    } catch (e) {
      CustomSnackbar.error(title: Message.Error, message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
