import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loanfrontend/core/theme/app_color.dart';

class CustomOutlinedButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? borderColor;
  final Color? textColor;
  final double borderRadius;
  final double fontSize;
  final double width;
  final double height;
  final IconData? icon;
  final MainAxisAlignment alignment;
  const CustomOutlinedButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.borderColor = TheColors.white,
    this.textColor = TheColors.white,
    this.borderRadius = 12,
    this.fontSize = 13.0,
    this.width = double.infinity,
    this.height = 50.0,
    this.icon,
    this.alignment = MainAxisAlignment.start,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: borderColor!, width: 0.5),
          foregroundColor: textColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: alignment,
          children: [
            if (icon != null) ...[
              Icon(icon, color: textColor, size: 20),
              const SizedBox(width: 8),
            ],
            Text(
              text,
              style: GoogleFonts.siemreap(fontSize: fontSize, color: textColor),
            ),
          ],
        ),
      ),
    );
  }
}
