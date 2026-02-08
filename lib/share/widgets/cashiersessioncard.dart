import 'package:flutter/material.dart';
import 'package:loanfrontend/core/theme/app_color.dart';
import 'package:loanfrontend/core/theme/text_styles.dart';
import 'package:loanfrontend/data/models/cashiersession.dart';

class CashierSessionCard extends StatelessWidget {
  final Data session;
  final VoidCallback onTap;
  const CashierSessionCard(
      {super.key, required this.session, required this.onTap});

  Color _statusColor(String? status) {
    switch (status) {
      case '2':
        return TheColors.green;
      case '1':
        return TheColors.lightOrage;
      default:
        return TheColors.gray;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Card(
        color: TheColors.bgColor,
        borderOnForeground: true,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // optional
          side: const BorderSide(
            color: TheColors.gray, // 👈 your border color
            width: 1, // optional
          ),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// HEADER
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "លេខសម្គាល់ ${session.sessionNumber}",
                      style: TextStyles.siemreap(context,
                          fontSize: 13,
                          fontweight: FontWeight.bold,
                          color: TheColors.white),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7, vertical: 2),
                      decoration: BoxDecoration(
                        color: _statusColor(session.status).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          session.status == "1"
                              ? "កំពុងប្រមូលប្រាក់"
                              : "បានផ្ទៀងផ្ទាត់",
                          style: TextStyles.siemreap(
                            context,
                            color: _statusColor(session.status),
                            fontweight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              /// USER & DATE
              Row(
                children: [
                  const Icon(Icons.person, size: 18, color: TheColors.green),
                  const SizedBox(width: 6),
                  Text(
                    session.userName ?? "-",
                    style: TextStyles.siemreap(context, color: TheColors.white),
                  ),
                  const Spacer(),
                  const Icon(Icons.calendar_today,
                      size: 16, color: TheColors.green),
                  const SizedBox(width: 6),
                  Text(session.sessionDate ?? "-",
                      style:
                          TextStyles.siemreap(context, color: TheColors.white))
                ],
              ),

              const SizedBox(height: 8),

              /// TIME
              Row(
                children: [
                  const Icon(Icons.schedule, size: 18, color: TheColors.green),
                  const SizedBox(width: 6),
                  Text(
                      "${session.startTime ?? '--'}  →  ${session.endTime ?? '--'}",
                      style:
                          TextStyles.siemreap(context, color: TheColors.white))
                ],
              ),

              const Divider(height: 24),

              /// MONEY SECTION
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _moneyItem(
                      context: context,
                      label: "ប្រាក់ពេលបេីកប្រអប់",
                      value: session.openingBalance,
                    ),
                    _moneyItem(
                      context: context,
                      label: "ប្រាក់កំពុងប្រមូល",
                      value: session.totalReceipts,
                    ),
                    _moneyItem(
                      context: context,
                      label: "ប្រាក់បានផ្ទៀងផ្ទាត់",
                      value: session.closingBalance,
                    ),
                  ],
                ),
              ),

              const Divider(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _moneyItem(
      {required String label, int? value, required BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: TextStyles.siemreap(context,
                  color: TheColors.white, fontSize: 12)),
          const SizedBox(height: 4),
          Text("${value ?? 0} ៛",
              style: TextStyles.siemreap(context,
                  color: TheColors.white, fontSize: 18))
        ],
      ),
    );
  }
}
