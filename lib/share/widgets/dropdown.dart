import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loanfrontend/core/theme/app_color.dart';
import 'package:loanfrontend/core/theme/text_styles.dart';

class CustomDropdown extends StatelessWidget {
  final Rx<int?> selectedValue;
  final List<dynamic> items;
  final String hintText;
  final Function(int?) onChanged;
  final Function(int)? onItemSelected;
  final bool isLoading;

  const CustomDropdown({
    Key? key,
    required this.selectedValue,
    required this.items,
    required this.hintText,
    required this.onChanged,
    this.onItemSelected,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return DropdownButtonFormField<int>(
        value: items.any((item) => item.id == selectedValue.value)
            ? selectedValue.value
            : null, // Fix #1
        decoration: InputDecoration(
            prefixIcon:
                const Icon(Icons.location_on, color: TheColors.errorColor),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            hint: Padding(
              padding: const EdgeInsets.only(bottom: 8, left: 8, top: 12),
              child: Text(
                hintText,
                style: TextStyles.siemreap(
                  context,
                  fontSize: 12,
                  color: TheColors.white,
                ),
              ),
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                    const BorderSide(color: TheColors.orange, width: 0.5))),

        dropdownColor: TheColors.bgColor,
        borderRadius: BorderRadius.circular(12),
        icon: const Icon(
          Icons.arrow_drop_down,
          color: TheColors.orange,
        ),
        iconSize: 20,
        elevation: 2,
        menuMaxHeight: 200,
        style:
            TextStyles.siemreap(context, fontSize: 12, color: TheColors.white),
        items: isLoading
            ? [] // Empty while loading
            : items.map((item) {
                return DropdownMenuItem<int>(
                  value: item.id,
                  child: Text(item.name ?? 'No name'),
                );
              }).toList(),
        onChanged: (value) {
          if (value != null) {
            selectedValue.value = value; // Fix #2
            onChanged(value);
            if (onItemSelected != null) {
              onItemSelected!(value);
            }
          }
        },
        validator: (value) {
          if (value == null) {
            return 'សូមជ្រើសរើស $hintText';
          }
          return null;
        },
      );
    });
  }
}
