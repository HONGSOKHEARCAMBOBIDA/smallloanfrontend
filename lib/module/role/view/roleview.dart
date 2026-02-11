import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loanfrontend/core/theme/app_color.dart';
import 'package:loanfrontend/core/theme/text_styles.dart';
import 'package:loanfrontend/module/role/binding/rolebinding.dart';
import 'package:loanfrontend/module/role/controller/rolecontroller.dart';
import 'package:loanfrontend/module/role/view/roleassignpermissionview.dart';
import 'package:loanfrontend/module/role/view/rolepermissionfordelete.dart';
import 'package:loanfrontend/share/widgets/app_bar.dart';
import 'package:loanfrontend/share/widgets/customrolecard.dart';
import 'package:loanfrontend/share/widgets/loading.dart';
import 'package:responsive_framework/responsive_framework.dart';

class Roleview extends StatefulWidget {
  Roleview({super.key});

  @override
  State<Roleview> createState() => _RoleviewState();
}

class _RoleviewState extends State<Roleview> {
  final roleController = Get.find<Rolecontroller>();
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final breakpoint = ResponsiveBreakpoints.of(context);
    final bool isMobile = breakpoint.isMobile;

    return Scaffold(
      backgroundColor: TheColors.bgColor,
      appBar: const CustomAppBar(title: "តួនាទី"),
      body: RefreshIndicator(
        color: TheColors.errorColor,
        backgroundColor: TheColors.bgColor,
        onRefresh: () async {
          await roleController.getrole();
          roleController.changedPermissionIds.clear();
          roleController.deletepermissionIDs.clear();
        },
        child: Padding(
          padding: EdgeInsets.only(
              left: isMobile ? 8 : 600,
              right: isMobile ? 8 : 600,
              top: isMobile ? 8 : 20),
          child: Column(
            children: [
              Expanded(
                child: Obx(() {
                  if (roleController.isLoading.value) {
                    return const CustomLoading();
                  }

                  if (roleController.data.isEmpty) {
                    return Center(
                      child: Text(
                        "អត់មានទិន្ន័យ",
                        style: TextStyles.siemreap(context, fontSize: 12),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: roleController.data.length,
                    itemBuilder: (context, index) {
                      final role = roleController.data[index];
                      return Center(
                        child: Column(
                          children: [
                            CustomRoleCard(
                              displayname: role.displayName ?? "អត់មាន",
                              isActive: role.isActive,
                              name: role.name ?? "អត់មាន",
                              onEdit: () {},
                              onDelete: () {},
                              onTap: () {
                                Get.to(
                                  () => const Roleassignpermissionview(),
                                  binding: Rolebinding(),
                                  arguments: role.id,
                                  transition: Transition.rightToLeft,
                                );
                              },
                              deletepermission: () {
                                Get.to(
                                  () => const Rolepermissionfordelete(),
                                  binding: Rolebinding(),
                                  transition: Transition.rightToLeft,
                                  arguments: role.id,
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
