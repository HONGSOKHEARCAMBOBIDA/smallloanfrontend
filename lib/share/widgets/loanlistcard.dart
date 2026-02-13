import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loanfrontend/core/constant/constants.dart';
import 'package:loanfrontend/core/theme/app_color.dart';
import 'package:loanfrontend/data/models/loanmodel.dart';
import 'package:loanfrontend/share/widgets/common_widgets.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:google_fonts/google_fonts.dart';

class Loanlistcard extends StatelessWidget {
  final Data loan;
  final VoidCallback onTap;

  const Loanlistcard({
    super.key,
    required this.loan,
    required this.onTap,
  });

  Color statusColor(String? status) {
    switch (status) {
      case "1":
        return TheColors.pending;
      case "2":
        return TheColors.checked;
      case "3":
        return TheColors.approve;
      case "4":
        return TheColors.successColor;
      case "0":
        return TheColors.gray;
      default:
        return TheColors.gray;
    }
  }

  String getStatusText(String? status) {
    switch (status) {
      case "1":
        return "កំពុងរង់ចាំ";
      case "2":
        return "បានត្រួតពិនិត្យ";
      case "3":
        return "កំពុងដំណេីរការ";
      case "4":
        return "បានបញ្ចាំង";
      case "0":
        return "បានបិទ";
      default:
        return "មិនស្គាល់";
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final isTablet = ResponsiveBreakpoints.of(context).isTablet;
    final double iconSize = isMobile ? 12 : 18;
    final double nameFontSize = isMobile ? 11 : 16;

    final double avatarRadius = isMobile ? 36 : (isTablet ? 44 : 40);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Card(
        color: TheColors.bgColor,
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // optional
          side: const BorderSide(
            color: TheColors.gray, // 👈 your border color
            width: 1, // optional
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row
              Row(
                children: [
                  // Avatar
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: statusColor(loan.status),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(isMobile ? 50 : 70),
                    ),
                    child: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl:
                            "${Appconstants.baseUrl}/clientimage/${loan.clientImage}",
                        width: avatarRadius * 2,
                        height: avatarRadius * 2,
                        fit: BoxFit.cover,
                        placeholder: (_, __) => const CircularProgressIndicator(
                          color: TheColors.warningColor,
                        ),
                        errorWidget: (_, __, ___) => Image.network(
                          'https://cdn-icons-png.flaticon.com/512/17634/17634775.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Client Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: SelectableText(
                                loan.clientName ?? "អតិថិជនមិនស្គាល់",
                                style: GoogleFonts.siemreap(
                                  fontSize: nameFontSize,
                                  fontWeight: FontWeight.bold,
                                  color: TheColors.white,
                                ),
                                maxLines: 1,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                  color: statusColor(loan.status)
                                      .withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                      color: statusColor(loan.status)
                                          .withOpacity(0.3))),
                              child: Text(
                                getStatusText(loan.status),
                                style: GoogleFonts.siemreap(
                                  fontSize: nameFontSize,
                                  color: statusColor(loan.status),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Icons.phone,
                              color: TheColors.checked,
                              size: iconSize,
                            ),
                            CommonWidgets.SizeBoxwidh5,
                            Text(
                              loan.clientPhone ?? "មិនមានលេខទូរសព្ទ",
                              style: GoogleFonts.siemreap(
                                fontSize: nameFontSize,
                                color: TheColors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Loan Details
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                            "ចំនួនទឹកប្រាក់",
                            style: GoogleFonts.siemreap(
                              fontSize: nameFontSize,
                              color: TheColors.white,
                            ),
                          ),
                        ),
                        Text(
                          "${loan.loanAmount} ៛",
                          style: GoogleFonts.siemreap(
                            fontSize: nameFontSize,
                            fontWeight: FontWeight.bold,
                            color: TheColors.successColor,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                            "បុគ្គលិក",
                            style: GoogleFonts.siemreap(
                              fontSize: nameFontSize,
                              color: TheColors.white,
                            ),
                          ),
                        ),
                        Text(
                          loan.coName ?? "មិនមាន",
                          style: GoogleFonts.siemreap(
                            fontSize: nameFontSize,
                            color: TheColors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              // Footer
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "ប្រភេទកម្ចី: ${loan.loanProductName ?? "មិនមាន"}",
                      style: GoogleFonts.siemreap(
                        fontSize: nameFontSize,
                        color: TheColors.warningColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (loan.approveDate != null)
                    Text(
                      "កាលបរិច្ឆេទអនុម័ត: ${loan.approveDate}",
                      style: GoogleFonts.siemreap(
                        fontSize: nameFontSize,
                        color: TheColors.white,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
