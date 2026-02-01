import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loanfrontend/core/constant/api_endpoint.dart';
import 'package:loanfrontend/data/models/clientlistmodel.dart';
import 'package:loanfrontend/module/client/clientservice/clientservice.dart';
import 'package:loanfrontend/share/widgets/snackbar.dart';
import 'package:uuid/uuid.dart';
import 'package:loanfrontend/data/models/clientmodel.dart' as clientmodel;

class ClientController extends GetxController {
  final ClientService clientService = ClientService();
  final ImagePicker imagePicker = ImagePicker();
  var client = <Data>[].obs;
  var clientforcreateloan = <clientmodel.Data>[].obs;
  final RxString searchQuery = ''.obs;
  var isLoading = false.obs;
  var isLoadingMore = false.obs;
  XFile? clientImage;
  var hasMore = true.obs; // Make it observable
  var currentPage = 1.obs; // Make it observable

  @override
  void onInit() {
    debounce(
      searchQuery,
      (_) {
        currentPage.value = 1;
        hasMore.value = true;
        listclient(name: searchQuery.value, isRefresh: true);
      },
      time: const Duration(milliseconds: 200),
    );
    super.onInit();
  }

  Future<XFile?> pickImage() async {
    final XFile? pickedFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      clientImage = pickedFile;

      return clientImage;
    }
    return null;
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
        clientImage: clientImage,
        idempotency: Uuid().v4().substring(8),
      );

      if (isCreated) {
        await listclient(isRefresh: true);
        Get.back();
        CustomSnackbar.success(title: "Success", message: "Client added");
      }
    } catch (e) {
      CustomSnackbar.error(title: "Error", message: e.toString());
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> listclient({
    String? name,
    int pageSize = 10,
    bool isRefresh = false,
    bool loadMore = false,
  }) async {
    // var isLoading = false.obs;
    // var isLoadingMore = false.obs;
    // var hasMore = true.obs; // Make it observable
    // var currentPage = 1.obs; // Make it observable
    if (loadMore && (!hasMore.value || isLoadingMore.value)) return;

    try {
      if (loadMore) {
        isLoadingMore.value = true;
      } else {
        isLoading.value = true;
      }

      if (isRefresh) {
        client.clear();
        currentPage.value = 1;
        hasMore.value = true;
      }

      final result = await clientService.listclient(
        name: name,
        page: currentPage.value,
        pageSize: pageSize,
      );

      if (loadMore) {
        client.addAll(result);
      } else {
        client.assignAll(result);
      }

      // Update hasMore
      if (result.length < pageSize) {
        hasMore.value = false;
      }

      // Increase page ONLY after successful load
      if (result.isNotEmpty) {
        currentPage.value++;
      }
    } catch (e) {
      CustomSnackbar.error(title: "មានបញ្ហា", message: e.toString());
    } finally {
      isLoading.value = false;
      isLoadingMore.value = false;
    }
  }

  Future<void> loadMore() async {
    await listclient(
      name: searchQuery.value.isEmpty ? null : searchQuery.value,
      loadMore: true,
    );
  }

  Future<void> updateclient({
    required int id,
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

      final isUpdated = await clientService.updateclient(
        id: id,
        name: name,
        gender: gender,
        maritalStatus: maritalStatus,
        dateOfBirth: dateOfBirth,
        occupation: occupation,
        idCardNumber: idCardNumber,
        phone: phone,
        villageId: villageId,
        notes: notes,
        clientImage: clientImage,
      );

      if (isUpdated) {
        await listclient(isRefresh: true);
        Get.back();
        CustomSnackbar.success(title: Message.Success, message: Message.UpdateSuccess);
      }
    } catch (e) {
      CustomSnackbar.error(title: "Error", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getclientforcreateloan() async {
    try {
      final result = await clientService.getclientforcreateloan();
      clientforcreateloan.assignAll(result);
    } catch (e) {
      CustomSnackbar.error(title: "មានបញ្ហា", message: e.toString());
    }
  }
}
