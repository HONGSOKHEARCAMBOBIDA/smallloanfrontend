import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loanfrontend/core/theme/app_color.dart';
import 'package:loanfrontend/module/role/controller/rolecontroller.dart';
import 'package:loanfrontend/share/widgets/Customcardpermissionremove.dart';
import 'package:loanfrontend/share/widgets/app_bar.dart';
import 'package:loanfrontend/share/widgets/custombuttonnav.dart';
import 'package:loanfrontend/share/widgets/loading.dart';
import 'package:loanfrontend/share/widgets/textfield.dart';
import 'package:responsive_framework/responsive_framework.dart';

class Rolepermissionfordelete extends StatefulWidget {
  const Rolepermissionfordelete({super.key});

  @override
  State<Rolepermissionfordelete> createState() =>
      _RolepermissionfordeleteState();
}

class _RolepermissionfordeleteState extends State<Rolepermissionfordelete> {
  final controller = Get.find<Rolecontroller>();
  final SearchController = TextEditingController();

  @override
  void dispose() {
    SearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final int roleid = Get.arguments as int;
    final breakpoint = ResponsiveBreakpoints.of(context);
    final bool isMobile = breakpoint.isMobile;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchroleassignpermission(roleid);
    });

    return Scaffold(
      backgroundColor: TheColors.bgColor,
      appBar: const CustomAppBar(title: "ដកសិទ្ធ"),
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.fetchroleassignpermission(roleid);
        },
        child: Padding(
          padding: EdgeInsets.only(
              left: isMobile ? 8 : 600,
              right: isMobile ? 8 : 600,
              top: isMobile ? 8 : 20),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: SizedBox(
                  height: 50,
                  child: CustomTextField(
                    controller: SearchController,
                    hintText: "ស្វែងរក",
                    prefixIcon: Icons.search,
                    onChanged: (Value) => controller.searchQuery.value = Value,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const CustomLoading();
                  }
                  final filterList = controller.filteredPermissions;
                  if (filterList.isEmpty) {
                    return const Center(
                      child: Text('រកមិនឃើញទិន្នន័យ'),
                    );
                  }
                  return ListView.builder(
                    itemCount: filterList.length,
                    itemBuilder: (context, index) {
                      final permission = filterList[index];
                      return Customcardpermissionremove(
                        permission: permission,
                        onChanged: (value) {
                          // ✅ Update the assigned value
                          permission.assigned = value;

                          // ✅ Reassign to notify GetX observable list
                          controller.roleassingpermission[index] = permission;
                          final permissionId = permission.id!;
                          if (controller.deletepermissionIDs.contains(
                            permissionId,
                          )) {
                            controller.deletepermissionIDs.remove(permissionId);
                          } else {
                            controller.deletepermissionIDs.add(permissionId);
                          }
                        },
                      );
                    },
                  );
                }),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
            left: isMobile ? 8 : 600,
            right: isMobile ? 8 : 600,
            top: isMobile ? 8 : 20),
        child: CustomBottomNav(
          title: "ដក",
          onTap: () async {
            controller.saveRolePermissionsForDelete(roleid);
          },
        ),
      ),
    );
  }
}
