import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loanfrontend/core/theme/app_color.dart';
import 'package:loanfrontend/core/theme/text_styles.dart';
import 'package:loanfrontend/module/cashiersession/controller/cashiersessioncontroller.dart';
import 'package:loanfrontend/share/widgets/app_bar.dart';
import 'package:loanfrontend/share/widgets/cashiersessioncard.dart';
import 'package:loanfrontend/share/widgets/custombuttonnav.dart';
import 'package:confetti/confetti.dart';
import 'package:loanfrontend/share/widgets/loading.dart';
import 'package:responsive_framework/responsive_framework.dart';

class Createcashiersessionview extends StatefulWidget {
  const Createcashiersessionview({super.key});

  @override
  State<Createcashiersessionview> createState() =>
      _CreatecashiersessionviewState();
}

class _CreatecashiersessionviewState extends State<Createcashiersessionview> {
  final Cashiersessioncontroller controller =
      Get.find<Cashiersessioncontroller>();

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final breakpoint = ResponsiveBreakpoints.of(context);
    final bool isMobile = breakpoint.isMobile;
    final double padding = isMobile ? 8 : 200;
    return Scaffold(
      backgroundColor: TheColors.bgColor,
      appBar: CustomAppBar(title: "បេីកប្រអប់ទទួលលុយ"),
      body: Padding(
        padding: EdgeInsets.only(
            left: isMobile ? 8 : 600,
            right: isMobile ? 8 : 600,
            top: isMobile ? 8 : 100),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            /// MAIN CONTENT
            Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CustomLoading());
              }
              return CustomScrollView(
                controller: _scrollController,
                slivers: [
                  /// EMPTY STATE
                  if (controller.session.isEmpty)
                    SliverFillRemaining(
                      child: Center(
                        child: Text(
                          'អត់ទាន់មានទិន្ន័យ',
                          style: TextStyles.kantomruy(context, fontSize: 12),
                        ),
                      ),
                    ),

                  /// SESSION LIST
                  if (controller.session.isNotEmpty)
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final data = controller.session[index];
                          return CashierSessionCard(session: data);
                        },
                        childCount: controller.session.length,
                      ),
                    ),
                ],
              );
            }),

            /// 🎉 CONFETTI OVERLAY
            ConfettiWidget(
              confettiController: controller.confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              emissionFrequency: 0.05,
              numberOfParticles: 20,
              gravity: 0.25,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
            left: isMobile ? 8 : 600,
            right: isMobile ? 8 : 600,
            top: isMobile ? 8 : 100),
        child: CustomBottomNav(
          title: "បេីកប្រអប់",
          onTap: () async {
            controller.createcashiersession();
          },
        ),
      ),
    );
  }
}
