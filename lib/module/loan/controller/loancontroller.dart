import 'package:get/get.dart';
import 'package:loanfrontend/core/constant/api_endpoint.dart';
import 'package:loanfrontend/data/models/loancheckmodel.dart';
import 'package:loanfrontend/data/models/loanmodel.dart' as loanmodel;
import 'package:loanfrontend/module/loan/service/loanservice.dart';
import 'package:loanfrontend/share/widgets/snackbar.dart';
import 'package:loanfrontend/data/models/loanapprovemodel.dart' as modelapprove;

class LoanController extends GetxController {
  final Loanservice service = Loanservice();
  var isLoading = false.obs;
  var loanforcheck = <Data>[].obs;
  var loanforapprove = <modelapprove.Data>[].obs;
  var loan = <loanmodel.Data>[].obs;
  final RxString searchQuery = ''.obs;
  var isLoadingMore = false.obs;
  var hasMore = true.obs;
  var currentPage = 1.obs;

  @override
  void onInit() {
    debounce(searchQuery, (_) {
      currentPage.value = 1;
      hasMore.value = true;
      getloan(name: searchQuery.value, isRefresh: true);
    }, time: const Duration(microseconds: 200));
    super.onInit();
  }

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

  Future<void> getloanforcheck() async {
    try {
      isLoading.value = true;
      final result = await service.getloanforcheck();
      loanforcheck.assignAll(result);
    } catch (e) {
      CustomSnackbar.error(title: Message.Error, message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getloanforapprove() async {
    try {
      isLoading.value = true;
      final result = await service.getloanforapprove();
      loanforapprove.assignAll(result);
    } catch (e) {
      CustomSnackbar.error(title: Message.Error, message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> checkloan(id) async {
    try {
      isLoading.value = true;
      final ischecked = await service.checkloan(id);
      if (ischecked) {
        await getloanforcheck();
        CustomSnackbar.success(
            title: Message.Success, message: Message.Checksuccess);
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

  Future<void> approveloan(id) async {
    try {
      isLoading.value = true;
      final isapprove = await service.approveloan(id);
      if (isapprove) {
        await getloanforapprove();
        CustomSnackbar.success(
            title: Message.Success, message: Message.Approvesuccess);
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

  Future<void> getloan(
      {String? name,
      String? startdate,
      int pageSize = 10,
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
        loan.clear();
        currentPage.value = 1;
        hasMore.value = true;
      }
      final result = await service.getloan(
          name: name,
          startdate: startdate,
          page: currentPage.value,
          pageSize: pageSize);

      if (loadMore) {
        loan.addAll(result);
      } else {
        loan.assignAll(result);
      }
      if (result.length < pageSize) {
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
    await getloan(
        name: searchQuery.value.isEmpty ? null : searchQuery.value,
        loadMore: true);
  }

  Future<void> deleteLoanbeforapprove({required int id}) async {
    try {
      isLoading.value = true;
      final isdelete = await service.deleteLoanbeforapprove(id: id);
      if (isdelete) {
        await getloanforcheck();
        await getloanforapprove();
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
}
