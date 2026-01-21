import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:loanfrontend/core/theme/app_color.dart';
import 'package:loanfrontend/module/main/maincontroller/maincontroller.dart';
import 'package:loanfrontend/share/widgets/response.dart';

class MainView extends GetView<MainController> {
  MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TheColors.bgColor,
      body: Responsive(
        mobile: _mobileLayout(),
        web: _webLayout(),
      ),
      bottomNavigationBar: Responsive(
      mobile: _bottomNav(),
      web: SizedBox(height: 0.1,), 
    ),
    );
  }

  Widget _mobileLayout() {
    // REMOVED Scaffold from here - only use the one in build()
    return GetBuilder<MainController>(
      id: 'index_stack',
      builder: (controller) {
        return IndexedStack(
          index: controller.selectedIndex,
          children: controller.lstscreen,
        );
      },
    );
  }

  Widget _bottomNav() {
    return Container(
      decoration: BoxDecoration(
        color: TheColors.warningColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: GetBuilder<MainController>(
            id: 'bottom_navigation_bar',
            builder: (controller) {
              return GNav(
                backgroundColor: TheColors.warningColor,
                activeColor: Colors.white,
                tabBackgroundColor: TheColors.errorColor,
                tabBorderRadius: 12,
                gap: 8,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                selectedIndex: controller.selectedIndex,
                onTabChange: controller.onItemTapped,
                tabs: controller.getTabs(),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _webLayout() {
    return Row(
      children: [
        Container(
          width: 120,
          color: TheColors.bgColor,
          child: GetBuilder<MainController>(
            id: 'bottom_navigation_bar',
            builder: (controller) {
              return NavigationRail(
                backgroundColor: TheColors.bgColor,
                selectedIndex: controller.selectedIndex,
                onDestinationSelected: controller.onItemTapped,
                labelType: NavigationRailLabelType.all,
                destinations: controller.getTabs().map((tab) {
                  return NavigationRailDestination(
                    icon: Icon(tab.icon),
                    label: Text(tab.text ?? ""),
                  );
                }).toList(),
              );
            },
          ),
        ),
        Expanded(
          child: GetBuilder<MainController>(
            id: 'index_stack',
            builder: (controller) {
              return IndexedStack(
                index: controller.selectedIndex,
                children: controller.lstscreen,
              );
            },
          ),
        ),
      ],
    );
  }
}