import 'package:confetti/confetti.dart';
import 'package:get/get.dart';
import 'package:loanfrontend/core/constant/api_endpoint.dart';
import 'package:loanfrontend/data/models/recieptmodel.dart';
import 'package:loanfrontend/module/reciept/service/recieptservice.dart';
import 'package:loanfrontend/share/widgets/snackbar.dart';

class Recieptcontroller extends GetxController {
  final Recieptservice service = Recieptservice();
  var isLoading = false.obs;
  var isLoadingMore = false.obs;
  var hasMore = true.obs; // Make it observable
  var currentPage = 1.obs; // Make it observable
  var reciept = <Data>[].obs;
  late ConfettiController confettiController;
  final RxString searchQuery = ''.obs;
  @override
  void onInit() {
    super.onInit();
    confettiController =
        ConfettiController(duration: const Duration(seconds: 2));
    debounce(searchQuery, (_) {
      currentPage.value = 1;
      hasMore.value = true;
      getreciept(
          client_name: searchQuery.value,
          village_name: searchQuery.value,
          isRefresh: true);
    });
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

  Future<void> getreciept({
    String? client_name,
    String? village_name,
    bool isRefresh = false,
    bool loadMore = false,
    int pageSize = 10,
  }) async {
    if (loadMore && (!hasMore.value || isLoading.value)) return;
    try {
      if (loadMore) {
        isLoadingMore.value = true;
      } else {
        isLoading.value = true;
      }
      if (isRefresh) {
        reciept.clear();
        currentPage.value = 1;
        hasMore.value = true;
      }
      final result = await service.getreciept(
          client_name: client_name,
          village_name: village_name,
          page: currentPage.value,
          pageSize: pageSize);
      if (loadMore) {
        reciept.addAll(result);
      } else {
        reciept.assignAll(result);
      }
      if (result.length < pageSize) {
        hasMore.value = false;
      }
      if (result.isNotEmpty) {
        currentPage.value++;
      }
    } catch (e) {
      CustomSnackbar.error(title: Message.Error, message: e.toString());
    } finally {
      isLoading.value = false;
      isLoadingMore.value = false;
    }
  }

  Future<void> loadMore() async {
    await getreciept(
      client_name: searchQuery.value.isEmpty ? null : searchQuery.value,
      village_name: searchQuery.value.isEmpty ? null : searchQuery.value,
      loadMore: true,
    );
  }
}
