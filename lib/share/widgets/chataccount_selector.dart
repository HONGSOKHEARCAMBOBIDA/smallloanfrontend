import 'package:flutter/material.dart';
import 'package:loanfrontend/core/theme/app_color.dart';
import 'package:loanfrontend/core/theme/text_styles.dart';
import 'package:loanfrontend/data/models/chataccountmodel.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ChataccountSelector extends StatefulWidget {
  final List<Data> chataccount;
  final int? selectedchataccountId;
  final Function(int) onSelected;

  const ChataccountSelector({
    Key? key,
    required this.chataccount,
    this.selectedchataccountId,
    required this.onSelected,
  }) : super(key: key);

  @override
  State<ChataccountSelector> createState() => _ChataccountSelectorState();
}

class _ChataccountSelectorState extends State<ChataccountSelector> {
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
              Text('ជ្រើសរើសគណនេយ្យ',
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
                children: widget.chataccount.map((chataccount) {
                  final isSelected =
                      chataccount.id == widget.selectedchataccountId;
                  return Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: ChoiceChip(
                      label: Text(chataccount.name ?? '',
                          style: TextStyles.siemreap(context,
                              fontSize: smallFontSize,
                              color: isSelected
                                  ? TheColors.bgColor
                                  : TheColors.black)),
                      selected: isSelected,
                      backgroundColor: TheColors.cutecolo,
                      selectedColor: TheColors.white,
                      surfaceTintColor: Colors.transparent,
                      selectedShadowColor: TheColors.white,
                      side: BorderSide(color: TheColors.cutecolo, width: 0.3),
                      onSelected: (_) {
                        widget.onSelected(chataccount.id!);
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
