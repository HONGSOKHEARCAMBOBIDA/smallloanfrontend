import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
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

  List<GButton> getTabs() {
    return const [
      GButton(icon: Icons.admin_panel_settings, text: 'Admin'),
      GButton(icon: Icons.account_balance, text: 'Loan'),
      GButton(icon: Icons.person, text: 'Account'),
    ];
  }

  void logout() async {
    await box.erase();
    Get.offAllNamed('/login');
  }
}
