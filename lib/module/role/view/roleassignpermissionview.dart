import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loanfrontend/core/theme/app_color.dart';
import 'package:loanfrontend/module/role/controller/rolecontroller.dart';
import 'package:loanfrontend/share/widgets/app_bar.dart';
import 'package:loanfrontend/share/widgets/custombuttonnav.dart';
import 'package:loanfrontend/share/widgets/loading.dart';
import 'package:loanfrontend/share/widgets/rolepermissioncard.dart';
import 'package:loanfrontend/share/widgets/textfield.dart';
import 'package:responsive_framework/responsive_framework.dart';

class Roleassignpermissionview extends StatefulWidget {
  const Roleassignpermissionview({super.key});

  @override
  State<Roleassignpermissionview> createState() =>
      _RoleassignpermissionviewState();
}

class _RoleassignpermissionviewState extends State<Roleassignpermissionview> {
  final controller = Get.find<Rolecontroller>();
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
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
      appBar: const CustomAppBar(title: "បន្ថែមសិទ្ធ"),
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
                    controller: searchController,
                    hintText: "ស្វែងរក",
                    prefixIcon: Icons.search,
                    onChanged: (Value) => controller.searchQuery.value = Value,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // 🧩 Permission List
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const CustomLoading();
                  }

                  final filteredList = controller.filteredPermissions;

                  if (filteredList.isEmpty) {
                    return const Center(
                      child: Text('រកមិនឃើញទិន្នន័យ'),
                    );
                  }

                  return ListView.builder(
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {
                      final permission = filteredList[index];
                      return RolePermissionCard(
                        permission: permission,
                        onChanged: (value) {
                          permission.assigned = value;
                          controller.roleassingpermission[index] = permission;

                          final permissionId = permission.id!;
                          if (controller.changedPermissionIds
                              .contains(permissionId)) {
                            controller.changedPermissionIds
                                .remove(permissionId);
                          } else {
                            controller.changedPermissionIds.add(permissionId);
                          }
                        },
                      );
                    },
                  );
                }),
              ),

              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
            left: isMobile ? 8 : 600,
            right: isMobile ? 8 : 600,
            top: isMobile ? 8 : 10),
        child: CustomBottomNav(
          title: "បន្ថែម",
          onTap: () async {
            controller.saveRolePermissions(roleid);
          },
        ),
      ),
    );
  }
}
