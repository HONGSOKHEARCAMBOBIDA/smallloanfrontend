import 'package:flutter/material.dart';
import 'package:loanfrontend/core/constant/constants.dart';
import 'package:loanfrontend/core/theme/app_color.dart';
import 'package:loanfrontend/data/models/loancheckmodel.dart';
import 'package:loanfrontend/share/widgets/common_widgets.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:google_fonts/google_fonts.dart';

class Loancard extends StatelessWidget {
  final Data loan;
  final VoidCallback onTap;

  const Loancard({
    super.key,
    required this.loan,
    required this.onTap,
  });

  int calculateAge(String dob) {
    final birthDate = DateTime.parse(dob);
    final today = DateTime.now();
    int age = today.year - birthDate.year;
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  Color statusColor(String? status) {
    switch (status) {
      case "1":
        return TheColors.pending;
      case "checked":
        return TheColors.checked;
      case "approved":
        return TheColors.approve;
      default:
        return TheColors.gray;
    }
  }

  @override
  Widget build(BuildContext context) {
    final breakpoint = ResponsiveBreakpoints.of(context);
    final bool isMobile = breakpoint.isMobile;
    final bool isTablet = breakpoint.isTablet;

    final double avatarRadius = isMobile ? 36 : (isTablet ? 44 : 56);
    final double iconSize = isMobile ? 12 : 18;
    final double nameFontSize = isMobile ? 13 : (isTablet ? 14 : 18);
    final double smallFontSize = isMobile ? 12 : 15;
    final double cardPadding = isMobile ? 10 : 12;

    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Card(
        color: TheColors.bgColor,
        borderOnForeground: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // optional
          side: const BorderSide(
            color: TheColors.gray, // 👈 your border color
            width: 1, // optional
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(cardPadding),
          child: Row(
            children: [
              /// Avatar
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: TheColors.checked,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(isMobile ? 50 : 60),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: CircleAvatar(
                        radius: avatarRadius,
                        backgroundColor: TheColors.bgColor,
                        backgroundImage: loan.clientImage != null &&
                                loan.clientImage!.isNotEmpty
                            ? NetworkImage(
                                "${Appconstants.baseUrl}/clientimage/${loan.clientImage}",
                              )
                            : const NetworkImage(
                                "https://cdn-icons-png.flaticon.com/512/17634/17634775.png",
                              ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 2,
                    right: 2,
                    child: Container(
                      width: isMobile ? 12 : 14,
                      height: isMobile ? 12 : 14,
                      decoration: BoxDecoration(
                        color: statusColor(loan.status),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isDarkMode ? Colors.grey[850]! : Colors.white,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: isMobile ? 12 : 25),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              loan.clientName ?? "",
                              style: GoogleFonts.siemreap(
                                fontSize: nameFontSize,
                                fontWeight: FontWeight.bold,
                                color: TheColors.white,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            CommonWidgets.SizeBoxwidh5,
                            Container(
                              decoration: BoxDecoration(
                                  gradient: const LinearGradient(colors: [
                                    TheColors.cutecolo,
                                    TheColors.warningColor,
                                  ]),
                                  borderRadius: BorderRadius.circular(7)),
                              child: Padding(
                                padding: const EdgeInsets.all(7.0),
                                child: Text(
                                  "${loan.loanAmount.toString()} ៛",
                                  style: GoogleFonts.siemreap(
                                    fontSize: smallFontSize,
                                    fontWeight: FontWeight.bold,
                                    color: TheColors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 6),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              _label("មុខរបរ : ", smallFontSize),
                              _value(
                                  loan.clientOccupation ?? "", smallFontSize),
                              const SizedBox(width: 8),
                              _label("ភេទ : ", smallFontSize),
                              _value(
                                loan.clientGender == 1 ? "ប្រុស" : "ស្រី",
                                smallFontSize,
                              ),
                              const SizedBox(width: 8),
                              _label("អាយុ : ", smallFontSize),
                              _value(
                                loan.clientDateOfBirth != null
                                    ? "${calculateAge(loan.clientDateOfBirth!)} ឆ្នាំ"
                                    : "-",
                                smallFontSize,
                              ),
                              const SizedBox(width: 8),
                              _label("លេខទូរសព្ទ : ", smallFontSize),
                              _value(loan.clientPhone!, smallFontSize)
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 6),

                      /// Location
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: iconSize,
                              color: TheColors.lightOrage,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              "${loan.villageName}, ${loan.communceName}, ${loan.districtName}, ${loan.provinceName}",
                              style: GoogleFonts.siemreap(
                                fontSize: smallFontSize,
                                color: TheColors.white,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 6),

                      /// Phone
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Text(
                                "បុគ្គលិក :",
                                style: GoogleFonts.siemreap(
                                  fontSize: smallFontSize,
                                  color: TheColors.lightOrage,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                loan.coName ?? "",
                                style: GoogleFonts.siemreap(
                                  fontSize: smallFontSize,
                                  color: TheColors.white,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                "កម្ចី:",
                                style: GoogleFonts.siemreap(
                                  fontSize: smallFontSize,
                                  color: TheColors.lightOrage,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                loan.loanProductName ?? "",
                                style: GoogleFonts.siemreap(
                                  fontSize: smallFontSize,
                                  color: TheColors.white,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                "ស្ថានភាពគ្រួសារ:",
                                style: GoogleFonts.siemreap(
                                  fontSize: smallFontSize,
                                  color: TheColors.lightOrage,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                "( ${loan.clientMaritalStatus} )",
                                style: GoogleFonts.siemreap(
                                  fontSize: nameFontSize,
                                  fontWeight: FontWeight.bold,
                                  color: TheColors.cutecolo,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),

                      /// Phone
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "គោលបំណង :",
                                  style: GoogleFonts.siemreap(
                                    fontSize: smallFontSize,
                                    color: TheColors.lightOrage,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  loan.purpose ?? "",
                                  style: GoogleFonts.siemreap(
                                    fontSize: smallFontSize,
                                    color: TheColors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 6),

                      /// Phone
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "ត្រួតពិនិត្យដោយ:",
                                  style: GoogleFonts.siemreap(
                                    fontSize: smallFontSize,
                                    color: TheColors.lightOrage,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  loan.checkByName ?? "",
                                  style: GoogleFonts.siemreap(
                                    fontSize: smallFontSize,
                                    color: TheColors.white,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 6),
                            Row(
                              children: [
                                Text(
                                  "អនុម័តដោយ:",
                                  style: GoogleFonts.siemreap(
                                    fontSize: smallFontSize,
                                    color: TheColors.lightOrage,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  "${loan.approveByName}",
                                  style: GoogleFonts.siemreap(
                                    fontSize: smallFontSize,
                                    fontWeight: FontWeight.bold,
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _label(String text, double size) {
    return Text(
      text,
      style: GoogleFonts.siemreap(
        fontSize: size,
        color: TheColors.successColor,
      ),
    );
  }

  Widget _value(String text, double size) {
    return Text(
      text,
      style: GoogleFonts.siemreap(
        fontSize: size,
        color: TheColors.orange,
      ),
    );
  }
}
