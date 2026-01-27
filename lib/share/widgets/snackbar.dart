import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loanfrontend/core/theme/app_color.dart';

class CustomSnackbar {
  static void success({required String title, required String message}) {
    Get.snackbar(
      '',
      '',
      snackPosition: SnackPosition.TOP,
      backgroundColor: TheColors.successColor,
      borderRadius: 12,
      margin: const EdgeInsets.all(12),
      duration: const Duration(seconds: 3),
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutCubic,
      reverseAnimationCurve: Curves.easeInCubic,
      snackStyle: SnackStyle.FLOATING,

      // Remove shadow
      boxShadows: [],

      icon: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        child: Icon(
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
          color: Colors.white.withOpacity(0.9),
          height: 1.4,
        ),
      ),
    );
  }

  static void error({required String title, required String message}) {
    Get.snackbar(
      '',
      '',
      snackPosition: SnackPosition.TOP,
      backgroundColor: TheColors.red,
      borderRadius: 12,
      margin: const EdgeInsets.all(12),
      duration: const Duration(seconds: 4),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutBack,

      // Remove shadow
      boxShadows: [],

      icon: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.error_outline_rounded,
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

// Extension for easy usage
extension SnackbarExtension on GetInterface {
  void showSuccess(String title, String message) {
    CustomSnackbar.success(title: title, message: message);
  }

  void showError(String title, String message) {
    CustomSnackbar.error(title: title, message: message);
  }
}

// Usage example:
// Get.showSuccess('ជោគជ័យ', 'ទិន្នន័យត្រូវបានរក្សាទុកដោយជោគជ័យ');
// Get.showError('បរាជ័យ', 'មិនអាចរក្សាទិន្នន័យបានទេ');
// CustomSnackbar.withAction(
//   title: 'ពិនិត្យឡើងវិញ',
//   message: 'តើអ្នកចង់លុបទិន្នន័យនេះទេ?',
//   actionText: 'លុប',
//   onAction: () => deleteItem(),
//   type: SnackbarType.warning,
// );
