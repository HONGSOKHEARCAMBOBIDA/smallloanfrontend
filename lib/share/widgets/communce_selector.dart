import 'package:flutter/material.dart';
import 'package:loanfrontend/core/theme/app_color.dart';
import 'package:loanfrontend/core/theme/text_styles.dart';
import 'package:loanfrontend/data/models/communcemodel.dart';
import 'package:responsive_framework/responsive_framework.dart';

class CommunceSelector extends StatefulWidget {
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
  State<CommunceSelector> createState() => _CommunceSelectorState();
}

class _CommunceSelectorState extends State<CommunceSelector> {
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
              Text('ជ្រើសរើសឃុំ',
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
                children: widget.communce.map((communces) {
                  final isSelected = communces.id == widget.selecteCommunceId;
                  return Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: ChoiceChip(
                      label: Text(communces.name ?? '',
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
                        widget.onSelected(communces.id!);
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
