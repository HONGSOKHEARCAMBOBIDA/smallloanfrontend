import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loanfrontend/core/theme/app_color.dart';
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
    final double iconerr = isMobile ? 30 : (isTablet ? 34 : 50);
    final int gridCount = isDesktop ? 3 : (isTablet ? 2 : 1);
    final double refreshIconSize = isMobile ? 30 : (isTablet ? 34 : 38);
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
                           padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Loancard(loan: loan, onTap: () {}),
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
                          child: Loancard(loan: loan, onTap: () {}),
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
