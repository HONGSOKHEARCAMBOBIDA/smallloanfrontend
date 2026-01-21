import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loanfrontend/module/client/clientservice/clientservice.dart';
import 'package:loanfrontend/share/widgets/snackbar.dart';

class ClientController extends GetxController {
  final ClientService clientService = ClientService();
  final ImagePicker imagePicker = ImagePicker();

  var isLoading = false.obs;
  var clientImage = Rx<File?>(null);

  Future<void> pickImage() async {
    final XFile? pickedFile =
        await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      clientImage.value = File(pickedFile.path);
    }
  }

  Future<void> createclient({
    required String name,
    required int gender,
    required String maritalStatus,
    required String dateOfBirth,
    required String occupation,
    required String idCardNumber,
    required String phone,
    required int villageId,
    String? notes,
  }) async {
    try {
      isLoading.value = true;

      final isCreated = await clientService.createclient(
        name: name,
        gender: gender,
        maritalStatus: maritalStatus,
        dateOfBirth: dateOfBirth,
        occupation: occupation,
        idCardNumber: idCardNumber,
        phone: phone,
        villageId: villageId,
        notes: notes,
        clientImage: clientImage.value,
      );

      if (isCreated) {
        Get.back();
        CustomSnackbar.success(title: "Success", message: "Client added");
      }
    } catch (e) {
      CustomSnackbar.error(title: "Error", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
