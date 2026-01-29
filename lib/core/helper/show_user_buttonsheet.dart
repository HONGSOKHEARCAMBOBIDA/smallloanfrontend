import 'package:flutter/material.dart';
import 'package:loanfrontend/core/theme/app_color.dart';
import 'package:loanfrontend/data/models/usermodel.dart';
import 'package:loanfrontend/share/widgets/user_selector.dart';

Future<void> showUserSelectorsheet({
  required BuildContext context,
  required List<Data> user,
  int? selecteduserId,
  required Function(int) onSelected,
}) {
  return showModalBottomSheet(
    backgroundColor: TheColors.bgColor,
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (_) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.6,
        child: UserSelector(
          user: user,
          selecteduserId: selecteduserId,
          onSelected: onSelected,
        ),
      );
    },
  );
}
