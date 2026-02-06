import 'package:flutter/material.dart';
import 'package:loanfrontend/core/theme/app_color.dart';
import 'package:loanfrontend/data/models/chataccountmodel.dart';
import 'package:loanfrontend/share/widgets/chataccount_selector.dart';

Future<void> showChataccoutSelectorSheet({
  required BuildContext context,
  required List<Data> chataccount,
  int? selectedchataccount,
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
        child: ChataccountSelector(
          chataccount: chataccount,
          selectedchataccountId: selectedchataccount,
          onSelected: onSelected,
        ),
      );
    },
  );
}
