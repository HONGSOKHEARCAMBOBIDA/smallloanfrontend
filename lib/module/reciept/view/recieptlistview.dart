import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loanfrontend/core/helper/show_user_buttonsheet.dart';
import 'package:loanfrontend/module/auth/controller/authcontroller.dart';
import 'package:loanfrontend/module/reciept/controller/recieptcontroller.dart';
import 'package:loanfrontend/share/widgets/customoutlinebutton.dart';
import 'package:loanfrontend/share/widgets/datepicker.dart';
import 'package:loanfrontend/share/widgets/recieptlistcard.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:loanfrontend/core/theme/app_color.dart';
import 'package:loanfrontend/core/theme/text_styles.dart';
import 'package:loanfrontend/share/widgets/app_bar.dart';
import 'package:loanfrontend/share/widgets/common_widgets.dart';
import 'package:loanfrontend/share/widgets/loading.dart';
import 'package:loanfrontend/share/widgets/textfield.dart'; // Add this import

class Recieptlistview extends StatefulWidget {
  const Recieptlistview({super.key});

  @override
  State<Recieptlistview> createState() => _RecieptlistviewState();
}

class _RecieptlistviewState extends State<Recieptlistview> {
  final controller = Get.find<Recieptcontroller>();
  final usercontroller = Get.find<AuthController>();
  final TextEditingController searchQuery = TextEditingController();
  final selectstartdate = Rxn<DateTime>();

  final selectenddate = Rxn<DateTime>();
  final selectcoid = Rxn<int>();
  final ScrollController _scrollController = ScrollController();
  var start = ''.obs;
  @override
  void initState() {
    final now = DateTime.now();
    start.value =
        '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
    usercontroller.getuser();
    controller.getrecieptlist(isRefresh: true, start: start.value);
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
        controller.hasMoreList.value && // Fixed: use hasMoreList
        !controller.isLoadingMoreList.value && // Fixed: use isLoadingMoreList
        !controller.isLoadingList.value) {
      _loadMore();
    }
  }

  Future<void> _loadMore() async {
    await controller.loadMorelist(
      client_name: searchQuery.text.isEmpty ? null : searchQuery.text,
      co_id: selectcoid.value,
      start: selectstartdate.value?.toIso8601String(),
      end: selectenddate.value?.toIso8601String(),
    );
  }

  Future<void> refresh() async {
    selectcoid.value = null;
    selectstartdate.value = null;
    selectenddate.value = null;
    searchQuery.clear();
    controller.recieptlist.clear();
    await controller.getrecieptlist(isRefresh: true);
  }

  @override
  Widget build(BuildContext context) {
    final breakpoints = ResponsiveBreakpoints.of(context);
    final bool isMobile = breakpoints.isMobile;
    final bool isTablet = breakpoints.isTablet;
    final bool isDesktop = breakpoints.isDesktop;
    final int gridCount = isDesktop ? 4 : (isTablet ? 2 : 1);
    final double searchHeight = isMobile ? 50 : (isTablet ? 66 : 64);
    final double refreshIconSize = isMobile ? 30 : (isTablet ? 34 : 38);
    final EdgeInsetsGeometry pagePadding =
        EdgeInsets.symmetric(horizontal: isMobile ? 8 : 12, vertical: 8);
    final selectcoName = 'មន្ត្រីឥណទាន'.obs;
    return Scaffold(
      backgroundColor: TheColors.bgColor,
      appBar: const CustomAppBar(title: "លុបការប្រមូល"),
      body: RefreshIndicator(
        backgroundColor: TheColors.cutecolo,
        color: TheColors.warningColor,
        onRefresh: refresh,
        child: Obx(() {
          if (controller.isLoadingList.value) {
            return const Center(child: CustomLoading());
          }
          return CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: pagePadding,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: 8, right: 8, top: isMobile ? 0 : 30),
                        child: Row(
                          children: [
                            isMobile
                                ? Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: SizedBox(
                                                  height: searchHeight,
                                                  child: CustomTextField(
                                                    controller: searchQuery,
                                                    hintText: "ស្វែងរក".tr,
                                                    prefixIcon: Icons.search,
                                                    onChanged: (value) {
                                                      // Your existing code
                                                      Future.delayed(
                                                          const Duration(
                                                              milliseconds:
                                                                  200),
                                                          () async {
                                                        await controller
                                                            .getrecieptlist(
                                                          client_name:
                                                              value.isEmpty
                                                                  ? null
                                                                  : value,
                                                          co_id:
                                                              selectcoid.value,
                                                          start: selectstartdate
                                                              .value
                                                              ?.toIso8601String(),
                                                          end: selectenddate
                                                              .value
                                                              ?.toIso8601String(),
                                                          isRefresh: true,
                                                        );
                                                      });
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 7,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: CustomDatePickerField(
                                                  label: "",
                                                  selectedDate: selectstartdate,
                                                  onDateSelected: (date) async {
                                                    selectstartdate.value =
                                                        date;
                                                    await controller
                                                        .getrecieptlist(
                                                      client_name: searchQuery
                                                              .text.isEmpty
                                                          ? null
                                                          : searchQuery.text,
                                                      co_id: selectcoid.value,
                                                      start: date
                                                          ?.toIso8601String(),
                                                      end: selectenddate.value
                                                          ?.toIso8601String(),
                                                      isRefresh: true,
                                                    );
                                                  },
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Expanded(
                                                child: CustomDatePickerField(
                                                  label: "",
                                                  selectedDate:
                                                      selectenddate, // Fixed: use selectenddate
                                                  onDateSelected: (date) async {
                                                    selectenddate.value = date;
                                                    await controller
                                                        .getrecieptlist(
                                                      client_name: searchQuery
                                                              .text.isEmpty
                                                          ? null
                                                          : searchQuery.text,
                                                      co_id: selectcoid.value,
                                                      start: selectstartdate
                                                          .value
                                                          ?.toIso8601String(),
                                                      end: date
                                                          ?.toIso8601String(),
                                                      isRefresh: true,
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 7,
                                          ),
                                          Obx(
                                            () => Column(
                                              children: [
                                                CustomOutlinedButton(
                                                  text: selectcoName.value,
                                                  onPressed: () {
                                                    showUserSelectorsheet(
                                                      context: context,
                                                      user: usercontroller.user,
                                                      selecteduserId:
                                                          selectcoid.value,
                                                      onSelected: (id) async {
                                                        selectcoid.value = id;

                                                        await controller
                                                            .getrecieptlist(
                                                          client_name:
                                                              searchQuery.text
                                                                      .isEmpty
                                                                  ? null
                                                                  : searchQuery
                                                                      .text,
                                                          co_id: id,
                                                          start: selectstartdate
                                                              .value
                                                              ?.toIso8601String(),
                                                          end: selectenddate
                                                              .value
                                                              ?.toIso8601String(),
                                                          isRefresh: true,
                                                        );
                                                        // Add null safety check
                                                        final selectedUser =
                                                            usercontroller.user
                                                                .firstWhereOrNull(
                                                                    (p) =>
                                                                        p.id ==
                                                                        id);
                                                        if (selectedUser !=
                                                                null &&
                                                            selectedUser.name !=
                                                                null) {
                                                          selectcoName.value =
                                                              selectedUser
                                                                  .name!;
                                                        } else {
                                                          selectcoName.value =
                                                              '';
                                                        }
                                                      },
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: SizedBox(
                                            width: 500,
                                            height: searchHeight,
                                            child: CustomTextField(
                                              controller: searchQuery,
                                              hintText: "ស្វែងរក".tr,
                                              prefixIcon: Icons.search,
                                              onChanged: (value) {
                                                // Don't call API directly here, update and let controller handle it
                                                Future.delayed(
                                                    const Duration(
                                                        milliseconds: 200),
                                                    () async {
                                                  await controller
                                                      .getrecieptlist(
                                                    client_name: value.isEmpty
                                                        ? null
                                                        : value,
                                                    co_id: selectcoid.value,
                                                    start: selectstartdate.value
                                                        ?.toIso8601String(),
                                                    end: selectenddate.value
                                                        ?.toIso8601String(),
                                                    isRefresh: true,
                                                  );
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 4,
                                              right: 4,
                                              top: 2,
                                              bottom: 2),
                                          child: CustomDatePickerField(
                                            label: "ថ្ងៃថចាប់ផ្ដេីម",
                                            selectedDate: selectstartdate,
                                            onDateSelected: (date) async {
                                              selectstartdate.value = date;
                                              await controller.getrecieptlist(
                                                client_name:
                                                    searchQuery.text.isEmpty
                                                        ? null
                                                        : searchQuery.text,
                                                co_id: selectcoid.value,
                                                start: date?.toIso8601String(),
                                                end: selectenddate.value
                                                    ?.toIso8601String(),
                                                isRefresh: true,
                                              );
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 4,
                                              right: 4,
                                              top: 2,
                                              bottom: 2),
                                          child: CustomDatePickerField(
                                            label: "ថ្ងៃថចាប់បញ្ចប់",
                                            selectedDate:
                                                selectenddate, // Fixed: use selectenddate
                                            onDateSelected: (date) async {
                                              selectenddate.value = date;
                                              await controller.getrecieptlist(
                                                client_name:
                                                    searchQuery.text.isEmpty
                                                        ? null
                                                        : searchQuery.text,
                                                co_id: selectcoid.value,
                                                start: selectstartdate.value
                                                    ?.toIso8601String(),
                                                end: date?.toIso8601String(),
                                                isRefresh: true,
                                              );
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Obx(
                                          () => ConstrainedBox(
                                            constraints: BoxConstraints(
                                              maxWidth:
                                                  200, // Or use a fixed width
                                              minWidth: 120, // Minimum width
                                            ),
                                            child: Column(
                                              children: [
                                                CustomOutlinedButton(
                                                  text: selectcoName.value,
                                                  onPressed: () {
                                                    showUserSelectorsheet(
                                                      context: context,
                                                      user: usercontroller.user,
                                                      selecteduserId:
                                                          selectcoid.value,
                                                      onSelected: (id) async {
                                                        selectcoid.value = id;

                                                        await controller
                                                            .getrecieptlist(
                                                          client_name:
                                                              searchQuery.text
                                                                      .isEmpty
                                                                  ? null
                                                                  : searchQuery
                                                                      .text,
                                                          co_id: id,
                                                          start: selectstartdate
                                                              .value
                                                              ?.toIso8601String(),
                                                          end: selectenddate
                                                              .value
                                                              ?.toIso8601String(),
                                                          isRefresh: true,
                                                        );
                                                        // Add null safety check
                                                        final selectedUser =
                                                            usercontroller.user
                                                                .firstWhereOrNull(
                                                                    (p) =>
                                                                        p.id ==
                                                                        id);
                                                        if (selectedUser !=
                                                                null &&
                                                            selectedUser.name !=
                                                                null) {
                                                          selectcoName.value =
                                                              selectedUser
                                                                  .name!;
                                                        } else {
                                                          selectcoName.value =
                                                              '';
                                                        }
                                                      },
                                                    );
                                                  },
                                                ),
                                                const SizedBox(
                                                  height: 15,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        CommonWidgets.SizeBoxwidh5,
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 8,
                                              bottom: isMobile ? 0.0 : 10),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: TheColors.cutecolo,
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(3.0),
                                              child: InkWell(
                                                onTap: () {
                                                  refresh();
                                                  selectcoName.value =
                                                      "មន្ត្រីឥណទាន";
                                                },
                                                child: Icon(
                                                  Icons.refresh_outlined,
                                                  color: TheColors.white,
                                                  size: refreshIconSize,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
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
              if (controller.recieptlist.isEmpty &&
                  !controller.isLoadingList.value)
                SliverFillRemaining(
                  child: Center(
                    child: Text(
                      'អត់ទាន់មានទិន្ន័យ',
                      style: TextStyles.kantomruy(context, fontSize: 12),
                    ),
                  ),
                ),

              // List or Grid of clients
              if (controller.recieptlist.isNotEmpty)
                if (gridCount == 1)
                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final reciept = controller.recieptlist[index];

                      return Padding(
                          padding: const EdgeInsets.only(
                              right: 10, left: 10, bottom: 8),
                          child: Recieptlistcard(
                              reciept: reciept,
                              ontap: () {
                                Get.defaultDialog(
                                  titlePadding: const EdgeInsets.only(top: 20),
                                  title: "លុបការប្រមូលប្រាក់",
                                  titleStyle: TextStyles.moul(context,
                                      fontSize: 16,
                                      color: TheColors.warningColor),
                                  backgroundColor:
                                      TheColors.bgColor, // important
                                  content: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: TheColors.bgColor,
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(
                                          color: TheColors.gray,
                                          width: 1.2,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.15),
                                            blurRadius: 12,
                                            offset: const Offset(0, 6),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            "អតិថិជ​ន :${reciept.clientName} ទឹកប្រាក់ ${reciept.totalAmount}៛",
                                            style: TextStyles.siemreap(context),
                                            textAlign: TextAlign.center,
                                          ),
                                          const SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: OutlinedButton(
                                                  onPressed: () => Get.back(),
                                                  style:
                                                      OutlinedButton.styleFrom(
                                                    side: const BorderSide(
                                                        color: TheColors.red),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                  ),
                                                  child: Text("ចាកចេញ",
                                                      style:
                                                          TextStyles.siemreap(
                                                              context,
                                                              fontSize: 15,
                                                              color: TheColors
                                                                  .white)),
                                                ),
                                              ),
                                              const SizedBox(width: 12),
                                              Expanded(
                                                child: Obx(() {
                                                  return ElevatedButton(
                                                    onPressed: controller
                                                            .isLoading.value
                                                        ? null
                                                        : () async {
                                                            await controller
                                                                .delete(
                                                                    id: reciept
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
                                                                .circular(10),
                                                      ),
                                                    ),
                                                    child: controller
                                                            .isLoading.value
                                                        ? const SizedBox(
                                                            width: 20,
                                                            height: 20,
                                                            child:
                                                                CircularProgressIndicator(
                                                              strokeWidth: 2,
                                                              color: TheColors
                                                                  .cutecolo,
                                                            ),
                                                          )
                                                        : Text(
                                                            "លុប",
                                                            style: TextStyles
                                                                .siemreap(
                                                              context,
                                                              fontSize: 16,
                                                              color: TheColors
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
                              }));
                    }, childCount: controller.recieptlist.length),
                  )
                else
                  SliverPadding(
                    padding: pagePadding,
                    sliver: SliverGrid(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final reciept = controller.recieptlist[index];

                        return Recieptlistcard(
                            reciept: reciept,
                            ontap: () {
                              Get.defaultDialog(
                                titlePadding: EdgeInsets.all(10.0),
                                title: "លុបការប្រមូលប្រាក់",
                                titleStyle: TextStyles.moul(context,
                                    fontSize: 16,
                                    color: TheColors.warningColor),
                                backgroundColor: TheColors.bgColor, // important
                                content: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: TheColors.bgColor,
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                        color: TheColors.gray,
                                        width: 1.2,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.15),
                                          blurRadius: 12,
                                          offset: const Offset(0, 6),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "អតិថិជ​ន :${reciept.clientName} ទឹកប្រាក់ ${reciept.totalAmount}៛",
                                          style: TextStyles.siemreap(context),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: OutlinedButton(
                                                onPressed: () => Get.back(),
                                                style: OutlinedButton.styleFrom(
                                                  side: const BorderSide(
                                                      color: TheColors.red),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                ),
                                                child: Text("ចាកចេញ",
                                                    style: TextStyles.siemreap(
                                                        context,
                                                        fontSize: 15,
                                                        color:
                                                            TheColors.white)),
                                              ),
                                            ),
                                            const SizedBox(width: 12),
                                            Expanded(
                                              child: Obx(() {
                                                return ElevatedButton(
                                                  onPressed:
                                                      controller.isLoading.value
                                                          ? null
                                                          : () async {
                                                              await controller
                                                                  .delete(
                                                                      id: reciept
                                                                          .id!);
                                                              Get.back();
                                                            },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        TheColors.green,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
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
                                                            strokeWidth: 2,
                                                            color: TheColors
                                                                .cutecolo,
                                                          ),
                                                        )
                                                      : Text(
                                                          "លុបការបង់ប្រាក់",
                                                          style: TextStyles
                                                              .siemreap(
                                                            context,
                                                            fontSize: 16,
                                                            color:
                                                                TheColors.white,
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
                            });
                      }, childCount: controller.recieptlist.length),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: gridCount,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        childAspectRatio: isDesktop ? 1.15 : 2.6,
                      ),
                    ),
                  ),

              // Loading more indicator
              if (controller
                  .isLoadingMoreList.value) // Fixed: use isLoadingMoreList
                SliverToBoxAdapter(
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
