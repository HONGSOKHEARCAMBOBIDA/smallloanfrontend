import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:loanfrontend/core/theme/app_color.dart';
import 'package:loanfrontend/module/main/maincontroller/maincontroller.dart';

class MainView extends GetView<MainController> {

   MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TheColors.bgColor,
      body: GetBuilder<MainController>(
        id: 'index_stack',
        builder: (controller) {
          return IndexedStack(
            index: controller.selectedIndex,
            children: controller.lstscreen,
          );
        },
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: TheColors.bgColor,
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
                  // Colors
                  backgroundColor: TheColors.bgColor,

                  activeColor: Colors.white, // Active icon/text color
                  tabBackgroundColor: TheColors.errorColor, // Active tab bg
                  tabBorderRadius: 12,
                  tabMargin: const EdgeInsets.symmetric(vertical: 4),
                  
                  // Padding & Spacing
                  gap: 8,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  
                  // Text style
                  textStyle: GoogleFonts.siemreap(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: TheColors.bgColor
                  ),
                  iconSize: 22,
                  
                  // Animation
                  curve: Curves.easeInOut,
                  duration: const Duration(milliseconds: 300),
                  haptic: true, // Haptic feedback
                  
                  // State
                  selectedIndex: controller.selectedIndex,
                  onTabChange: controller.onItemTapped,
                  
                  tabs: controller.getTabs()
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}