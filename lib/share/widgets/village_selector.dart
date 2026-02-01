import 'package:flutter/material.dart';
import 'package:loanfrontend/core/theme/app_color.dart';
import 'package:loanfrontend/core/theme/text_styles.dart';
import 'package:loanfrontend/data/models/villagemodel.dart';
import 'package:responsive_framework/responsive_framework.dart';

class VillageSelector extends StatefulWidget {
  final List<Data> village;
  final int? selectedVillageId;
  final Function(int) onSelected;

  const VillageSelector({
    Key? key,
    required this.village,
    this.selectedVillageId,
    required this.onSelected,
  }) : super(key: key);

  @override
  State<VillageSelector> createState() => _VillageSelectorState();
}

class _VillageSelectorState extends State<VillageSelector> {
  @override
  Widget build(BuildContext context) {
    final breakpoint = ResponsiveBreakpoints.of(context);
    final bool isMobile = breakpoint.isMobile;
    final double smallFontSize = isMobile ? 12 : 15;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('ជ្រើសរើសភូមី',
                  style: TextStyles.siemreap(context, fontSize: smallFontSize)),
              IconButton(
                icon: const Icon(Icons.close, color: TheColors.errorColor),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: SingleChildScrollView(
              child: Wrap(
                spacing: 5,
                runSpacing: 8,
                children: widget.village.map((villages) {
                  final isSelected = villages.id == widget.selectedVillageId;
                  return Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: ChoiceChip(
                      label: Text(villages.name ?? '',
                          style: TextStyles.siemreap(context,
                              fontSize: smallFontSize,
                              color: isSelected
                                  ? TheColors.bgColor
                                  : TheColors.black)),
                      selected: isSelected,
                      backgroundColor: TheColors.cutecolo,
                      selectedColor: TheColors.orange,
                      side: const BorderSide(
                          color: TheColors.cutecolo, width: 0.3),
                      onSelected: (_) {
                        widget.onSelected(villages.id!);
                        Navigator.pop(context);
                        FocusScope.of(context).unfocus();
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
