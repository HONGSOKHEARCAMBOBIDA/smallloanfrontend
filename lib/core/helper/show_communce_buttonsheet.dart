import 'package:flutter/material.dart';
import 'package:loanfrontend/core/theme/app_color.dart';
import 'package:loanfrontend/data/models/communcemodel.dart';
import 'package:loanfrontend/share/widgets/communce_selector.dart';

Future<void> showCommunceSelectorSheet({
  required BuildContext context,
  required List<Data> communce,
  int? selectedCommunce,
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
        child: CommunceSelector(
          communce: communce,
          selecteCommunceId: selectedCommunce,
          onSelected: onSelected,
        ),
      );
    },
  );
}
