import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loanfrontend/module/reciept/controller/recieptcontroller.dart';
import 'package:loanfrontend/share/widgets/recieptcard.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:loanfrontend/core/theme/app_color.dart';
import 'package:loanfrontend/core/theme/text_styles.dart';
import 'package:loanfrontend/share/widgets/app_bar.dart';
import 'package:loanfrontend/share/widgets/common_widgets.dart';
import 'package:loanfrontend/share/widgets/loading.dart';
import 'package:loanfrontend/share/widgets/textfield.dart';
import 'package:confetti/confetti.dart'; // Add this import

class Recieptview extends StatefulWidget {
  const Recieptview({super.key});

  @override
  State<Recieptview> createState() => _RecieptviewState();
}

class _RecieptviewState extends State<Recieptview> {
  final controller = Get.find<Recieptcontroller>();
  final TextEditingController searchQuery = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final TextEditingController totalcontroller = TextEditingController();
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    totalcontroller.dispose();
    _scrollController.dispose();
    searchQuery.dispose();
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
    searchQuery.clear();
    controller.searchQuery.value = '';
    await controller.getreciept(isRefresh: true);
  }

  @override
  Widget build(BuildContext context) {
    final breakpoints = ResponsiveBreakpoints.of(context);
    final bool isMobile = breakpoints.isMobile;
    final bool isTablet = breakpoints.isTablet;
    final bool isDesktop = breakpoints.isDesktop;

    // grid columns: mobile = 1, tablet = 2, desktop = 3
    final int gridCount = isDesktop ? 4 : (isTablet ? 2 : 1);

    final double searchHeight = isMobile ? 50 : (isTablet ? 56 : 64);
    final double refreshIconSize = isMobile ? 30 : (isTablet ? 34 : 38);
    final EdgeInsetsGeometry pagePadding =
        EdgeInsets.symmetric(horizontal: isMobile ? 8 : 12, vertical: 8);

    return Scaffold(
      backgroundColor: TheColors.bgColor,
      appBar: const CustomAppBar(title: "បញ្ជីកម្ចីត្រូវប្រមូល"),
      body: Stack(
        children: [
          RefreshIndicator(
            backgroundColor: TheColors.cutecolo,
            color: TheColors.warningColor,
            onRefresh: refresh,
            child: Obx(() {
              if(controller.isLoading.value ){
                return Center(child: CustomLoading());
              }
              final filteredReciepts = controller.reciept
                  .where((e) => (e.totalCollect ?? 0) > 0)
                  .toList();

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
                                        child: SizedBox(
                                          height: searchHeight,
                                          child: CustomTextField(
                                            controller: searchQuery,
                                            hintText: "ស្វែងរក".tr,
                                            prefixIcon: Icons.search,
                                            onChanged: (value) {
                                              controller.searchQuery.value =
                                                  value;
                                            },
                                          ),
                                        ),
                                      )
                                    : Padding(
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
                                              controller.searchQuery.value =
                                                  value;
                                            },
                                          ),
                                        ),
                                      ),
                                CommonWidgets.SizeBoxwidh5,
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 8, bottom: isMobile ? 0.0 : 10),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: TheColors.cutecolo,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: InkWell(
                                        onTap: () {
                                          refresh();
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
                          CommonWidgets.SizeBox8,
                        ],
                      ),
                    ),
                  ),

                  // Empty state
                  if (controller.reciept.isEmpty && !controller.isLoading.value)
                    SliverFillRemaining(
                      child: Center(
                        child: Text(
                          'អត់ទាន់មានទិន្ន័យ',
                          style: TextStyles.kantomruy(context, fontSize: 12),
                        ),
                      ),
                    ),

                  // List or Grid of clients
                  if (controller.reciept.isNotEmpty)
                    if (gridCount == 1)
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final reciept = filteredReciepts[index];

                            return Padding(
                                padding: const EdgeInsets.only(
                                    right: 10, left: 10, bottom: 8),
                                child: Recieptcard(
                                    reciept: reciept,
                                    ontap: () {
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
                                                  "អតិថិជ​ន :${reciept.clientName}",
                                                  style: TextStyles.siemreap(
                                                      context),
                                                  textAlign: TextAlign.center,
                                                ),
                                                const SizedBox(height: 10),
                                                CustomTextField(
                                                    controller: totalcontroller,
                                                    hintText: "បញ្ចូលប្រាក់"),
                                                const SizedBox(height: 20),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: OutlinedButton(
                                                        onPressed: () =>
                                                            Get.back(),
                                                        style: OutlinedButton
                                                            .styleFrom(
                                                          side:
                                                              const BorderSide(
                                                                  color:
                                                                      TheColors
                                                                          .red),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                        ),
                                                        child: Text("ចាកចេញ",
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
                                                      child: Obx(() {
                                                        return ElevatedButton(
                                                          onPressed:
                                                              controller
                                                                      .isLoading
                                                                      .value
                                                                  ? null
                                                                  : () async {
                                                                      final total =
                                                                          int.tryParse(
                                                                              totalcontroller.text);
                                                                      await controller.createreciept(
                                                                          id: reciept
                                                                              .id!,
                                                                          total:
                                                                              total!);
                                                                            totalcontroller.clear();
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
                                                                  .isLoading
                                                                  .value
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
                                                                  "បង់ប្រាក់",
                                                                  style: TextStyles
                                                                      .siemreap(
                                                                    context,
                                                                    fontSize:
                                                                        16,
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
                          },
                          childCount: filteredReciepts.length,
                        ),
                      )
                    else
                      SliverPadding(
                        padding: pagePadding,
                        sliver: SliverGrid(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final reciept = filteredReciepts[index];

                              return Recieptcard(
                                  reciept: reciept,
                                  ontap: () {
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
                                                "អតិថិជ​ន :${reciept.clientName}",
                                                style: TextStyles.siemreap(
                                                    context),
                                                textAlign: TextAlign.center,
                                              ),
                                              const SizedBox(height: 10),
                                              CustomTextField(
                                                  controller: totalcontroller,
                                                  hintText: "បញ្ចូលប្រាក់"),
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
                                                                  fontSize: 15,
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
                                                                    final total =
                                                                        int.tryParse(
                                                                            totalcontroller.text);
                                                                    await controller.createreciept(
                                                                        id: reciept
                                                                            .id!,
                                                                        total:
                                                                            total!);
                                                                        totalcontroller.clear();
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
                                                                "បង់ប្រាក់",
                                                                style: TextStyles
                                                                    .siemreap(
                                                                  context,
                                                                  fontSize: 16,
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
                                  });
                            },
                            childCount: filteredReciepts.length,
                          ),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: gridCount,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                            childAspectRatio: isDesktop ? 1.15 : 2.6,
                          ),
                        ),
                      ),

                  // Loading more indicator
                  if (controller.isLoadingMore.value)
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
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: controller
                  .confettiController, // Use controller from Recieptcontroller
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              emissionFrequency: 0.1,
              numberOfParticles: 40,
              gravity: 0.25,
            ),
          ),
        ],
      ),
    );
  }
}
