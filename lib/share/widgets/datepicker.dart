  import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
    helpText: "ជ្រេីសរេីស",
    cancelText: "បោះបង់",
    confirmText: "ជ្រេីសរេីស",
    context: context,
    initialDate: selectedDate.value ?? DateTime.now(),
    firstDate: DateTime(1900),
    lastDate: DateTime(2030),
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: TheColors.bgColor,        // Header + selected date
            onPrimary: TheColors.green,          // Header text
            onSurface: TheColors.white,          // Normal text
          ),
          dialogTheme:DialogThemeData(
            
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          datePickerTheme:  DatePickerThemeData(
            dividerColor: TheColors.white,
            weekdayStyle: TextStyles.siemreap(context,color: TheColors.white),
            dayStyle: TextStyles.siemreap(context,color: TheColors.white),
            headerForegroundColor: TheColors.white,
            headerHeadlineStyle: TextStyles.siemreap(context,color: TheColors.white),
            backgroundColor: TheColors.bgColor,
            yearStyle: TextStyles.siemreap(context,color: TheColors.white),
            todayForegroundColor: MaterialStateProperty.all(TheColors.white),
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: TheColors.green, // OK / CANCEL
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