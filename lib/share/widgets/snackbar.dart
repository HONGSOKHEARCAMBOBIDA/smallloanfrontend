import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loanfrontend/core/theme/app_color.dart';
import 'package:responsive_framework/responsive_framework.dart';

class CustomSnackbar {
  static void success({required String title, required String message}) {
    final context = Get.context!;
    final breakpoin = ResponsiveBreakpoints.of(context);
    final bool isMobile = breakpoin.isMobile;
    Get.snackbar(
      '',
      '',
      maxWidth: isMobile ? double.infinity : 400.0,
      snackPosition: SnackPosition.TOP,
      backgroundColor: TheColors.successColor,
      borderRadius: 12,
      margin: const EdgeInsets.all(12),
      duration: const Duration(seconds: 2),
      isDismissible: true,
      // isDismissible tell user can switch to close or not
      dismissDirection: DismissDirection.horizontal,
      // what direction user can switch
      forwardAnimationCurve: Curves.easeOut,
      reverseAnimationCurve: Curves.easeInCubic,
      snackStyle: SnackStyle.FLOATING,
      icon: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
         
          shape: BoxShape.circle,
         
        ),
        child: const Icon(
          Icons.check_circle_rounded,
          color: Colors.white,
          size: 22,
        ),
      ),
      titleText: Text(
        title,
        style: GoogleFonts.siemreap(
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: Colors.white,
          height: 1.3,
        ),
      ),
      messageText: Text(
        message,
        style: GoogleFonts.siemreap(
          fontSize: 13,
          color: TheColors.white,
          height: 1.4,
        ),
      ),
    );
  }

  static void error({required String title, required String message}) {
    final context = Get.context!;
    final breakpoin = ResponsiveBreakpoints.of(context);
     final bool isMobile = breakpoin.isMobile;
    Get.snackbar(
      '',
      '',
      maxWidth: isMobile ? double.infinity : 400.0,
      snackPosition: SnackPosition.TOP,
      backgroundColor: TheColors.red,
      borderRadius: 12,
      margin: const EdgeInsets.all(12),
      duration: const Duration(seconds: 2),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeInOut,
      reverseAnimationCurve: Curves.easeOut,
      icon: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
         
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.error_outline_rounded,
          color: TheColors.white,
          size: 22,
        ),
      ),
      titleText: Text(
        title,
        style: GoogleFonts.siemreap(
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
      messageText: Text(
        message,
        style: GoogleFonts.siemreap(
          fontSize: 13,
          color: Colors.white.withOpacity(0.9),
        ),
      ),
      mainButton: TextButton(
        child: Icon(
          Icons.close,
          color: Colors.white.withOpacity(0.7),
          size: 18,
        ),
        onPressed: () => Get.back(),
      ),
    );
  }
}

enum SnackbarType {
  success,
  error,
  warning,
  info,
}

extension SnackbarExtension on GetInterface {
  void showSuccess(String title, String message) {
    CustomSnackbar.success(title: title, message: message);
  }

  void showError(String title, String message) {
    CustomSnackbar.error(title: title, message: message);
  }
}
