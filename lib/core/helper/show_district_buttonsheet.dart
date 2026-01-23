import 'package:flutter/material.dart';
import 'package:loanfrontend/core/theme/app_color.dart';
import 'package:loanfrontend/data/models/districtmodel.dart';
import 'package:loanfrontend/share/widgets/district_selector.dart';

Future<void> showDistrictSelectorSheet({
  required BuildContext context,
  required List<Data> district,
  int? selecteddistrict,
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
        child: DistrictSelector(
          district: district,
          selectedDistrictId: selecteddistrict,
          onSelected: onSelected,
        ),
      );
    },
  );
}