import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/list_notifier.dart';
import 'package:loanfrontend/core/theme/app_color.dart';
import 'package:loanfrontend/core/theme/text_styles.dart';
import 'package:loanfrontend/data/models/usermodel.dart';
import 'package:loanfrontend/module/user/controller/usercontroller.dart';
import 'package:loanfrontend/share/widgets/textfield.dart';
import 'package:get/get.dart';

class UserCard extends StatefulWidget {
  final Data user;
  final bool isSelected;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const UserCard({
    Key? key,
    required this.user,
    this.isSelected = false,
    this.onTap,
    this.onEdit,
    this.onDelete,
  }) : super(key: key);

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  final controller = Get.find<Usercontroller>();
  final newpasswordcontroller = TextEditingController();

  @override
  void dispose() {
    newpasswordcontroller.dispose();
    super.dispose();
  }

  Color statusColor(bool status) {
    switch (status) {
      case true:
        return TheColors.green;
      case false:
        return TheColors.warningColor;
      default:
        return TheColors.gray;
    }
  }

  Color _getRoleColor(String? roleName) {
    if (roleName == null) return TheColors.primaryColor;

    switch (roleName) {
      case 'ADMIN':
        return TheColors.errorColor;
      case 'MANAGER':
        return TheColors.warningColor;
      case 'LOAN_OFFICER':
        return TheColors.primaryColor;
      case 'CASHIER':
        return TheColors.green;
      case 'ACCOUNTANT':
        return TheColors.secondaryColor;
      default:
        return TheColors.primaryColor;
    }
  }

  String _getInitials(String? name) {
    if (name == null || name.isEmpty) return '??';
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name.substring(0, (name.length < 2 ? name.length : 2)).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final statusBgColor = widget.user.isActive == true
        ? TheColors.green.withOpacity(0.1)
        : TheColors.warningColor.withOpacity(0.1);
    final statusTextColor =
        widget.user.isActive == true ? TheColors.green : TheColors.red;

    return Card(
      color: TheColors.bgColor,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: widget.isSelected ? TheColors.primaryColor : TheColors.gray,
          width: widget.isSelected ? 1.5 : 0.5,
        ),
      ),
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with avatar and basic info
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Avatar with initials
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          _getRoleColor(widget.user.roleName).withOpacity(0.8),
                          _getRoleColor(widget.user.roleName).withOpacity(0.4),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        _getInitials(widget.user.name),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: 12),

                  // User details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.user.name ?? 'No Name',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: TheColors.white,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    '@${widget.user.username ?? 'N/A'}',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: TheColors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Status badge
                            Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: statusBgColor,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: statusTextColor.withOpacity(0.3),
                                      width: 1,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        width: 8,
                                        height: 8,
                                        decoration: BoxDecoration(
                                          color: statusTextColor,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      SizedBox(width: 6),
                                      Text(
                                        widget.user.isActive == true
                                            ? 'Active'
                                            : 'Inactive',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: statusTextColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.defaultDialog(
                                      title: "ប្រមូលប្រាក់",
                                      titleStyle: TextStyles.moul(context,
                                          fontSize: 16,
                                          color: TheColors.warningColor),
                                      backgroundColor:
                                          TheColors.bgColor, // important
                                      content: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          padding: const EdgeInsets.all(16),
                                          decoration: BoxDecoration(
                                            color: TheColors.bgColor,
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            border: Border.all(
                                              color: TheColors.gray,
                                              width: 1.2,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.15),
                                                blurRadius: 12,
                                                offset: const Offset(0, 6),
                                              ),
                                            ],
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                "តេីអ្នកពិតជាចង់កែប្រែពាក្យសម្ងាត់មែនទេ?",
                                                style: TextStyles.siemreap(
                                                    context),
                                                textAlign: TextAlign.center,
                                              ),
                                              const SizedBox(height: 10),
                                              CustomTextField(
                                                  controller:
                                                      newpasswordcontroller,
                                                  hintText: "ពាក្យសម្ងាត់ថ្មី"),
                                              const SizedBox(height: 20),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: OutlinedButton(
                                                      onPressed: () =>
                                                          Get.back(),
                                                      style: OutlinedButton
                                                          .styleFrom(
                                                        side: const BorderSide(
                                                            color:
                                                                TheColors.red),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                      ),
                                                      child: Text("ចាកចេញ",
                                                          style: TextStyles
                                                              .siemreap(context,
                                                                  fontSize: 12,
                                                                  color: TheColors
                                                                      .white)),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 12),
                                                  Expanded(
                                                    child: Obx(() {
                                                      return ElevatedButton(
                                                        onPressed:
                                                            controller.isLoading
                                                                    .value
                                                                ? null
                                                                : () async {
                                                                    await controller.changepassword(
                                                                        id: widget
                                                                            .user
                                                                            .id!,
                                                                        password:
                                                                            newpasswordcontroller.text!);
                                                                  },
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              TheColors.green,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                        ),
                                                        child: controller
                                                                .isLoading.value
                                                            ? const SizedBox(
                                                                width: 20,
                                                                height: 20,
                                                                child:
                                                                    CircularProgressIndicator(
                                                                  strokeWidth:
                                                                      2,
                                                                  color: TheColors
                                                                      .cutecolo,
                                                                ),
                                                              )
                                                            : Text(
                                                                "កែប្រែ",
                                                                style: TextStyles
                                                                    .siemreap(
                                                                  context,
                                                                  fontSize: 12,
                                                                  color:
                                                                      TheColors
                                                                          .white,
                                                                ),
                                                              ),
                                                      );
                                                    }),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.only(
                                        left: 8, right: 8, top: 2),
                                    child: Icon(
                                      Icons.lock,
                                      size: 30,
                                      color: TheColors.pending,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),

                        SizedBox(height: 8),

                        // Role chip
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: _getRoleColor(widget.user.roleName)
                                .withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            widget.user.roleName ?? 'No Role',
                            style: TextStyle(
                              fontSize: 12,
                              color: _getRoleColor(widget.user.roleName),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: 16),

              // Divider
              Divider(
                height: 0.3,
                color: TheColors.gray,
              ),

              SizedBox(height: 16),

              // Contact info section with better styling
              Column(
                children: [
                  _buildInfoRow(
                    icon: Icons.email_outlined,
                    label: 'Email',
                    value: widget.user.email ?? 'N/A',
                    iconColor: TheColors.checked,
                  ),
                  SizedBox(height: 12),
                  _buildInfoRow(
                    icon: Icons.phone_outlined,
                    label: 'Phone',
                    value: widget.user.phone ?? 'N/A',
                    iconColor: TheColors.checked,
                  ),
                  SizedBox(height: 12),
                  _buildInfoRow(
                    icon: Icons.badge_outlined,
                    label: 'User ID',
                    value: '#${widget.user.id?.toString() ?? 'N/A'}',
                    iconColor: TheColors.green,
                    valueColor: TheColors.checked,
                    isMonospace: true,
                  ),
                ],
              ),

              SizedBox(height: 16),

              // Action buttons with better styling
              if (widget.onEdit != null || widget.onDelete != null)
                Row(
                  children: [
                    if (widget.onEdit != null)
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: widget.onEdit,
                          icon: Icon(Icons.edit_outlined, size: 18),
                          label: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Text(
                              'កែប្រែ',
                              style: TextStyles.siemreap(context,
                                  fontweight: FontWeight.w500),
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: TheColors.primaryColor,
                            side: BorderSide(color: TheColors.primaryColor),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 10),
                          ),
                        ),
                      ),
                    if (widget.onEdit != null && widget.onDelete != null)
                      SizedBox(width: 12),
                    if (widget.onDelete != null)
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: widget.onDelete,
                          icon: Icon(Icons.delete_outline, size: 18),
                          label: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Text(
                              widget.user.isActive == true ? "លុប" : "បេីកវិញ",
                              style: TextStyles.siemreap(context,
                                  fontweight: FontWeight.w500),
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: TheColors.errorColor,
                            side: BorderSide(color: TheColors.errorColor),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 10),
                          ),
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

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    Color iconColor = TheColors.primaryColor,
    Color valueColor = TheColors.black,
    bool isMonospace = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Icon(
              icon,
              size: 18,
              color: iconColor,
            ),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label.toUpperCase(),
                style: TextStyle(
                  fontSize: 11,
                  color: TheColors.white,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5,
                ),
              ),
              SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(
                  fontSize: 15,
                  color: TheColors.warningColor,
                  fontWeight: FontWeight.w500,
                  fontFamily: isMonospace ? 'RobotoMono' : null,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
