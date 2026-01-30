import 'package:flutter/material.dart';
import 'package:loanfrontend/core/theme/app_color.dart';
import 'package:loanfrontend/core/theme/text_styles.dart';
import 'package:loanfrontend/data/models/districtmodel.dart';
import 'package:responsive_framework/responsive_framework.dart';

class DistrictSelector extends StatefulWidget {
  final List<Data> district;
  final int? selectedDistrictId;
  final Function(int) onSelected;

  const DistrictSelector({
    Key? key,
    required this.district,
    this.selectedDistrictId,
    required this.onSelected,
  }) : super(key: key);

  @override
  State<DistrictSelector> createState() => _DistrictSelectorState();
}

class _DistrictSelectorState extends State<DistrictSelector> {
  @override
  Widget build(BuildContext context) {
    final breakpoin = ResponsiveBreakpoints.of(context);
    final bool isMobile = breakpoin.isMobile;
    final double smallFontSize = isMobile ? 12 : 15;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('ជ្រើសរើសស្រុក',
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
                children: widget.district.map((districts) {
                  final isSelected = districts.id == widget.selectedDistrictId;
                  return Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: ChoiceChip(
                      label: Text(districts.name ?? '',
                          style: TextStyles.siemreap(context,
                              fontSize: smallFontSize,
                              color: isSelected
                                  ? TheColors.bgColor
                                  : TheColors.black)),
                      selected: isSelected,
                      backgroundColor: TheColors.warningColor,
                      selectedColor: TheColors.orange,
                      side: const BorderSide(
                          color: TheColors.warningColor, width: 0.3),
                      onSelected: (_) {
                        widget.onSelected(districts.id!);
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
