import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loanfrontend/core/constant/constants.dart';
import 'package:loanfrontend/core/theme/app_color.dart';
import 'package:loanfrontend/core/theme/text_styles.dart';
import 'package:loanfrontend/data/models/recieptmodel.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:intl/intl.dart';

class Recieptcard extends StatelessWidget {
  final Data reciept;
  final VoidCallback ontap;
  const Recieptcard({super.key, required this.reciept, required this.ontap});

  @override
  Widget build(BuildContext context) {
    final breakpoints = ResponsiveBreakpoints.of(context);
    final bool isMobile = breakpoints.isMobile;
    final bool isTablet = breakpoints.isTablet;
    final double avatarRadius = isMobile ? 32 : (isTablet ? 40 : 48);
    final double cardPadding = isMobile ? 16 : 20;
    final double iconSize = isMobile ? 16 : 20;
    final double smallFontSize = isMobile ? 12 : 15;
    // Status color based on data
    final statusColor =
        reciept.totalPenalty! > 0 ? TheColors.red : TheColors.successColor;
    final statusText = reciept.totalPenalty! > 0 ? 'មានពិន័យ' : 'ធម្មតា';

    return InkWell(
      onTap: ontap,
      borderRadius: BorderRadius.circular(16.0),
      child: Container(
        margin:
            EdgeInsets.symmetric(horizontal: isMobile ? 16 : 10, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: TheColors.bgColor,
          border: Border.all(color: TheColors.gray, width: 1),
        ),
        child: Padding(
          padding: EdgeInsets.all(cardPadding),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header row with client info and status
                Row(
                  children: [
                    // Client avatar with status indicator
                    Stack(
                      children: [
                                        Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: TheColors.checked,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(isMobile ? 50 : 60),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: CircleAvatar(
                        radius: avatarRadius,
                        backgroundColor: TheColors.bgColor,
                        backgroundImage: reciept.clientImage != null
                            ? NetworkImage(
                                "${Appconstants.baseUrl}/clientimage/${reciept.clientImage}")
                            : const NetworkImage(
                                'https://cdn-icons-png.flaticon.com/512/17634/17634775.png',
                              ) as ImageProvider,
                      ),
                    ),
                  ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                              color: statusColor,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: TheColors.bgColor,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 10),
            
                    // Client name and status
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  reciept.clientName ?? 'អតិថិជន',
                                  style: TextStyles.siemreap(
                                    context,
                                    fontSize: smallFontSize,
                                    fontweight: FontWeight.w600,
                                    color: TheColors.white,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: statusColor.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      color: statusColor.withOpacity(0.3)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Text(
                                    statusText,
                                    style: TextStyles.siemreap(
                                      context,
                                      fontSize: smallFontSize,
                                      fontweight: FontWeight.w500,
                                      color: statusColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: TheColors.cutecolo.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: TheColors.cutecolo.withOpacity(0.3)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                reciept.villageName ?? 'ទីតាំងមិនមាន',
                                style: TextStyles.siemreap(
                                  context,
                                  fontSize: smallFontSize,
                                  color: TheColors.cutecolo,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
            
                SizedBox(height: 20),
            
                // Amounts section with clean layout
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border:
                        Border.all(color: TheColors.errorColor.withOpacity(0.3)),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // Total to collect
                        _buildAmountRow(
                          context,
                          label: 'ប្រាក់ត្រូវបង់សរុប',
                          amount: reciept.totalCollect ?? 0,
                          isMobile: isMobile,
                          isPrimary: true,
                        ),
                    
                        SizedBox(height: 12),
                    
                        // Penalty details if exists
                        if (reciept.totalPenalty! > 0) ...[
                          _buildAmountRow(
                            context,
                            label: 'ពិន័យសរុប',
                            amount: reciept.totalPenalty ?? 0,
                            isMobile: isMobile,
                            isWarning: true,
                          ),
                          SizedBox(height: 8),
                          _buildDetailRow(
                            label: 'ចំនួនថ្ងៃពិន័យ',
                            value: '${reciept.penaltyDay} ថ្ងៃ',
                            isMobile: isMobile,
                          ),
                          SizedBox(height: 12),
                        ],
                    
                        // Lump sum payment
                        _buildAmountRow(
                          context,
                          label: 'ប្រាក់ត្រូវបង់ផ្ដាច់',
                          amount: reciept.lumpSumPayment ?? 0,
                          isMobile: isMobile,
                          isSuccess: true,
                        ),
                      ],
                    ),
                  ),
                ),
            
                SizedBox(height: 16),
            
                // Footer with action button
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'ថ្ងៃបង់ប្រាក់: ${DateFormat('dd/MM/yyyy').format(DateTime.now())}',
                        style: GoogleFonts.siemreap(
                          fontSize: 12,
                          color: TheColors.white,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 36,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            colors: [
                              TheColors.checked,
                              TheColors.checked.withOpacity(0.8),
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                        ),
                        child: TextButton.icon(
                          onPressed: ontap,
                          icon: const Icon(
                            Icons.payment,
                            size: 16,
                            color: Colors.white,
                          ),
                          label: Text(
                            'បង់ប្រាក់',
                            style: GoogleFonts.siemreap(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAmountRow(
    BuildContext context, {
    required String label,
    required int amount,
    required bool isMobile,
    bool isPrimary = false,
    bool isWarning = false,
    bool isSuccess = false,
  }) {
    Color amountColor = isWarning
        ? TheColors.warningColor
        : isSuccess
            ? TheColors.successColor
            : isPrimary
                ? TheColors.checked
                : TheColors.white;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.siemreap(
            fontSize: isMobile ? 14 : 15,
            color: TheColors.white,
          ),
        ),
        Text(
          '$amount ៛',
          style: GoogleFonts.siemreap(
            fontSize: isMobile ? 16 : 18,
            fontWeight: FontWeight.w600,
            color: amountColor,
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow({
    required String label,
    required String value,
    required bool isMobile,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.siemreap(
            fontSize: isMobile ? 13 : 14,
            color: TheColors.white,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.siemreap(
            fontSize: isMobile ? 13 : 14,
            fontWeight: FontWeight.w500,
            color: TheColors.white,
          ),
        ),
      ],
    );
  }
}
