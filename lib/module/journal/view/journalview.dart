import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loanfrontend/module/journal/binding/updatejournalbinding.dart';
import 'package:loanfrontend/module/journal/controller/journalcontroller.dart';
import 'package:loanfrontend/module/journal/view/updatejournalview.dart';
import 'package:loanfrontend/share/widgets/datepicker.dart';
import 'package:loanfrontend/share/widgets/floating_buttom.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:loanfrontend/core/theme/app_color.dart';
import 'package:loanfrontend/core/theme/text_styles.dart';
import 'package:loanfrontend/share/widgets/app_bar.dart';
import 'package:loanfrontend/share/widgets/common_widgets.dart';
import 'package:loanfrontend/share/widgets/loading.dart';
import 'package:loanfrontend/share/widgets/textfield.dart';
import 'package:intl/intl.dart';

class Journalview extends StatefulWidget {
  const Journalview({super.key});

  @override
  State<Journalview> createState() => _JournalviewState();
}

class _JournalviewState extends State<Journalview> {
  final controller = Get.find<Journalcontroller>();
  final TextEditingController searchQuery = TextEditingController();
  final selectstartdate = Rxn<DateTime>();
  final selectenddate = Rxn<DateTime>();
  final ScrollController _scrollController = ScrollController();

  // For DataTable sorting
  int _sortColumnIndex = 0;
  bool _sortAscending = true;

  @override
  void initState() {
    controller.getjournal();
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    searchQuery.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        controller.hasMore.value &&
        !controller.isLoadingMore.value &&
        !controller.isLoading.value) {
      _loadMore();
    }
  }

  Future<void> _loadMore() async {
    await controller.loadMore();
  }

  Future<void> refresh() async {
    selectstartdate.value = null;
    selectenddate.value = null;
    searchQuery.clear();

    controller.journaldata.clear();
    await controller.getjournal(isRefresh: true);
  }

  // Format date
  String _formatDate(String? dateString) {
    if (dateString == null) return '';
    try {
      final date = DateTime.parse(dateString);
      return DateFormat('dd/MM/yyyy').format(date);
    } catch (e) {
      return dateString;
    }
  }

  String? buildBetweenDate() {
    if (selectstartdate.value == null || selectenddate.value == null) {
      return null;
    }

    final formatter = DateFormat('yyyy-MM-dd');

    final start = formatter.format(selectstartdate.value!);
    final end = formatter.format(selectenddate.value!);

    return "$start,$end";
  }

  @override
  Widget build(BuildContext context) {
    final breakpoints = ResponsiveBreakpoints.of(context);
    final bool isMobile = breakpoints.isMobile;
    final between = buildBetweenDate();
    return Scaffold(
      floatingActionButton: CustomFloatingActionButton(onPressed: () {
        Get.toNamed('/createjournal');
      }),
      backgroundColor: TheColors.bgColor,
      appBar: const CustomAppBar(title: "បញ្ជីប្រតិបត្តិការណ៍"),
      body: RefreshIndicator(
        backgroundColor: TheColors.cutecolo,
        color: TheColors.warningColor,
        onRefresh: refresh,
        child: Obx(() {
          if (controller.isLoading.value) {
            return Center(
              child: CustomLoading(),
            );
          }
          return CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 8 : 12,
                    vertical: 8,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: 8,
                          right: 8,
                          top: isMobile ? 0 : 30,
                        ),
                        child: Row(
                          children: [
                            // Search field - responsive
                            isMobile
                                ? Expanded(
                                    child: ConstrainedBox(
                                      constraints: BoxConstraints(
                                        maxWidth:
                                            MediaQuery.of(context).size.width -
                                                100,
                                      ),
                                      child: SizedBox(
                                        height: 50,
                                        child: CustomTextField(
                                          controller: searchQuery,
                                          hintText: "ស្វែងរក".tr,
                                          prefixIcon: Icons.search,
                                          onChanged: (value) {
                                            Future.delayed(
                                              const Duration(milliseconds: 200),
                                              () async {
                                                await controller.getjournal(
                                                  reference_code: value.isEmpty
                                                      ? null
                                                      : value,
                                                  between: between,
                                                  isRefresh: true,
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  )
                                : Expanded(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: SizedBox(
                                            height: 56,
                                            width: 200,
                                            child: CustomTextField(
                                              controller: searchQuery,
                                              hintText: "ស្វែងរកកូដយោង...".tr,
                                              prefixIcon: Icons.search,
                                              onChanged: (value) {
                                                Future.delayed(
                                                  const Duration(
                                                      milliseconds: 200),
                                                  () async {
                                                    await controller.getjournal(
                                                      reference_code:
                                                          value.isEmpty
                                                              ? null
                                                              : value,
                                                      between: between,
                                                      isRefresh: true,
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10, bottom: 10),
                                          child: CustomDatePickerField(
                                            label: "",
                                            selectedDate: selectstartdate,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10, bottom: 10),
                                          child: CustomDatePickerField(
                                            label: "",
                                            selectedDate: selectenddate,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                            // Refresh button
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 8,
                                  bottom: isMobile ? 0.0 : 15,
                                  top: isMobile ? 0.0 : 10),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: TheColors.cutecolo,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(3.0),
                                  child: InkWell(
                                    onTap: () async {
                                      await controller.getjournal(
                                        reference_code: searchQuery.text.isEmpty
                                            ? null
                                            : searchQuery.text,
                                        between: buildBetweenDate(),
                                        isRefresh: true,
                                      );
                                    },
                                    child: Icon(
                                      Icons.search,
                                      color: TheColors.white,
                                      size: isMobile ? 30 : 34,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      CommonWidgets.SizeBox8,
                    ],
                  ),
                ),
              ),

              // Empty state
              if (controller.journaldata.isEmpty && !controller.isLoading.value)
                SliverFillRemaining(
                  child: Center(
                    child: Text(
                      'អត់ទាន់មានទិន្ន័យ',
                      style: TextStyles.siemreap(context, fontSize: 16),
                    ),
                  ),
                ),

              // DataTable for journal entries
              if (controller.journaldata.isNotEmpty)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 8 : 22,
                      vertical: isMobile ? 8 : 14,
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        width: isMobile
                            ? 1200
                            : MediaQuery.of(context).size.width - 24,
                        decoration: BoxDecoration(
                          color: TheColors.bgColor,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: DataTable(
                          headingRowColor: MaterialStateProperty.all(
                              TheColors.checked.withOpacity(0.3)),
                          columnSpacing: 16,
                          horizontalMargin: 12,
                          dividerThickness: 0.5,
                          dataRowHeight: 50,
                          headingRowHeight: 40,
                          sortColumnIndex: _sortColumnIndex,
                          sortAscending: _sortAscending,
                          columns: [
                            DataColumn(
                              label: Text(
                                'ល.រ',
                                style: TextStyles.siemreap(
                                  context,
                                  fontSize: 14,
                                  fontweight: FontWeight.bold,
                                  color: TheColors.white,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'កាលបរិច្ឆេទ',
                                style: TextStyles.siemreap(
                                  context,
                                  fontSize: 14,
                                  fontweight: FontWeight.bold,
                                  color: TheColors.white,
                                ),
                              ),
                              onSort: (columnIndex, ascending) {
                                setState(() {
                                  _sortColumnIndex = columnIndex;
                                  _sortAscending = ascending;
                                  // You can implement sorting logic here
                                });
                              },
                            ),
                            DataColumn(
                              label: Text(
                                'កូដគណនី',
                                style: TextStyles.siemreap(
                                  context,
                                  fontSize: 14,
                                  fontweight: FontWeight.bold,
                                  color: TheColors.white,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'ឈ្មោះគណនី',
                                style: TextStyles.siemreap(
                                  context,
                                  fontSize: 14,
                                  fontweight: FontWeight.bold,
                                  color: TheColors.white,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'ចំនួនលុយ(ចូល)',
                                style: TextStyles.siemreap(
                                  context,
                                  fontSize: 14,
                                  fontweight: FontWeight.bold,
                                  color: TheColors.white,
                                ),
                              ),
                              numeric: true,
                            ),
                            DataColumn(
                              label: Text(
                                'ចំនួនលុយ(ចេញ)',
                                style: TextStyles.siemreap(
                                  context,
                                  fontSize: 14,
                                  fontweight: FontWeight.bold,
                                  color: TheColors.white,
                                ),
                              ),
                              numeric: true,
                            ),
                            DataColumn(
                              label: Text(
                                'បរិយាយ',
                                style: TextStyles.siemreap(
                                  context,
                                  fontSize: 14,
                                  fontweight: FontWeight.bold,
                                  color: TheColors.white,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'កូដយោង',
                                style: TextStyles.siemreap(
                                  context,
                                  fontSize: 14,
                                  color: TheColors.white,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'បង្កើតដោយ',
                                style: TextStyles.siemreap(
                                  context,
                                  fontSize: 14,
                                  fontweight: FontWeight.bold,
                                  color: TheColors.white,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'សកម្មភាព',
                                style: TextStyles.siemreap(
                                  context,
                                  fontSize: 14,
                                  fontweight: FontWeight.bold,
                                  color: TheColors.white,
                                ),
                              ),
                            ),
                          ],
                          rows: controller.journaldata
                              .asMap()
                              .entries
                              .map((entry) {
                            final index = entry.key;
                            final journal = entry.value;

                            return DataRow(
                              cells: [
                                DataCell(
                                  Text(
                                    '${index + 1}',
                                    style: TextStyles.siemreap(
                                      context,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    _formatDate(journal.transactionDate),
                                    style: TextStyles.siemreap(
                                      context,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    journal.chartAccountCode ?? '-',
                                    style: TextStyles.siemreap(
                                      context,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    journal.chartAccountName ?? '-',
                                    style: TextStyles.siemreap(
                                      context,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    "${journal.debitAmount} ៛",
                                    style: TextStyles.siemreap(
                                      context,
                                      fontSize: 16,
                                      fontweight: FontWeight.bold,
                                      color: TheColors.successColor,
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    "${journal.creditAmount} ៛",
                                    style: TextStyles.siemreap(
                                      context,
                                      fontSize: 16,
                                      fontweight: FontWeight.bold,
                                      color: TheColors.red,
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Container(
                                    constraints: BoxConstraints(maxWidth: 200),
                                    child: Text(
                                      journal.description ?? '-',
                                      style: TextStyles.siemreap(
                                        context,
                                        fontSize: 13,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                DataCell(
                                  SelectableText(
                                    journal.referenceCode ?? '-',
                                    style: TextStyles.siemreap(
                                      context,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    journal.createdByName ?? '-',
                                    style: TextStyles.siemreap(
                                      context,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                                DataCell(Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Get.to(
                                            () => Updatejournalview(
                                                journal: journal),
                                            binding: Updatejournalbinding(),
                                            transition: Transition.rightToLeft);
                                      },
                                      child: Icon(
                                        Icons.edit_outlined,
                                        color: TheColors.warningColor,
                                      ),
                                    ),
                                    CommonWidgets.SizeBoxwidh5,
                                    InkWell(
                                      onTap: () {
                                        Get.defaultDialog(
                                          title: "លុបប្រតិបត្តិការណ៍",
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
                                                  const SizedBox(height: 10),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: OutlinedButton(
                                                          onPressed: () {
                                                            Get.to(
                                                                () => Updatejournalview(
                                                                    journal:
                                                                        journal),
                                                                binding:
                                                                    Updatejournalbinding(),
                                                                transition:
                                                                    Transition
                                                                        .rightToLeft);
                                                          },
                                                          style: OutlinedButton
                                                              .styleFrom(
                                                            side: const BorderSide(
                                                                color: TheColors
                                                                    .red),
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                          ),
                                                          child: Text("កែប្រែ",
                                                              style: TextStyles
                                                                  .siemreap(
                                                                      context,
                                                                      fontSize:
                                                                          15,
                                                                      color: TheColors
                                                                          .white)),
                                                        ),
                                                      ),
                                                      const SizedBox(width: 12),
                                                      Expanded(
                                                          child: ElevatedButton(
                                                        onPressed: () async {
                                                          await controller
                                                              .deletejournal(
                                                                  id: journal
                                                                      .id!);
                                                          Get.back();
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
                                                        child: Text(
                                                          "លុប",
                                                          style: TextStyles
                                                              .siemreap(
                                                            context,
                                                            fontSize: 16,
                                                            color:
                                                                TheColors.white,
                                                          ),
                                                        ),
                                                      )),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      child: Icon(
                                        Icons.delete,
                                        color: TheColors.red,
                                      ),
                                    )
                                  ],
                                )),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ),

              // Loading more indicator
              if (controller.isLoadingMore.value)
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: CustomLoading(),
                    ),
                  ),
                ),
            ],
          );
        }),
      ),
    );
  }
}
