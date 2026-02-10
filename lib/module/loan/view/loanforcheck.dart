import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loanfrontend/core/theme/app_color.dart';
import 'package:loanfrontend/core/theme/text_styles.dart';
import 'package:loanfrontend/module/loan/controller/loancontroller.dart';
import 'package:loanfrontend/share/widgets/app_bar.dart';
import 'package:loanfrontend/share/widgets/loading.dart';
import 'package:loanfrontend/share/widgets/loancard.dart';
import 'package:responsive_framework/responsive_framework.dart';

class Loanforcheck extends StatefulWidget {
  const Loanforcheck({super.key});

  @override
  State<Loanforcheck> createState() => _LoanforcheckState();
}

class _LoanforcheckState extends State<Loanforcheck> {
  final loancontroller = Get.find<LoanController>();
  final ScrollController scrollController = ScrollController();

  Future<void> refresh() async {
    loancontroller.loanforcheck.clear();
    await loancontroller.getloanforcheck();
  }

  @override
  void initState() {
    loancontroller.getloanforcheck();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final breakpoint = ResponsiveBreakpoints.of(context);
    final bool isMobile = breakpoint.isMobile;
    final bool isTablet = breakpoint.isTablet;
    final bool isDesktop = breakpoint.isDesktop;
    final int gridCount = isDesktop ? 3 : (isTablet ? 2 : 1);
    final double smallFontSize = isMobile ? 12 : 15;
    final EdgeInsetsGeometry pagePadding =
        EdgeInsets.symmetric(horizontal: isMobile ? 8 : 20, vertical: 8);
    return Scaffold(
      backgroundColor: TheColors.bgColor,
      appBar: const CustomAppBar(title: "បញ្ជីកម្ចីត្រូវពិនិត្យ"),
      body: RefreshIndicator(
        backgroundColor: TheColors.cutecolo,
        color: TheColors.warningColor,
        onRefresh: refresh,
        child: Obx(() {
          if (loancontroller.isLoading.value) {
            return const Center(child: CustomLoading());
          }

          return CustomScrollView(
            controller: scrollController,
            slivers: [
              if (loancontroller.loanforcheck.isNotEmpty)
                if (gridCount == 1)
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final loan = loancontroller.loanforcheck[index];
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Loancard(
                              loan: loan,
                              onTap: () {
                                Get.defaultDialog(
                                  titlePadding: const EdgeInsets.only(top: 20),
                                  title: "ត្រួតពិនិត្យកម្ចី",
                                  titleStyle: TextStyles.moul(context,
                                      fontSize: smallFontSize,
                                      color: TheColors.warningColor),
                                  backgroundColor:
                                      TheColors.bgColor, // important
                                  content: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: TheColors.bgColor,
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(
                                          color: TheColors.checked,
                                          width: 0.5,
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
                                            "តើអ្នកចង់ត្រួតពិនិត្យកម្ចី ${loan.clientName} មែនទេ?",
                                            style: TextStyles.siemreap(context),
                                            textAlign: TextAlign.center,
                                          ),
                                          const SizedBox(height: 20),
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
                                                              fontSize:
                                                                  smallFontSize,
                                                              color: TheColors
                                                                  .white)),
                                                ),
                                              ),
                                              const SizedBox(width: 12),
                                              Expanded(
                                                child: Obx(() {
                                                  return ElevatedButton(
                                                    onPressed: loancontroller
                                                            .isLoading.value
                                                        ? null
                                                        : () {
                                                            loancontroller
                                                                .checkloan(
                                                                    loan.id);
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
                                                    child: loancontroller
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
                                                            "ត្រួតពិនិត្យ",
                                                            style: TextStyles
                                                                .siemreap(
                                                              context,
                                                              fontSize:
                                                                  smallFontSize,
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
                              }),
                        );
                      },
                      childCount: loancontroller.loanforcheck.length,
                    ),
                  )
                else
                  SliverPadding(
                    padding: pagePadding,
                    sliver: SliverGrid(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final loan = loancontroller.loanforcheck[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Loancard(
                              loan: loan,
                              onTap: () {
                                Get.defaultDialog(
                                  titlePadding: const EdgeInsets.only(top: 20),
                                  title: "ត្រួតពិនិត្យកម្ចី",
                                  titleStyle: TextStyles.moul(context,
                                      fontSize: smallFontSize,
                                      color: TheColors.warningColor),
                                  backgroundColor:
                                      TheColors.bgColor, // important
                                  content: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: TheColors.bgColor,
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(
                                          color: TheColors.checked,
                                          width: 0.5,
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
                                            "តើអ្នកចង់ត្រួតពិនិត្យកម្ចី ${loan.clientName} មែនទេ?",
                                            style: TextStyles.siemreap(context),
                                            textAlign: TextAlign.center,
                                          ),
                                          const SizedBox(height: 20),
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
                                                              fontSize:
                                                                  smallFontSize,
                                                              color: TheColors
                                                                  .white)),
                                                ),
                                              ),
                                              const SizedBox(width: 12),
                                              Expanded(
                                                child: Obx(() {
                                                  return ElevatedButton(
                                                    onPressed: loancontroller
                                                            .isLoading.value
                                                        ? null
                                                        : () {
                                                            loancontroller
                                                                .checkloan(
                                                                    loan.id);
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
                                                    child: loancontroller
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
                                                            "ត្រួតពិនិត្យ",
                                                            style: TextStyles
                                                                .siemreap(
                                                              context,
                                                              fontSize:
                                                                  smallFontSize,
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
                              }),
                        );
                      }, childCount: loancontroller.loanforcheck.length),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: gridCount,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        childAspectRatio: isDesktop ? 1.8 : 1.8,
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
