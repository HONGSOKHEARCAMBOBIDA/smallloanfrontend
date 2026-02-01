import 'package:flutter/material.dart';
import 'package:loanfrontend/core/theme/app_color.dart';
import 'package:loanfrontend/core/theme/text_styles.dart';
import 'package:loanfrontend/data/models/provincemodel.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ProvinceSelector extends StatefulWidget {
  final List<Data> provinces;
  final int? selectedProvinceId;
  final Function(int) onSelected;

  const ProvinceSelector({
    Key? key,
    required this.provinces,
    this.selectedProvinceId,
    required this.onSelected,
  }) : super(key: key);

  @override
  State<ProvinceSelector> createState() => _ProvinceSelectorState();
}

class _ProvinceSelectorState extends State<ProvinceSelector> {
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
              Text('ជ្រើសរើសខេត្ត', style: TextStyles.siemreap(context,fontSize: smallFontSize)),
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
                children: widget.provinces.map((province) {
                  final isSelected = province.id == widget.selectedProvinceId;
                  return Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: ChoiceChip(
                      label: Text(province.name ?? '',
                          style: TextStyles.siemreap(context,
                              fontSize: smallFontSize,
                              color: isSelected
                                  ? TheColors.bgColor
                                  : TheColors.black)),
                      selected: isSelected,
                      backgroundColor: TheColors.cutecolo,
                      selectedColor: TheColors.orange,
                      surfaceTintColor: Colors.transparent,
                      selectedShadowColor: TheColors.orange,
                      side: BorderSide(color: TheColors.cutecolo, width: 0.3),
                      onSelected: (_) {
                        widget.onSelected(province.id!);
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
