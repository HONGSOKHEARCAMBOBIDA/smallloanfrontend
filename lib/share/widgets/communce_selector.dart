import 'package:flutter/material.dart';
import 'package:loanfrontend/core/theme/app_color.dart';
import 'package:loanfrontend/core/theme/text_styles.dart';
import 'package:loanfrontend/data/models/communcemodel.dart';

class CommunceSelector extends StatelessWidget {
  final List<Data> communce;
  final int? selecteCommunceId;
  final Function(int) onSelected;

  const CommunceSelector({
    Key? key,
    required this.communce,
    this.selecteCommunceId,
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
              Text('ជ្រើសរើសឃុំ', style: TextStyles.siemreap(context)),
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
                children: communce.map((communces) {
                  final isSelected = communces.id == selecteCommunceId;
                  return ChoiceChip(
                    label: Text(communces.name ?? '',
                        style: TextStyles.siemreap(context,
                            fontSize: 12,
                            color: isSelected
                                ? TheColors.bgColor
                                : TheColors.black)),
                    selected: isSelected,
                    backgroundColor: TheColors.warningColor,
                    selectedColor: TheColors.orange,
                    side: BorderSide(color: TheColors.warningColor, width: 0.3),
                    onSelected: (_) {
                      onSelected(communces.id!);
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
