// core/helper/show_client_buttonsheet.dart
import 'package:flutter/material.dart';
import 'package:loanfrontend/core/theme/app_color.dart';
import 'package:loanfrontend/data/models/clientmodel.dart';
import 'package:loanfrontend/share/widgets/client_selector.dart';

Future<void> showClientSelectorsheet({
  required BuildContext context,
  required List<Data> client,
  int? selectedClientId,
  List<int>? selectedClientIds,
  Function(int)? onSelected,
  Function(List<int>)? onMultipleSelected,
  bool allowMultiple = false,
}) {
  return showModalBottomSheet(
    backgroundColor: TheColors.bgColor,
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        child: ClientSelector(
          client: client,
          selectedClientId: selectedClientId,
          selectedClientIds: selectedClientIds,
          onSelected: onSelected,
          onMultipleSelected: onMultipleSelected,
          allowMultiple: allowMultiple,
        ),
      );
    },
  );
}
