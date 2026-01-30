import 'package:flutter/material.dart';
import 'package:loanfrontend/core/theme/app_color.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String? label;
  final Color backgroundColor;
  final Color iconColor;
  final double size;
  final bool isExtended;
  final String heroTag; // ✅ Add heroTag
  final double borderRadius;
  const CustomFloatingActionButton({
    Key? key,
    required this.onPressed,
    this.borderRadius = 28.0,
    this.icon = Icons.add,
    this.label,
    this.backgroundColor = TheColors.green,
    this.iconColor = TheColors.white,
    this.size = 66.0,
    this.isExtended = false,
    this.heroTag = "default_fab", // ✅ Default heroTag
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isExtended
        ? FloatingActionButton.extended(
            onPressed: onPressed,
            backgroundColor: backgroundColor,
            label: Text(label ?? "Action", style: TextStyle(color: iconColor)),
            icon: Icon(icon, color: iconColor),
            heroTag: heroTag,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                borderRadius,
              ), // ✅ Apply border radius
            ), // ✅ Assign heroTag here
          )
        : FloatingActionButton(
            onPressed: onPressed,
            backgroundColor: backgroundColor,
            child: Icon(icon, color: iconColor, size: size * 0.5),
            heroTag: heroTag,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                borderRadius,
              ), // ✅ Apply border radius
            ), // ✅ Assign heroTag here
          );
  }
}
