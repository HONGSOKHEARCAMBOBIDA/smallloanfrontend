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
    this.backgroundColor = TheColors.errorColor, // Default color
    this.height = 50, // Default height
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: AppBar(
        title: Text(title,
            style: TextStyles.siemreap(context,
                color: TheColors.bgColor, fontSize: 16)),
        centerTitle: true,
        backgroundColor: backgroundColor,
        iconTheme: IconThemeData(
          color: TheColors.bgColor, // set your drawer icon color here
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
