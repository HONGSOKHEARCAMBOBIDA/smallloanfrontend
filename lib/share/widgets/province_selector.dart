import 'package:flutter/material.dart';
import 'package:loanfrontend/core/theme/app_color.dart';
import 'package:loanfrontend/core/theme/text_styles.dart';
import 'package:loanfrontend/data/models/provincemodel.dart';

class ProvinceSelector extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('ជ្រើសរើសខេត្ត', style: TextStyles.siemreap(context)),
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
                children: provinces.map((province) {
                  final isSelected = province.id == selectedProvinceId;
                  return ChoiceChip(
                    label: Text(province.name ?? '',
                        style: TextStyles.siemreap(context,
                            fontSize: 12,
                            color: isSelected
                                ? TheColors.bgColor
                                : TheColors.black)),
                    selected: isSelected,
                    backgroundColor: TheColors.warningColor,
                    selectedColor: TheColors.orange,
                    surfaceTintColor: Colors.transparent,
                    selectedShadowColor: TheColors.orange,
                    side: BorderSide(color: TheColors.warningColor, width: 0.3),
                    onSelected: (_) {
                      onSelected(province.id!);
                      Navigator.pop(context);
                      FocusScope.of(context).unfocus();
                    },
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
