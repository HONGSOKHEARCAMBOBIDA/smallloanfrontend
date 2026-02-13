import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:confetti/confetti.dart'; // Add this import
import 'package:loanfrontend/core/helper/show_loan_buttonsheet.dart';
import 'package:loanfrontend/core/theme/app_color.dart';
import 'package:loanfrontend/core/theme/text_styles.dart';
import 'package:loanfrontend/module/loan/controller/loancontroller.dart';
import 'package:loanfrontend/module/reciept/controller/recieptcontroller.dart';
import 'package:loanfrontend/share/widgets/app_bar.dart';
import 'package:loanfrontend/share/widgets/common_widgets.dart';
import 'package:loanfrontend/share/widgets/loading.dart';
import 'package:loanfrontend/share/widgets/loanlistcard.dart';
import 'package:loanfrontend/share/widgets/textfield.dart';
import 'package:responsive_framework/responsive_framework.dart';

class Loanview extends StatefulWidget {
  const Loanview({super.key});

  @override
  State<Loanview> createState() => _LoanviewState();
}

class _LoanviewState extends State<Loanview> {
  final loancontroller = Get.find<LoanController>();
  final recieptController = Get.put(Recieptcontroller());
  final TextEditingController searchQuery = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    loancontroller.getloan();
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    searchQuery.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        loancontroller.hasMore.value &&
        !loancontroller.isLoadingMore.value &&
        !loancontroller.isLoading.value) {
      _loadMore();
    }
  }

  Future<void> _loadMore() async {
    await loancontroller.loadMore();
  }

  Future<void> refresh() async {
    searchQuery.clear();
    loancontroller.searchQuery.value = '';
    await loancontroller.getloan(isRefresh: true);
  }

  @override
  Widget build(BuildContext context) {
    final breakpoint = ResponsiveBreakpoints.of(context);
    final bool isMobile = breakpoint.isMobile;
    final bool isTablet = breakpoint.isTablet;
    final bool isDesktop = breakpoint.isDesktop;
    final double searchHeight = isMobile ? 50 : (isTablet ? 56 : 64);
    final double refreshIconSize = isMobile ? 30 : (isTablet ? 34 : 38);
    final int gridCount = isDesktop ? 3 : (isTablet ? 2 : 1);
    final EdgeInsetsGeometry pagePadding =
        EdgeInsets.symmetric(horizontal: isMobile ? 8 : 20, vertical: 8);

    return Scaffold(
      backgroundColor: TheColors.bgColor,
      appBar: const CustomAppBar(title: "បញ្ជីកម្ចី"),
      body: Stack(
        // Wrap with Stack to overlay confetti
        children: [
          RefreshIndicator(
            backgroundColor: TheColors.cutecolo,
            color: TheColors.warningColor,
            onRefresh: refresh,
            child: Obx(() {
              if (loancontroller.isLoading.value &&
                  loancontroller.loan.isEmpty) {
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
                                        child: SizedBox(
                                          height: searchHeight,
                                          child: CustomTextField(
                                            controller: searchQuery,
                                            hintText: "ស្វែងរក".tr,
                                            prefixIcon: Icons.search,
                                            onChanged: (value) {
                                              loancontroller.searchQuery.value =
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
                                              loancontroller.searchQuery.value =
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
                  if (loancontroller.loan.isEmpty &&
                      !loancontroller.isLoading.value)
                    SliverFillRemaining(
                      child: Center(
                        child: Text(
                          'អត់ទាន់មានទិន្ន័យ',
                          style: TextStyles.kantomruy(context, fontSize: 12),
                        ),
                      ),
                    ),

                  // List or Grid of clients
                  if (loancontroller.loan.isNotEmpty)
                    if (gridCount == 1)
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final loan = loancontroller.loan[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 2),
                              child: Loanlistcard(
                                  loan: loan,
                                  onTap: () {
                                    showLoanButtonsheet(
                                        context: context, loan: loan);
                                  }),
                            );
                          },
                          childCount: loancontroller.loan.length,
                        ),
                      )
                    else
                      SliverPadding(
                        padding: pagePadding,
                        sliver: SliverGrid(
                          delegate:
                              SliverChildBuilderDelegate((context, index) {
                            final loan = loancontroller.loan[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8,
                              ),
                              child: Loanlistcard(
                                  loan: loan,
                                  onTap: () {
                                    if (!Get.isRegistered<
                                        Recieptcontroller>()) {
                                      Get.put(Recieptcontroller());
                                    }

                                    showLoanButtonsheet(
                                      context: context,
                                      loan: loan,
                                    );
                                  }),
                            );
                          }, childCount: loancontroller.loan.length),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: gridCount,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                            childAspectRatio: isDesktop ? 2.57 : 1.8,
                          ),
                        ),
                      ),

                  // Loading more indicator
                  if (loancontroller.isLoadingMore.value)
                    const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Center(
                          child: CustomLoading(),
                        ),
                      ),
                    ),
                ],
              );
            }),
          ),

          // Confetti Widget overlay
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: recieptController
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
