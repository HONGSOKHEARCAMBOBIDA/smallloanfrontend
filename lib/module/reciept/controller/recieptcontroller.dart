import 'package:confetti/confetti.dart';
import 'package:get/get.dart';
import 'package:loanfrontend/core/constant/api_endpoint.dart';
import 'package:loanfrontend/data/models/recieptmodel.dart';
import 'package:loanfrontend/module/reciept/service/recieptservice.dart';
import 'package:loanfrontend/share/widgets/snackbar.dart';
import 'package:loanfrontend/data/models/recieptlistmodel.dart' as model;

class Recieptcontroller extends GetxController {
  final Recieptservice service = Recieptservice();
  var isLoading = false.obs;
  var isLoadingMore = false.obs;
  var hasMore = true.obs; // Make it observable
  var currentPage = 1.obs; // Make it observable
  var reciept = <Data>[].obs;
  var recieptlist = <model.Data>[].obs;
  var isLoadingList = false.obs;
  var isLoadingMoreList = false.obs;
  var hasMoreList = true.obs; // Make it observable
  var currentPageList = 1.obs; // Make it observable
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
        await getreciept(isRefresh: true);
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

Future<void> getrecieptlist({
  String? client_name,
  int? co_id,
  String? start,
  String? end,
  bool isRefresh = false,
  bool loadMore = false,
  int pageSize = 10,
}) async {
  if (loadMore && (!hasMoreList.value || isLoadingMoreList.value)) return; // Fixed: use hasMoreList
  try {
    if (loadMore) {
      isLoadingMoreList.value = true;
    } else {
      isLoadingList.value = true; // Fixed: use isLoadingList for initial load
    }
    if (isRefresh) {
      recieptlist.clear();
      currentPageList.value = 1;
      hasMoreList.value = true;
    }
    final result = await service.listreciept(
        client_name: client_name,
        co_id: co_id,
        start: start,
        end: end,
        page: currentPageList.value,
        pageSize: pageSize);
   
    if (loadMore) {
      recieptlist.addAll(result);
    } else {
      recieptlist.assignAll(result);
    }
    if (result.length < pageSize) {
      hasMoreList.value = false;
    }
    if (result.isNotEmpty) {
      currentPageList.value++;
    }
  } catch (e) {
    CustomSnackbar.error(title: Message.Error, message: e.toString());
  } finally {
    isLoadingList.value = false; // Fixed: use isLoadingList
    isLoadingMoreList.value = false;
  }
}

  Future<void> loadMore() async {
    await getreciept(
      client_name: searchQuery.value.isEmpty ? null : searchQuery.value,
      village_name: searchQuery.value.isEmpty ? null : searchQuery.value,
      loadMore: true,
    );
  }

  Future<void> loadMorelist({
    String? client_name,
    int? co_id,
    String? start,
    String? end,
  }) async {
    await getrecieptlist(
        client_name: client_name,
        co_id: co_id,
        start: start,
        end: end,
        loadMore: true);
  }

  Future<void> delete({required int id}) async {
    try {
      isLoading.value = true;
      final isdelete = await service.delete(id: id);
      if(isdelete){
           Get.back();           
      }
    }catch(e){
       CustomSnackbar.error(title: Message.Error, message: e.toString());
    }finally{
      isLoading.value= false;
    }
  }
}
