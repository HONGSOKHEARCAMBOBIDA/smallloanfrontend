import 'package:get/get.dart';
import 'package:loanfrontend/core/constant/api_endpoint.dart';
import 'package:loanfrontend/data/models/rolemodel.dart';
import 'package:loanfrontend/data/providers/api_provider.dart';
import 'package:loanfrontend/module/role/service/roleservice.dart';
import 'package:loanfrontend/share/widgets/snackbar.dart';
import 'package:loanfrontend/data/models/rolepermission.dart' as mymodel;

class Rolecontroller extends GetxController {
  final service = Roleservice();
  final ApiProvider apiProvider = ApiProvider();
  var data = <Data>[].obs;
  var roleassingpermission = <mymodel.Data>[].obs;
  var isLoading = false.obs;
  final RxSet<int> changedPermissionIds = <int>{}.obs;
  final RxSet<int> deletepermissionIDs = <int>{}.obs;
  var searchQuery = ''.obs;
  @override
  void onInit() {
    getrole();
    super.onInit();
  }

  List<mymodel.Data> get filteredPermissions {
    if (searchQuery.value.isEmpty) {
      return roleassingpermission;
    }
    return roleassingpermission.where((p) {
      return p.displayName!
              .toLowerCase()
              .contains(searchQuery.value.toLowerCase()) ||
          p.name!.toLowerCase().contains(searchQuery.value.toLowerCase());
    }).toList();
  }

  void saveRolePermissions(int roleId) async {
    try {
      // ✅ Only permissions the user toggled
      List<int> selectedPermissionIds = changedPermissionIds.toList();

      if (selectedPermissionIds.isEmpty) {
        Get.snackbar('Info', 'No changes to save.');
        return;
      }

      final data = {'role_id': roleId, 'permission_ids': selectedPermissionIds};

      final response = await apiProvider.post('/addpermissiontorole', data);

      if (response.statusCode == 200) {
        CustomSnackbar.success(
          title: "ជោគជ័យ",
          message: "បន្ថែមសិទ្ធបានជោគជ័យ",
        );
        changedPermissionIds.clear(); // ✅ Clear after successful save
        await fetchroleassignpermission(roleId); // Reload from server
      } else {
        CustomSnackbar.error(title: "មានបញ្ហា", message: response.data);
      }
    } catch (e) {
      CustomSnackbar.error(title: "បញ្ហា", message: e.toString());
    }
  }

  void saveRolePermissionsForDelete(int roleid) async {
    try {
      List<int> selettePermissionfordelete = deletepermissionIDs.toList();
      if (selettePermissionfordelete.isEmpty) {
        CustomSnackbar.error(
          title: "ខុសប្រក្រតី",
          message: "សូមជ្រេីសរេីសយ៉ាងតិចមួយ",
        );
        return;
      }
      final data = {
        'role_id': roleid,
        'permission_ids': selettePermissionfordelete,
      };
      final response = await apiProvider.postbutdelete(
        '/removepermissionfromrole',
        data,
      );
      if (response.statusCode == 200) {
        CustomSnackbar.success(title: "ជោគជ័យ", message: "លុបបានជោគជ័យ");
      }
    } catch (e) {
      CustomSnackbar.error(title: "ខុសប្រក្រតី", message: "លុបមិនបាន");
    }
  }

  Future<void> fetchroleassignpermission(int roleid) async {
    try {
      isLoading.value = true;
      final result = await service.getroleassignpermission(roleid);
      roleassingpermission.assignAll(result);
    } catch (e) {
      CustomSnackbar.error(title: "ខុសប្រក្រតី", message: "${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getrole() async {
    try {
      isLoading.value = true;
      final result = await service.getrole();
      data.assignAll(result);
    } catch (e) {
      CustomSnackbar.error(title: Message.Error, message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
