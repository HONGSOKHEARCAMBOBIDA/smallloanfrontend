import 'package:flutter/material.dart';
import 'package:loanfrontend/core/theme/app_color.dart';
import 'package:loanfrontend/core/theme/text_styles.dart';
import 'package:responsive_framework/responsive_framework.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color backgroundColor;
  final double height;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.backgroundColor = Colors.transparent,
    this.height = 70, // Default height
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final breakpoint = ResponsiveBreakpoints.of(context);
    final bool isMobile = breakpoint.isMobile;
    final screenWidth = MediaQuery.of(context).size.width;

    return ClipRRect(
      child: AppBar(
        centerTitle: true,
        backgroundColor: backgroundColor,
        iconTheme: const IconThemeData(color: TheColors.white),
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: TextStyles.moul(
                context,
                color: TheColors.warningColor,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 6),
            Container(
              width: isMobile ? double.infinity : screenWidth * 0.6,
              height: 8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: const LinearGradient(
                  colors: [
                    TheColors.cutecolo,
                    TheColors.warningColor,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
