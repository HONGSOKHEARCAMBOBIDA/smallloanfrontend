import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loanfrontend/core/constant/constants.dart';
import 'package:loanfrontend/core/theme/app_color.dart';
import 'package:loanfrontend/core/theme/text_styles.dart';

class Clientcard extends StatelessWidget {
  final String name;
  final int gender;
  final String maritalStatus;
  final String dateOfBirth;
  final String occupation;
  final String idCardNumber;
  final String phone;
  final double latitude;
  final double longitude;
  final String imagePath;
  final String notes;
  final bool isActive;
  final int createdBy;
  final String createByName;
  final int provinceId;
  final String provinceName;
  final int districtId;
  final String districtName;
  final int communceId;
  final String communceName;
  final int villageId;
  final String villageName;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  const Clientcard({
    Key? key,
    required this.name,
    required this.gender,
    required this.maritalStatus,
    required this.dateOfBirth,
    required this.occupation,
    required this.idCardNumber,
    required this.phone,
    required this.latitude,
    required this.longitude,
    required this.imagePath,
    required this.notes,
    required this.isActive,
    required this.createdBy,
    required this.createByName,
    required this.provinceId,
    required this.provinceName,
    required this.districtId,
    required this.districtName,
    required this.communceId,
    required this.communceName,
    required this.villageId,
    required this.villageName,
    required this.onEdit,
    required this.onDelete,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int calculateAge(String dob) {
      DateTime birthDate = DateTime.parse(dob);
      DateTime today = DateTime.now();

      int age = today.year - birthDate.year;

      if (today.month < birthDate.month ||
          (today.month == birthDate.month && today.day < birthDate.day)) {
        age--;
      }

      return age;
    }

    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18.0),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: TheColors.orange, width: 0.5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Avatar with online/offline dot
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: TheColors.warningColor,
                        width: 0.9,
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: CircleAvatar(
                        radius: 44,
                        backgroundColor: TheColors.bgColor,
                        backgroundImage: imagePath.isNotEmpty
                            ? NetworkImage(
                                "${Appconstants.baseUrl}/clientimage/$imagePath")
                            : const NetworkImage(
                                'https://cdn-icons-png.flaticon.com/512/17634/17634775.png',
                              ) as ImageProvider,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 2,
                    right: 2,
                    child: Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        color:
                            isActive ? TheColors.successColor : TheColors.red,
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
              const SizedBox(width: 16),
              // Client info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name row
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Text(
                            "$name",
                            style: TextStyles.siemreap(
                              context,
                              fontSize: 13,
                              fontweight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Text(
                            "មុខរបរ : ",
                            style: GoogleFonts.siemreap(
                              fontSize: 12,
                              color: TheColors.successColor,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            occupation,
                            style: GoogleFonts.siemreap(
                              fontSize: 12,
                              color: TheColors.red,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "ភេទ : ",
                            style: GoogleFonts.siemreap(
                              fontSize: 12,
                              color: TheColors.successColor,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            gender == 1 ? "ប្រុស" : "ស្រី",
                            style: GoogleFonts.siemreap(
                              fontSize: 12,
                              color: TheColors.orange,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "អាយុ: : ",
                            style: GoogleFonts.siemreap(
                              fontSize: 12,
                              color: TheColors.successColor,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "${calculateAge(dateOfBirth)} ឆ្នាំ",
                            style: GoogleFonts.siemreap(
                              fontSize: 12,
                              color: TheColors.orange,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Phone number
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          const Icon(Icons.phone,
                              size: 12, color: TheColors.secondaryColor),
                          const SizedBox(width: 4),
                          Text(
                            phone,
                            style: TextStyles.siemreap(context,
                                color: TheColors.secondaryColor, fontSize: 11),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          "លេខអត្តសញ្ញាណបណ្ណ : ",
                          style: GoogleFonts.siemreap(
                            fontSize: 12,
                            color: TheColors.successColor,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          idCardNumber,
                          style: GoogleFonts.siemreap(
                            fontSize: 12,
                            color: TheColors.orange,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    // Location
                    Row(
                      children: [
                        const Icon(Icons.location_on,
                            size: 12, color: TheColors.secondaryColor),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            "$villageName, $communceName, $districtName, $provinceName",
                            style: TextStyles.siemreap(context,
                                fontSize: 11, color: TheColors.secondaryColor),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              _buildActionMenu(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionMenu(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Icon(
        Icons.more_vert,
        color: Theme.of(context).iconTheme.color?.withOpacity(0.7),
      ),
      color: TheColors.bgColor,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      onSelected: (value) {
        if (value == 'edit') {
          onEdit();
        } else if (value == 'delete') {
          onDelete();
        }
        // Note: Other actions (promote, changeshift, etc.) are not available
        // since you don't have those callbacks in your parameters
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 'edit',
          child: Row(
            children: [
              const Icon(Icons.edit, color: TheColors.orange, size: 20),
              const SizedBox(width: 8),
              Text('កែប្រែ', style: TextStyles.siemreap(context, fontSize: 12)),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'delete',
          child: Row(
            children: [
              Icon(
                isActive ? Icons.block : Icons.check_circle,
                color: isActive ? TheColors.errorColor : TheColors.successColor,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                isActive ? 'បិទ' : 'បើក',
                style: TextStyles.siemreap(context, fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
