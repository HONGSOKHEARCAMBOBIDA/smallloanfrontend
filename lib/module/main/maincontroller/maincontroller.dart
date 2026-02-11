import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:loanfrontend/core/theme/app_color.dart';
import 'package:loanfrontend/core/theme/text_styles.dart';
import 'package:loanfrontend/module/main/mainview/account.dart';
import 'package:loanfrontend/module/main/mainview/admin.dart';
import 'package:loanfrontend/module/main/mainview/loan.dart';

class MainController extends GetxController {
  int selectedIndex = 0;
  final selectuserid = Rxn<int>();
  final box = GetStorage();

  final List<Widget> lstscreen = [
    Admin(),
    Loan(),
    Account(),
  ];

  void onItemTapped(int index) {
    selectedIndex = index;
    update(['index_stack', 'bottom_navigation_bar']);
  }

  List<GButton> getTabs(BuildContext context) {
    final roleId = box.read('roleid') ?? 0;
    return [
      if (roleId == 1)
        GButton(
          icon: Icons.admin_panel_settings,
          text: 'អ្នកកាន់ប្រព័ន្ធ',
          textStyle: TextStyles.siemreap(context, color: TheColors.white),
        ),
      GButton(
          icon: Icons.account_balance,
          text: 'កម្ចី',
          textStyle: TextStyles.siemreap(context, color: TheColors.white)),
      GButton(
          icon: Icons.person,
          text: 'គណនេយ្យ',
          textStyle: TextStyles.siemreap(context, color: TheColors.white)),
    ];
  }

  void logout() async {
    await box.erase();
    Get.offAllNamed('/login');
  }
}
