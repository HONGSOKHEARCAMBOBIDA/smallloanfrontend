import 'package:flutter/material.dart';
import 'package:loanfrontend/core/theme/app_color.dart';
import 'package:loanfrontend/core/theme/text_styles.dart';
import 'package:loanfrontend/data/models/paymentschedule.dart';
import 'package:loanfrontend/share/widgets/elevated_button.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ScheduleCard extends StatefulWidget {
  final Schedule schedule;
  final VoidCallback? onPayNow;
  final VoidCallback? onViewDetails;

  const ScheduleCard({
    super.key,
    required this.schedule,
    this.onPayNow,
    this.onViewDetails,
  });

  @override
  State<ScheduleCard> createState() => _ScheduleCardState();
}

class _ScheduleCardState extends State<ScheduleCard> {
  bool _isExpanded = false;

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'PAID':
        return TheColors.green;
      case 'OVERDUE':
        return TheColors.red;
      case 'PENDING':
        return TheColors.lightOrage;
      default:
        return Colors.grey;
    }
  }

  String _formatDate(String? dateString) {
    if (dateString == null) return 'N/A';

    try {
      final date = DateTime.parse(dateString);
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return dateString;
    }
  }

  double _getProgressPercentage() {
    final paid = widget.schedule.paidAmount ?? 0;
    final total = widget.schedule.totalOwe ?? 1;
    return total > 0 ? paid / total : 0;
  }

  @override
  Widget build(BuildContext context) {
    final breakpoint = ResponsiveBreakpoints.of(context);
    final bool isMobile = breakpoint.isMobile;
    final bool isTablet = breakpoint.isTablet;
    final double iconSize = isMobile ? 12 : 18;
    final double smallFontSize = isMobile ? 12 : 15;
    final status = widget.schedule.staus;
    final statusColor = _getStatusColor(status);
    final progress = _getProgressPercentage();
    final isPaid = status?.toLowerCase() == 'PAID';
    final isOverdue = status?.toLowerCase() == 'OVERDUE';

    return Card(
      color: TheColors.bgColor,
      borderOnForeground: true,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20), // optional
        side: const BorderSide(
          color: TheColors.gray, // 👈 your border color
          width: 1, // optional
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with Installment Number and Status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Installment Badge
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: iconSize,
                        color: TheColors.lightOrage,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'លេខរៀង ${widget.schedule.scheduleNumber ?? ''}',
                        style: TextStyles.siemreap(
                          context,
                          color: Colors.white,
                          fontweight: FontWeight.w600,
                          fontSize: smallFontSize,
                        ),
                      ),
                    ],
                  ),
                ),

                // Status Badge
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    (status ?? 'N/A').toUpperCase(),
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Due Date with optional overdue indicator
            Row(
              children: [
                Icon(
                  Icons.calendar_month_outlined,
                  size: iconSize,
                  color: isOverdue ? Colors.red : Colors.grey[600],
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Due Date: ${_formatDate(widget.schedule.paymentDate)}',
                    style: TextStyles.siemreap(
                      context,
                      color: TheColors.gray,
                      fontSize: 14,
                    ),
                  ),
                ),
                if (isOverdue)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.warning_amber,
                          size: 14,
                          color: Colors.red,
                        ),
                        SizedBox(width: 4),
                        Text(
                          'Overdue',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 12),

            // Progress Bar
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Payment Progress',
                      style: TextStyles.siemreap(
                        context,
                        fontSize: smallFontSize,
                        color: TheColors.gray,
                      ),
                    ),
                    Text(
                      '${(progress * 100).toStringAsFixed(0)}%',
                      style: TextStyle(
                        fontSize: smallFontSize,
                        color: TheColors.gray,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: TheColors.gray,
                  valueColor: AlwaysStoppedAnimation<Color>(statusColor),
                  borderRadius: BorderRadius.circular(4),
                  minHeight: 8,
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Expand/Collapse Button
            InkWell(
              onTap: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _isExpanded ? 'Show Less' : 'View Details',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      _isExpanded ? Icons.expand_less : Icons.expand_more,
                      size: 18,
                      color: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              ),
            ),

            // Expanded Details Section
            if (_isExpanded) ...[
              const Divider(),
              const SizedBox(height: 12),

              // Amount Breakdown Table
              Column(
                children: [
                  _buildAmountRow(
                    label: 'ប្រាក់ត្រូវបង់',
                    amount: widget.schedule.dueAmount,
                    isOptional: false,
                  ),
                  if ((widget.schedule.penalty ?? 0) > 0)
                    _buildAmountRow(
                      label: 'ប្រាក់ពិន័យ',
                      amount: widget.schedule.penalty,
                      isOptional: true,
                      prefix: '+',
                      textColor: Colors.red,
                      icon: Icons.warning_amber_outlined,
                    ),
                  const Divider(height: 16),
                  _buildAmountRow(
                    label: 'ប្រាក់ត្រូវបង់សរុប​',
                    amount: widget.schedule.totalOwe,
                    isOptional: false,
                    isBold: true,
                    textColor: Colors.black,
                  ),
                  _buildAmountRow(
                    label: 'ប្រាក់បានបង់',
                    amount: widget.schedule.paidAmount,
                    isOptional: false,
                    textColor: Colors.green,
                    icon: Icons.check_circle_outline,
                  ),
                  const Divider(height: 16),
                  _buildAmountRow(
                    label: widget.schedule.totalOwe! > 0
                        ? 'ប្រាក់ត្រូវបង់សរុប'
                        : 'បានបង់',
                    amount: widget.schedule.totalOwe,
                    isOptional: false,
                    isBold: true,
                    textColor: widget.schedule.totalOwe! > 0
                        ? Colors.red
                        : Colors.green,
                    icon: widget.schedule.totalOwe! > 0
                        ? Icons.error_outline
                        : Icons.check_circle,
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Action Buttons
              Row(
                children: [
                  if (!isPaid && widget.onPayNow != null)
                    Expanded(
                      child: CustomElevatedButton(
                        onPressed: widget.onPayNow,
                        text: "បង់ប្រាក់",
                      ),
                    ),
                  if (!isPaid && widget.onPayNow != null)
                    const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: widget.onViewDetails,
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Theme.of(context).primaryColor),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.receipt_long_outlined, size: 18),
                          const SizedBox(width: 8),
                          Text(isPaid ? 'View Receipt' : 'Details'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ] else ...[
              // Summary view when collapsed
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ប្រាក់ជំបាក់សរុប',
                        style: TextStyles.siemreap(
                          context,
                          fontSize: smallFontSize,
                          color: TheColors.gray,
                        ),
                      ),
                      Text(
                        widget.schedule.total.toString(),
                        style: TextStyles.siemreap(
                          context,
                          fontSize: 16,
                          fontweight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        widget.schedule.totalOwe! > 0
                            ? 'ប្រាក់ជំពាក់សរុប'
                            : 'បានបង់',
                        style: TextStyles.siemreap(
                          context,
                          fontSize: 12,
                          color: TheColors.gray,
                        ),
                      ),
                      Text(
                        widget.schedule.totalOwe! > 0
                            ? widget.schedule.totalOwe.toString()
                            : 'បង់រួចរាល់',
                        style: TextStyles.siemreap(
                          context,
                          fontSize: smallFontSize,
                          fontweight: FontWeight.bold,
                          color: widget.schedule.totalOwe! > 0
                              ? Colors.red
                              : Colors.green,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildAmountRow({
    required String label,
    required int? amount,
    bool isOptional = false,
    bool isBold = false,
    Color? textColor,
    String? prefix,
    IconData? icon,
  }) {
    if (isOptional && (amount == null || amount == 0)) {
      return const SizedBox();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  size: 16,
                  color: textColor ?? TheColors.gray,
                ),
                const SizedBox(width: 6),
              ],
              Text(
                label,
                style: TextStyles.siemreap(
                  context,
                  fontSize: 14,
                  fontweight: isBold ? FontWeight.bold : FontWeight.normal,
                  color: TheColors.gray,
                ),
              ),
            ],
          ),
          Text(
            '${amount}',
            style: TextStyles.siemreap(context,
                fontSize: 14,
                fontweight: isBold ? FontWeight.bold : FontWeight.normal,
                color: TheColors.gray),
          ),
        ],
      ),
    );
  }
}
