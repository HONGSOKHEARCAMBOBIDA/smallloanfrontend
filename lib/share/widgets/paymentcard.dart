import 'package:flutter/material.dart';
import 'package:loanfrontend/core/theme/app_color.dart';
import 'package:loanfrontend/core/theme/text_styles.dart';
import 'package:loanfrontend/data/models/paymentschedule.dart';
import 'package:responsive_framework/responsive_framework.dart';

class Paymentcard extends StatefulWidget {
  final Data paymentschedule;
  final VoidCallback? onTap;
  final bool isExpanded;

  const Paymentcard({
    super.key,
    required this.paymentschedule,
    this.onTap,
    this.isExpanded = false,
  });

  @override
  State<Paymentcard> createState() => _PaymentcardState();
}

class _PaymentcardState extends State<Paymentcard> {
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.isExpanded;
  }

  @override
  Widget build(BuildContext context) {
    final breakpoint = ResponsiveBreakpoints.of(context);
    final bool isMobile = breakpoint.isMobile;

    return Card(
      color: TheColors.bgColor,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: TheColors.gray.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: widget.onTap ??
            () {
              if (!isMobile) return;
              setState(() => _isExpanded = !_isExpanded);
            },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: EdgeInsets.all(isMobile ? 12 : 16),
          child: isMobile ? _buildMobileLayout() : _buildDesktopLayout(),
        ),
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header with loan ID and expand button
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                "កម្ចី #${widget.paymentschedule.loanId}",
                style: TextStyles.siemreap(
                  context,
                  fontSize: 18,
                  fontweight: FontWeight.bold,
                  color: TheColors.white,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            IconButton(
              onPressed: () => setState(() => _isExpanded = !_isExpanded),
              icon: Icon(
                _isExpanded ? Icons.expand_less : Icons.expand_more,
                color: TheColors.lightOrage,
                size: 24,
              ),
              splashRadius: 20,
            ),
          ],
        ),

        // Quick info row
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            children: [
              _buildInfoChip(
                label: "ទំហំ",
                value: "${widget.paymentschedule.loanAmount}",
                icon: Icons.attach_money,
              ),
              const SizedBox(width: 8),
              _buildInfoChip(
                label: "រយៈពេល",
                value: "${widget.paymentschedule.duration} ខែ",
                icon: Icons.calendar_today,
              ),
            ],
          ),
        ),

        // Client info
        _buildInfoRowMobile(
          label: "អតិថិជន",
          value: widget.paymentschedule.clientName,
          icon: Icons.person,
        ),

        // Expandable section
        if (_isExpanded) ...[
          const SizedBox(height: 16),
          Divider(color: TheColors.gray.withOpacity(0.3), height: 1),
          const SizedBox(height: 16),

          // Expanded details in cards
          _buildDetailCard(
            title: "ព័ត៌មានលម្អិត",
            children: [
              _buildDetailRow("ភេទ",
                  widget.paymentschedule.clientGender == 1 ? "ប្រុស" : "ស្រី"),
              _buildDetailRow("ទូរសព្ទ", widget.paymentschedule.clientPhone),
              _buildDetailRow("គោលបំណង", widget.paymentschedule.purpose),
              _buildDetailRow(
                  "ថ្លៃសេវា", widget.paymentschedule.processFee.toString()),
              _buildDetailRow(
                  "កាលបរិច្ឆេទ", widget.paymentschedule.approveDate),
            ],
          ),

          const SizedBox(height: 12),

          _buildDetailCard(
            title: "មន្ត្រីឥណទាន",
            children: [
              _buildDetailRow("ឈ្មោះ", widget.paymentschedule.coName),
              _buildDetailRow("ទូរសព្ទ", widget.paymentschedule.coPhone),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _buildInfoSection(
            title: "ព័ត៌មានអតិថិជន",
            icon: Icons.person_outline,
            children: [
              _buildInfoRowDesktop(
                "ឈ្មោះ",
                widget.paymentschedule.clientName,
                showIcon: true,
              ),
              _buildInfoRowDesktop(
                "ភេទ",
                widget.paymentschedule.clientGender == 1 ? "ប្រុស" : "ស្រី",
              ),
              _buildInfoRowDesktop(
                  "ទូរសព្ទ", widget.paymentschedule.clientPhone),
            ],
          ),
        ),

        // Vertical divider
        Container(
          width: 1,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          color: TheColors.gray.withOpacity(0.3),
        ),

        Expanded(
          flex: 2,
          child: _buildInfoSection(
            title: "កម្ចី #${widget.paymentschedule.loanId}",
            icon: Icons.credit_card,
            children: [
              _buildHighlightedInfoRow(
                "ទំហំកម្ចី",
                "${widget.paymentschedule.loanAmount}",
                isAmount: true,
              ),
              _buildInfoRowDesktop(
                  "រយៈពេល", "${widget.paymentschedule.duration} ខែ"),
              _buildInfoRowDesktop(
                  "ថ្លៃសេវា", widget.paymentschedule.processFee.toString()),
              _buildInfoRowDesktop(
                  "កាលបរិច្ឆេទ", widget.paymentschedule.approveDate),
              _buildInfoRowDesktop("គោលបំណង", widget.paymentschedule.purpose),
            ],
          ),
        ),

        // Vertical divider
        Container(
          width: 1,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          color: TheColors.gray.withOpacity(0.3),
        ),

        Expanded(
          child: _buildInfoSection(
            title: "មន្ត្រីឥណទាន",
            icon: Icons.badge_outlined,
            children: [
              _buildInfoRowDesktop("ឈ្មោះ", widget.paymentschedule.coName),
              _buildInfoRowDesktop("ទូរសព្ទ", widget.paymentschedule.coPhone),
              const SizedBox(height: 16),
              // Status badge
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: TheColors.lightOrage.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border:
                      Border.all(color: TheColors.lightOrage.withOpacity(0.3)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: TheColors.lightOrage,
                      size: 16,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      "បានអនុម័ត",
                      style: TextStyles.siemreap(
                        context,
                        fontSize: 12,
                        color: TheColors.lightOrage,
                        fontweight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoSection({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: TheColors.lightOrage, size: 20),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyles.siemreap(
                context,
                fontSize: 16,
                fontweight: FontWeight.w600,
                color: TheColors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    );
  }

  Widget _buildInfoChip({
    required String label,
    required String value,
    required IconData icon,
  }) {
    return Flexible(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: TheColors.lightOrage.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: TheColors.lightOrage),
            const SizedBox(width: 6),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyles.siemreap(
                    context,
                    fontSize: 10,
                    color: TheColors.lightOrage.withOpacity(0.8),
                  ),
                ),
                Text(
                  value,
                  style: TextStyles.siemreap(
                    context,
                    fontSize: 14,
                    color: TheColors.white,
                    fontweight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRowMobile({
    required String label,
    required String? value,
    IconData? icon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, size: 18, color: TheColors.lightOrage),
            const SizedBox(width: 8),
          ],
          Expanded(
            child: Text(
              label,
              style: TextStyles.siemreap(
                context,
                fontSize: 14,
                color: TheColors.lightOrage.withOpacity(0.8),
              ),
            ),
          ),
          Expanded(
            child: Text(
              value ?? "មិនមាន",
              style: TextStyles.siemreap(
                context,
                fontSize: 14,
                color: TheColors.white,
                fontweight: FontWeight.w500,
              ),
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRowDesktop(String label, String? value,
      {bool showIcon = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (showIcon)
                Icon(Icons.circle, size: 6, color: TheColors.lightOrage),
              if (showIcon) const SizedBox(width: 8),
              Expanded(
                child: Text(
                  label,
                  style: TextStyles.siemreap(
                    context,
                    fontSize: 13,
                    color: TheColors.lightOrage.withOpacity(0.8),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            value ?? "មិនមាន",
            style: TextStyles.siemreap(
              context,
              fontSize: 15,
              color: TheColors.white,
              fontweight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHighlightedInfoRow(String label, String value,
      {bool isAmount = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyles.siemreap(
              context,
              fontSize: 13,
              color: TheColors.lightOrage.withOpacity(0.8),
            ),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  TheColors.lightOrage.withOpacity(0.1),
                  TheColors.lightOrage.withOpacity(0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: TheColors.lightOrage.withOpacity(0.2)),
            ),
            child: Row(
              children: [
                if (isAmount)
                  Icon(
                    Icons.attach_money,
                    color: TheColors.lightOrage,
                    size: 20,
                  ),
                if (isAmount) const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    value,
                    style: TextStyles.siemreap(
                      context,
                      fontSize: isAmount ? 20 : 16,
                      color: TheColors.white,
                      fontweight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailCard({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: TheColors.gray.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyles.siemreap(
              context,
              fontSize: 16,
              fontweight: FontWeight.w600,
              color: TheColors.white,
            ),
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              "$label:",
              style: TextStyles.siemreap(
                context,
                fontSize: 14,
                color: TheColors.lightOrage.withOpacity(0.8),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              value ?? "មិនមាន",
              style: TextStyles.siemreap(
                context,
                fontSize: 14,
                color: TheColors.white,
                fontweight: FontWeight.w500,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
