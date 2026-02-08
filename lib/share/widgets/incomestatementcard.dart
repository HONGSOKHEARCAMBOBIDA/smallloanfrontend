import 'package:flutter/material.dart';
import 'package:loanfrontend/core/theme/app_color.dart';
import 'package:loanfrontend/core/theme/text_styles.dart';
import 'package:loanfrontend/data/models/incomestatementmodel.dart';
import 'package:loanfrontend/share/widgets/common_widgets.dart';

class Incomestatementcard extends StatelessWidget {
  final Data data;
  final VoidCallback onTap;

  const Incomestatementcard({
    super.key,
    required this.data,
    required this.onTap,
  });

  Color _statusColor() {
    final income = data.totalIncome ?? 0;
    final expense = data.totalExpense ?? 0;

    if (expense > income) return TheColors.red;
    if (income > expense) return TheColors.green;
    return TheColors.gray;
  }

  String _statusText() {
    final income = data.totalIncome ?? 0;
    final expense = data.totalExpense ?? 0;

    return income >= expense ? "ចំណេញឬមិនខាត" : "ខាត";
  }

  @override
  Widget build(BuildContext context) {
    final income = data.totalIncome ?? 0;
    final expense = data.totalExpense ?? 0;
    final result = income - expense;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Card(
        color: TheColors.bgColor,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(
            color: TheColors.gray,
            width: 1,
          ),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "ចំណូលសរុប $income ៛",
                        style: TextStyles.siemreap(
                          context,
                          fontSize: 13,
                          fontweight: FontWeight.bold,
                          color: TheColors.white,
                        ),
                      ),
                      CommonWidgets.SizeBoxh15,
                      Text(
                        "ចំណាយសរុប $expense ៛",
                        style: TextStyles.siemreap(
                          context,
                          fontSize: 13,
                          fontweight: FontWeight.bold,
                          color: TheColors.white,
                        ),
                      ),
                    ],
                  ),

                  /// STATUS BADGE
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: _statusColor(),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        _statusText(),
                        style: TextStyles.siemreap(
                          context,
                          color: TheColors.white,
                          fontweight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),
              const Divider(height: 24),
              Text(
                "ចំណេញ/ខាត $result ៛",
                style: TextStyles.siemreap(
                  context,
                  fontSize: 16,
                  fontweight: FontWeight.bold,
                  color: _statusColor(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
