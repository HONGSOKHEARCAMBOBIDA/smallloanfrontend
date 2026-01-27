import 'package:flutter/material.dart';
import 'package:loanfrontend/core/theme/app_color.dart';
import 'package:loanfrontend/core/theme/text_styles.dart';

class CommonWidgets {
  static Widget buildLabel(BuildContext context, String label) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        children: [
          Text(label, style: TextStyles.siemreap(context, fontSize: 12)),
          const SizedBox(height: 5),
        ],
      ),
    );
  }

  static Widget buildHeader(BuildContext context, String label, IconData icon) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Row(
        children: [
          Icon(icon, color: TheColors.orange, size: 18),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyles.siemreap(
              context,
              fontweight: FontWeight.bold,
              fontSize: 14,
              color: TheColors.black,
            ),
          ),
        ],
      ),
    );
  }
  static const SizeBoxh20 = SizedBox(height: 20,);
  static const SizeBoxwidh5 = SizedBox(width: 5,);
  static const SizeBoxh15 = SizedBox(height: 15,);
  static const SizeBox8 = SizedBox(height: 8,);
  static const radius = 12.0;
  static const borderwidth = 0.5;
  static const fontsize12 = 12.0;
  static const fontsize20 = 20.0;
  static const fontsize15 = 15.0;
}
