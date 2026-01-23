import 'package:flutter/material.dart';
import 'package:loanfrontend/core/theme/app_color.dart';
import 'package:loanfrontend/data/models/villagemodel.dart';
import 'package:loanfrontend/share/widgets/village_selector.dart';

Future<void> showVillageSelectorsheet({
  required BuildContext context,
  required List<Data> village,
  int? selectedVillageId,
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
        child: VillageSelector(
          village: village,
          selectedVillageId: selectedVillageId,
          onSelected: onSelected,
        ),
      );
    },
  );
}
