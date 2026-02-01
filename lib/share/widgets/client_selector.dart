// share/widgets/client_selector.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loanfrontend/core/constant/constants.dart';
import 'package:loanfrontend/core/theme/app_color.dart';
import 'package:loanfrontend/core/theme/text_styles.dart';
import 'package:loanfrontend/data/models/clientmodel.dart';
import 'package:loanfrontend/share/widgets/common_widgets.dart';
import 'package:loanfrontend/share/widgets/elevated_button.dart';
import 'package:loanfrontend/share/widgets/textfield.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ClientSelector extends StatefulWidget {
  final List<Data> client;
  final int? selectedClientId;
  final List<int>? selectedClientIds;
  final Function(int)? onSelected;
  final Function(List<int>)? onMultipleSelected;
  final bool allowMultiple;
  final TextEditingController? searchController;

  const ClientSelector({
    Key? key,
    required this.client,
    this.selectedClientId,
    this.selectedClientIds,
    this.onSelected,
    this.onMultipleSelected,
    this.allowMultiple = false,
    this.searchController,
  });

  @override
  State<ClientSelector> createState() => _ClientSelectorState();
}

class _ClientSelectorState extends State<ClientSelector> {
  @override
  Widget build(BuildContext context) {
    final breakpoints = ResponsiveBreakpoints.of(context);
    final bool isMobile = breakpoints.isMobile;
    final bool isTablet = breakpoints.isTablet;
    final double avatarRadius = isMobile ? 36 : (isTablet ? 44 : 56);
    final RxList<int> tempSelectedIds = (widget.selectedClientIds ?? []).obs;
    final RxList<Data> filteredClients = widget.client.obs;
    final searchCtrl = widget.searchController ?? TextEditingController();

    void filterClients(String query) {
      if (query.isEmpty) {
        filteredClients.value = widget.client;
      } else {
        filteredClients.value = widget.client
            .where((client) =>
                client.name!.toLowerCase().contains(query.toLowerCase()) ||
                (client.phone ?? '')
                    .toLowerCase()
                    .contains(query.toLowerCase()))
            .toList();
      }
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'ជ្រើសរើសអតិថិជន',
                style: TextStyles.siemreap(context).copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: TheColors.white),
              ),
              IconButton(
                  icon: const Icon(Icons.close, color: TheColors.white),
                  onPressed: () => Get.back()),
            ],
          ),
          CommonWidgets.SizeBoxh15,
          CustomTextField(
            controller: searchCtrl,
            hintText: "ស្វែងរកអតិថិជន...",
            onChanged: filterClients,
          ),
          CommonWidgets.SizeBoxh15,
          if (widget.allowMultiple)
            Obx(() => Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.check_circle,
                          color: TheColors.orange, size: 25),
                      const SizedBox(width: 8),
                      Text(
                        'បានជ្រើសរើស: ${tempSelectedIds.length} នាក់',
                        style: TextStyles.siemreap(context,
                            color: TheColors.orange,
                            fontweight: FontWeight.w500,
                            fontSize: CommonWidgets.fontsize15),
                      ),
                    ],
                  ),
                )),
          if (widget.allowMultiple) const SizedBox(height: 16),
          Expanded(
            child: Obx(() {
              if (filteredClients.isEmpty) {
                return Center(
                  child: Text(
                    'គ្មានទិន្នន័យ',
                    style: TextStyles.siemreap(context).copyWith(
                      color: TheColors.white,
                    ),
                  ),
                );
              }
              return ListView.builder(
                itemCount: filteredClients.length,
                itemBuilder: (context, index) {
                  final client = filteredClients[index];
                  // contains means Does this list have this value inside it
                  final isSelected = widget.allowMultiple
                      ? tempSelectedIds.contains(client.id)
                      : client.id == widget.selectedClientId;

                  return Builder(builder: (context) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color:
                              isSelected ? TheColors.cutecolo : Colors.transparent,
                          width: isSelected ? 1.5 : 0.5,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        color: isSelected
                            ? TheColors.bgColor.withOpacity(0.1)
                            : Colors.blueGrey,
                      ),
                      child: ListTile(
                        leading: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: TheColors.errorColor,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: CircleAvatar(
                              radius: avatarRadius,
                              backgroundColor: Colors.transparent,
                              backgroundImage: (client.imagePath != null &&
                                      client.imagePath!.isNotEmpty)
                                  ? NetworkImage(
                                      "${Appconstants.baseUrl}/clientimage/${client.imagePath}")
                                  : const NetworkImage(
                                      'https://cdn-icons-png.flaticon.com/512/17634/17634775.png',
                                    ) as ImageProvider,
                            ),
                          ),
                        ),
                        title: Text(
                          "ឈ្មោះ :  ${client.name ?? ""}",
                          style: TextStyles.siemreap(context).copyWith(
                            fontWeight: FontWeight.w500,
                            color: isSelected ? TheColors.white : Colors.black,
                          ),
                        ),
                        subtitle: Text(
                          "លេខទូរសព្ទ : ${client.phone ?? ""}, "
                          "${client.gender == 1 ? "ប្រុស" : client.gender == 2 ? "ស្រី" : ""}, "
                          "${client.occupation ?? ""}, "
                          "${client.dateOfBirth ?? ""}",
                          style: TextStyles.siemreap(context).copyWith(
                            fontSize: 12,
                            color:
                                isSelected ? TheColors.white : TheColors.black,
                          ),
                        ),
                        trailing: widget.allowMultiple
                            ? Obx(() {
                                final isSelected =
                                    tempSelectedIds.contains(client.id);
                                return Checkbox(
                                  value: isSelected,
                                  onChanged: (value) {
                                    if (value == true) {
                                      tempSelectedIds.add(client.id!);
                                    } else {
                                      tempSelectedIds.remove(client.id);
                                    }
                                  },
                                );
                              })
                            : isSelected
                                ? const Icon(
                                    Icons.check_circle,
                                    color: TheColors.green,
                                  )
                                : null,
                        onTap: () {
                          if (client.id == null) return;

                          if (widget.allowMultiple) {
                            if (tempSelectedIds.contains(client.id)) {
                              tempSelectedIds.remove(client.id);
                            } else {
                              tempSelectedIds.add(client.id!);
                            }
                          } else {
                            widget.onSelected?.call(client.id!);
                            Get.back();
                          }
                        },
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                      ),
                    );
                  });
                },
              );
            }),
          ),

          // Action Buttons (for multiple selection)
          if (widget.allowMultiple)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Obx(() => CustomElevatedButton(
                          onPressed: tempSelectedIds.isEmpty
                              ? null
                              : () {
                                  Navigator.pop(context);
                                },
                          text: "ត្រឡប់ក្រោយ",
                          backgroundColor: TheColors.red,
                        )),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Obx(() => CustomElevatedButton(
                          onPressed: tempSelectedIds.isEmpty
                              ? null
                              : () {
                                  if (widget.onMultipleSelected != null) {
                                    widget.onMultipleSelected
                                        ?.call(List.from(tempSelectedIds));
                                  }

                                  Navigator.pop(context);
                                },
                          text: "បញ្ជូន",
                          backgroundColor: TheColors.green,
                        )),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
