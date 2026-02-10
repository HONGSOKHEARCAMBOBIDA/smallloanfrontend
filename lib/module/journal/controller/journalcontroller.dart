import 'package:get/get.dart';
import 'package:loanfrontend/core/constant/api_endpoint.dart';
import 'package:loanfrontend/data/models/journalmodel.dart';
import 'package:loanfrontend/module/journal/service/journalservice.dart';
import 'package:loanfrontend/share/widgets/snackbar.dart';
import 'package:loanfrontend/data/models/balanchsheetmodel.dart' as model;
import 'package:loanfrontend/data/models/incomestatementmodel.dart'
    as incomestatementmodel;

class Journalcontroller extends GetxController {
  final Journalservice service = Journalservice();
  var isLoading = false.obs;
  var journaldata = <Data>[].obs;
  final RxString searchQuery = ''.obs;
  final RxString between = ''.obs;
  var isLoadingMore = false.obs;
  var hasMore = true.obs;
  var currentPage = 1.obs;
  var balanceSheetData = Rxn<model.BalanchsheetModel>();
  var incomestaement = incomestatementmodel.Data().obs;
  var selectedDate = ''.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    final now = DateTime.now();
    selectedDate.value =
        '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
    getBalanceSheet(endate: selectedDate.value);
    getincomestatement(endate: selectedDate.value);
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
        await getjournal(isRefresh: true);
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
      required String transaction_date,
      required int chart_account_id,
      required double debit_amount,
      required double credit_amount,
      required String description}) async {
    try {
      isLoading.value = true;
      final isupdate = await service.updatejournal(
          id: id,
          transaction_date: transaction_date,
          chart_account_id: chart_account_id,
          debit_amount: debit_amount,
          credit_amount: credit_amount,
          description: description);
      if (isupdate) {
        await getjournal(isRefresh: true);
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
      isLoading.value = false;
    }
  }

  Future<void> deletejournal({required int id}) async {
    try {
      final isdelete = await service.deletejournal(id: id);
      if (isdelete) {
        journaldata.removeWhere((item) => item.id == id);
      } else {
        CustomSnackbar.error(title: Message.Error, message: Message.Error);
      }
    } catch (e) {
      CustomSnackbar.error(title: Message.Error, message: e.toString());
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

  Future<void> getBalanceSheet({required String endate}) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final result = await service.getBalanceSheet(enddate: endate);

      if (result != null) {
        balanceSheetData.value = result;
        selectedDate.value = endate;
      } else {
        errorMessage.value =
            'No balance sheet data found for the selected date';
      }
    } catch (e) {
      errorMessage.value = 'Failed to fetch balance sheet: ${e.toString()}';
      CustomSnackbar.error(title: 'Error', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  int get totalAssets => balanceSheetData.value?.data?.totals?.totalAssets ?? 0;
  int get totalLiabilities =>
      balanceSheetData.value?.data?.totals?.totalLiabilities ?? 0;
  int get totalEquity => balanceSheetData.value?.data?.totals?.totalEquity ?? 0;
  bool get isBalanced =>
      balanceSheetData.value?.data?.totals?.isBalanced ?? false;

  Future<void> getincomestatement({required String endate}) async {
    try {
      isLoading.value = true;

      final result = await service.getincomestatement(enddate: endate);

      if (result != null) {
        incomestaement.value = result; // ✅ correct
        selectedDate.value = endate;
      } else {
        CustomSnackbar.error(
          title: Message.Error,
          message: Message.BadRequest,
        );
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
