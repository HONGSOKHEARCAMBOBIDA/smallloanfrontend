import 'package:get/get.dart';
import 'package:loanfrontend/core/constant/api_endpoint.dart';
import 'package:loanfrontend/data/models/journalmodel.dart';
import 'package:loanfrontend/module/journal/service/journalservice.dart';
import 'package:loanfrontend/share/widgets/snackbar.dart';

class Journalcontroller extends GetxController {
  final Journalservice service = Journalservice();
  var isLoading = false.obs;
  var journaldata = <Data>[].obs;
  final RxString searchQuery = ''.obs;
  final RxString between = ''.obs;
  var isLoadingMore = false.obs;
  var hasMore = true.obs;
  var currentPage = 1.obs;

  @override
  void onInit() {
    debounce(searchQuery, (_) {
      currentPage.value = 1;
      hasMore.value = true;
      getjournal(
          reference_code: searchQuery.value,
          isRefresh: true,
          between: between.value);
    }, time: const Duration(microseconds: 200));
    super.onInit();
  }

  Future<void> createjournal(
      {required String date,
      required int debit_account_id,
      required int credit_account_id,
      required double amount,
      required String description}) async {
    try {
      isLoading.value = true;
      final iscreated = await service.createjournal(
          date: date,
          debit_account_id: debit_account_id,
          credit_account_id: credit_account_id,
          amount: amount,
          description: description);
      if (iscreated) {
        Get.back();
        CustomSnackbar.success(
            title: Message.Success, message: Message.CreateSuccess);
      } else {
        CustomSnackbar.error(
            title: Message.Error, message: Message.CreateError);
      }
    } catch (e) {
      CustomSnackbar.error(title: "Error", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updatejournal(
      {required int id,
      required String date,
      required int debit_account_id,
      required int credit_account_id,
      required double amount,
      required String description}) async {
    try {
      isLoading.value = true;
      final isupdate = await service.updatejournal(
          id: id,
          date: date,
          debit_account_id: debit_account_id,
          credit_account_id: credit_account_id,
          amount: amount,
          description: description);
      if (isupdate) {
        Get.back();
        CustomSnackbar.success(
            title: Message.Success, message: Message.UpdateSuccess);
      } else {
        CustomSnackbar.error(
            title: Message.Error, message: Message.UpdateError);
      }
    } catch (e) {
      CustomSnackbar.error(title: Message.Error, message: e.toString());
    } finally {
      isLoading.value = true;
    }
  }

  Future<void> deletejournal({required int id}) async {
    try {
      isLoading.value = true;
      final isdelete = await service.deletejournal(id: id);
      if (isdelete) {
        CustomSnackbar.success(
            title: Message.Success, message: Message.DeleteSuccess);
      } else {
        CustomSnackbar.error(title: Message.Error, message: Message.Error);
      }
    } catch (e) {
      CustomSnackbar.error(title: Message.Error, message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getjournal(
      {String? reference_code,
      String? between,
      int pageSize = 15,
      bool isRefresh = false,
      bool loadMore = false}) async {
    if (loadMore && (!hasMore.value || isLoadingMore.value)) return;
    try {
      if (loadMore) {
        isLoadingMore.value = true;
      } else {
        isLoading.value = true;
      }
      if (isRefresh) {
        journaldata.clear();
        currentPage.value = 1;
        hasMore.value = true;
      }
      final result = await service.getjournal(
          reference_code: reference_code,
          between: between,
          page: currentPage.value,
          pageSize: pageSize);
      if (loadMore) {
        journaldata.addAll(result);
      } else {
        journaldata.assignAll(result);
      }
      if (journaldata.length < pageSize) {
        hasMore.value = false;
      }
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
    await getjournal(
        reference_code: searchQuery.value.isEmpty ? null : searchQuery.value,
        between: between.value.isEmpty ? null : between.value,
        loadMore: true);
  }
}
