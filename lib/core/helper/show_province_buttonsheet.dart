import 'package:flutter/material.dart';
import 'package:loanfrontend/core/theme/app_color.dart';
import 'package:loanfrontend/data/models/provincemodel.dart';
import 'package:loanfrontend/share/widgets/province_selector.dart';

Future<void> showProvinceSelectorSheet({
  required BuildContext context,
  required List<Data> provinces,
  int? selectedProvince,
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
        child: ProvinceSelector(
          provinces: provinces,
          selectedProvinceId: selectedProvince,
          onSelected: onSelected,
        ),
      );
    },
  );
}
