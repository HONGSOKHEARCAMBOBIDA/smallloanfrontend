import 'package:flutter/material.dart';
import 'package:loanfrontend/core/theme/app_color.dart';
import 'package:loanfrontend/core/theme/text_styles.dart';
import 'package:loanfrontend/data/models/loanproductmodel.dart';
import 'package:responsive_framework/responsive_framework.dart';

class LoanproductSelector extends StatelessWidget {
  final List<Data> loanproduct;
  final int? selectedloanproductId;
  final Function(int) onSelected;

  const LoanproductSelector({
    Key? key,
    required this.loanproduct,
    this.selectedloanproductId,
    required this.onSelected,
  }) : super(key: key);

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
              Text('ជ្រើសរើសប្រភេទកម្ចី', style: TextStyles.siemreap(context,color: TheColors.white,fontSize: smallFontSize)),
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
                children: loanproduct.map((loanproduct) {
                  final isSelected = loanproduct.id == selectedloanproductId;
                  return ChoiceChip(
                    label: Text(loanproduct.name ?? '',
                        style: TextStyles.siemreap(context,
                            fontSize: smallFontSize,
                            color: isSelected
                                ? TheColors.bgColor
                                : TheColors.black)),
                    selected: isSelected,
                    backgroundColor: TheColors.cutecolo,
                    selectedColor: TheColors.orange,
                    side: const BorderSide(color: TheColors.cutecolo, width: 0.3),
                    onSelected: (_) {
                      onSelected(loanproduct.id!);
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
