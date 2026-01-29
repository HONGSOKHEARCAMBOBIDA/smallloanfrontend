import 'package:flutter/material.dart';
import 'package:loanfrontend/core/theme/app_color.dart';
import 'package:loanfrontend/core/theme/text_styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color backgroundColor;
  final double height;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.backgroundColor = TheColors.bgColor, // Default color
    this.height = 70, // Default height
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(title,
              style: TextStyles.moul(context,
                  color: TheColors.warningColor, fontSize: 20)),
        ),
        centerTitle: true,
        backgroundColor: backgroundColor,
        iconTheme: IconThemeData(
          color: TheColors.white, // set your drawer icon color here
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
