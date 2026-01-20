import 'package:flutter/material.dart';
import 'package:loanfrontend/core/theme/app_color.dart';
import 'package:loanfrontend/core/theme/text_styles.dart';

class CustomBottomNav extends StatelessWidget {
  final String title;
  final Future<void> Function()? onTap; // Accepts async function
  final Color? backgroundColor;

  const CustomBottomNav({
    this.backgroundColor,
    Key? key,
    required this.title,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Material(
          color: TheColors.errorColor,
          borderRadius: BorderRadius.circular(14),
          elevation: 2, // optional subtle shadow
          child: InkWell(
            onTap: onTap != null
                ? () async {
                    await onTap!(); // Call async function safely
                  }
                : null,
            borderRadius: BorderRadius.circular(30),
            splashColor: Colors.white.withOpacity(0.3), // customize ripple
            highlightColor:
                Colors.white.withOpacity(0.1), // subtle shadow on tap
            child: Center(
              child: Text(
                title,
                style: TextStyles.siemreap(context, color: TheColors.bgColor),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
