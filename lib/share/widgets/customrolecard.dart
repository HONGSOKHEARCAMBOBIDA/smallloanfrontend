import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loanfrontend/core/theme/app_color.dart';
import 'package:loanfrontend/core/theme/text_styles.dart';
import 'package:popover/popover.dart';

class CustomRoleCard extends StatelessWidget {
  final String name;
  final String displayname;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onTap;
  final VoidCallback? deletepermission;
  final bool? isActive;

  const CustomRoleCard({
    Key? key,
    required this.name,
    required this.displayname,
    required this.onEdit,
    required this.onDelete,
    required this.onTap,
    this.deletepermission,
    this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      splashColor: theme.colorScheme.primary.withOpacity(0.1),
      highlightColor: theme.colorScheme.primary.withOpacity(0.05),
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Card(
          color: TheColors.bgColor,
          borderOnForeground: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // optional
            side: const BorderSide(
              color: TheColors.gray, // 👈 your border color
              width: 0.5, // optional
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Left side: name + insurance
                Row(
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: TheColors.warningColor, // Border color
                                width: 0.9,
                              ),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: CachedNetworkImage(
                                imageUrl:
                                    "https://cdn-icons-png.flaticon.com/128/9671/9671856.png",
                                width: 45,
                                height: 45,
                                fit: BoxFit.cover,
                                memCacheWidth: 100,
                                memCacheHeight: 100,
                                maxWidthDiskCache: 200,
                                maxHeightDiskCache: 200,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 14,
                            height: 14,
                            decoration: BoxDecoration(
                              color: isActive == true
                                  ? TheColors.successColor
                                  : TheColors.red,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isDarkMode
                                    ? Colors.grey[850]!
                                    : Colors.white,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              displayname,
                              style: GoogleFonts.siemreap(
                                  fontSize: 13, color: TheColors.white),
                            ),
                            Row(
                              children: [
                                Text(
                                  name,
                                  style: TextStyles.siemreap(context,
                                      fontSize: 12, color: TheColors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                // Right side: actions
                _buildActionMenu(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionMenu(BuildContext context) {
    final theme = Theme.of(context);

    return Builder(
      builder: (innerContext) {
        return IconButton(
          icon: Icon(
            Icons.more_vert,
            color: TheColors.white,
          ),
          padding: EdgeInsets.zero,
          onPressed: () {
            final box = innerContext.findRenderObject() as RenderBox;
            final overlay = Overlay.of(innerContext).context.findRenderObject()
                as RenderBox;
            final position = RelativeRect.fromRect(
              Rect.fromPoints(
                box.localToGlobal(Offset.zero, ancestor: overlay),
                box.localToGlobal(
                  box.size.bottomRight(Offset.zero),
                  ancestor: overlay,
                ),
              ),
              Offset.zero & overlay.size,
            );

            showPopover(
              context: innerContext,
              bodyBuilder: (context) => Material(
                elevation: 6,
                color: TheColors.bgColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildMenuItem(
                      context,
                      icon: Icons.edit,
                      color: theme.colorScheme.primary,
                      text: 'កែប្រែ',
                      onTap: onEdit,
                    ),

                    // 🟢 Dynamic item based on isActive
                    _buildMenuItem(
                      context,
                      icon: isActive == true ? Icons.block : Icons.check_circle,
                      color: isActive == true
                          ? TheColors.errorColor
                          : TheColors.successColor,
                      text: isActive == true ? 'បិទ' : 'បើក',
                      onTap: () => _confirmDelete(context),
                    ),

                    _buildMenuItem(
                      context,
                      icon: Icons.lock,
                      color: TheColors.errorColor,
                      text: "ដកសិទ្ធ",
                      onTap: deletepermission!,
                    ),
                  ],
                ),
              ),
              direction: PopoverDirection.bottom,
              width: 140,
              height: 125,
              arrowHeight: 10,
              arrowWidth: 20,
              radius: 5,
            );
          },
        );
      },
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required Color color,
    required String text,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pop(); // Close the popover
        onTap();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(icon, color: color, size: 15),
            const SizedBox(width: 20),
            Text(text, style: TextStyles.siemreap(context, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    final actionText = isActive == true ? 'បិទ' : 'បើក';
    final confirmMessage = isActive == true
        ? 'តើអ្នកពិតជាចង់បិទមែនទេ?'
        : 'តើអ្នកពិតជាចង់បើកមែនទេ?';

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: TheColors.bgColor,
        title: Text('បញ្ជាក់', style: GoogleFonts.siemreap()),
        content: Text(confirmMessage, style: GoogleFonts.siemreap()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('បោះបង់', style: GoogleFonts.siemreap()),
          ),
          TextButton(
            onPressed: () {
              onDelete(); // handle API call for activate/deactivate
              Get.back();
            },
            child: Text(actionText, style: GoogleFonts.siemreap()),
          ),
        ],
      ),
    );
  }
}
