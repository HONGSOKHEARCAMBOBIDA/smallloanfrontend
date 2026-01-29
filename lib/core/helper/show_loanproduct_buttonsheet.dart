import 'package:flutter/material.dart';
import 'package:loanfrontend/core/theme/app_color.dart';
import 'package:loanfrontend/data/models/loanproductmodel.dart';
import 'package:loanfrontend/share/widgets/loanproduct_selector.dart';

Future<void> showLoanproudctSelectorsheet({
  required BuildContext context,
  required List<Data> loanprouct,
  int? selectedloanprouctId,
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
        child: LoanproductSelector(
          loanproduct: loanprouct,
          selectedloanproductId: selectedloanprouctId,
          onSelected: onSelected,
        ),
      );
    },
  );
}
