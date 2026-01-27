  import 'package:flutter/material.dart';
  import 'package:loanfrontend/core/theme/app_color.dart';
  import 'package:loanfrontend/core/theme/text_styles.dart';
  import 'package:get/get.dart';
  class CustomDatePickerField extends StatelessWidget {
    final String label;
    final Rxn<DateTime> selectedDate;
    final bool isWeb;

    const CustomDatePickerField({
      super.key,
      required this.label,
      required this.selectedDate,
      this.isWeb = false,
    });

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () async {
  final pickedDate = await showDatePicker(
    context: context,
    initialDate: selectedDate.value ?? DateTime.now(),
    firstDate: DateTime(1900),
    lastDate: DateTime(2030),
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          useMaterial3: true,
          dialogBackgroundColor: TheColors.bgColor,
          colorScheme: ColorScheme.light(
            primary: TheColors.orange,        // Header + selected date
            onPrimary: TheColors.warningColor,          // Header text
            onSurface: Colors.black,          // Normal text
          ),
          dialogTheme:DialogThemeData(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: TheColors.orange, // OK / CANCEL
            ),
          ),
        ),
        child: child!,
      );
    },
  );

  if (pickedDate != null) {
    selectedDate.value = pickedDate;
  }
},

              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: isWeb ? 16 : 12,
                  vertical: isWeb ? 20 : 16,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: TheColors.orange,
                    width: isWeb ? 1.5 : 0.5,
                  ),
                  borderRadius: BorderRadius.circular(isWeb ? 12 : 16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedDate.value != null
                          ? "${selectedDate.value!.day}/${selectedDate.value!.month}/${selectedDate.value!.year}"
                          : "ថ្ងៃខែឆ្នាំ",
                      style: TextStyles.siemreap(
                        context,
                        fontSize: isWeb ? 14 : 12,
                      ),
                    ),
                    Icon(
                      Icons.calendar_today,
                      color: TheColors.errorColor,
                      size: isWeb ? 20 : 16,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  }