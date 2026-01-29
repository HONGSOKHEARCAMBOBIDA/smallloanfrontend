// share/widgets/client_selector.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loanfrontend/core/theme/app_color.dart';
import 'package:loanfrontend/core/theme/text_styles.dart';
import 'package:loanfrontend/data/models/clientmodel.dart';
import 'package:loanfrontend/share/widgets/elevated_button.dart';

class ClientSelector extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final RxList<int> tempSelectedIds = (selectedClientIds ?? []).obs;
    final RxList<Data> filteredClients = client.obs;
    final searchCtrl = searchController ?? TextEditingController();

    void filterClients(String query) {
      if (query.isEmpty) {
        filteredClients.value = client;
      } else {
        filteredClients.value = client
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
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Search Field
          TextField(
            style: TextStyle(color: TheColors.white),
            controller: searchCtrl,
            decoration: InputDecoration(
              hintText: 'ស្វែងរកអតិថិជន...',
              hintStyle: TextStyles.kantomruy(context, color: TheColors.white),
              prefixIcon: const Icon(Icons.search, color: TheColors.white),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: TheColors.gray),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: TheColors.gray),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: TheColors.orange, width: 1.5),
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 16,
              ),
            ),
            onChanged: filterClients,
          ),
          const SizedBox(height: 16),

          // Selected Count (for multiple selection)
          if (allowMultiple)
            Obx(() => Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  decoration: BoxDecoration(
                    color: TheColors.bgColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.check_circle,
                          color: TheColors.orange, size: 16),
                      const SizedBox(width: 8),
                      Text(
                        'បានជ្រើសរើស: ${tempSelectedIds.length} នាក់',
                        style: TextStyles.kantomruy(
                          context,
                          color: TheColors.orange,
                          fontweight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                )),
          if (allowMultiple) const SizedBox(height: 16),

          // Client List
          Expanded(
            child: Obx(() {
              if (filteredClients.isEmpty) {
                return Center(
                  child: Text(
                    'គ្មានទិន្នន័យ',
                    style: TextStyles.siemreap(context).copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                );
              }

              return ListView.builder(
                itemCount: filteredClients.length,
                itemBuilder: (context, index) {
                  final client = filteredClients[index];
                  final isSelected = allowMultiple
                      ? tempSelectedIds.contains(client.id)
                      : client.id == selectedClientId;

                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isSelected ? TheColors.white : TheColors.gray,
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
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.person,
                          color:
                              isSelected ? TheColors.white : TheColors.bgColor,
                        ),
                      ),
                      title: Text(
                        client.name ?? 'គ្មានឈ្មោះ',
                        style: TextStyles.siemreap(context).copyWith(
                          fontWeight: FontWeight.w500,
                          color: isSelected ? TheColors.white : Colors.black,
                        ),
                      ),
                      subtitle: Text(
                        client.phone ?? 'គ្មានលេខទូរស័ព្ទ',
                        style: TextStyles.siemreap(context).copyWith(
                          fontSize: 12,
                          color: isSelected ? TheColors.white : TheColors.black,
                        ),
                      ),
                      trailing: allowMultiple
                          ? Checkbox(
                              value: isSelected,
                              onChanged: (value) {
                                if (value == true) {
                                  tempSelectedIds.add(client.id!);
                                } else {
                                  tempSelectedIds.remove(client.id);
                                }
                              },
                              activeColor: TheColors.orange,
                              checkColor: Colors.white,
                            )
                          : isSelected
                              ? const Icon(
                                  Icons.check_circle,
                                  color: TheColors.green,
                                )
                              : null,
                      onTap: () {
                        if (client.id == null) return;

                        if (allowMultiple) {
                          if (tempSelectedIds.contains(client.id)) {
                            tempSelectedIds.remove(client.id);
                          } else {
                            tempSelectedIds.add(client.id!);
                          }
                        } else {
                          onSelected?.call(client.id!);
                          Navigator.pop(context);
                        }
                      },
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                    ),
                  );
                },
              );
            }),
          ),

          // Action Buttons (for multiple selection)
          if (allowMultiple)
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
                                  if (onMultipleSelected != null) {
                                    onMultipleSelected
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
