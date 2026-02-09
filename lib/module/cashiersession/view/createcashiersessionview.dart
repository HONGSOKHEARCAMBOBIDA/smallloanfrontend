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
    final double smallFontSize = isMobile ? 12 : 15;
    return Scaffold(
      backgroundColor: TheColors.bgColor,
      appBar: const CustomAppBar(title: "បេីកប្រអប់ទទួលលុយ"),
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
                          return CashierSessionCard(
                            session: data,
                            onTap: () {
                              Get.defaultDialog(
                                titlePadding: const EdgeInsets.only(
                                    top: 20, left: 8, right: 8, bottom: 8),
                                title: "ផ្ទៀងផ្ទាត់ប្រាក់",
                                titleStyle: TextStyles.moul(context,
                                    fontSize: smallFontSize,
                                    color: TheColors.warningColor),
                                backgroundColor: TheColors.bgColor, // important
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
                                          "តើត្រឹមត្រូវហេីយមែនទេ?",
                                          style: TextStyles.siemreap(context),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: 20),
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
                                                child: Text("ពិនិត្យម្ដងទៀត",
                                                    style: TextStyles.siemreap(
                                                        context,
                                                        fontSize: smallFontSize,
                                                        color:
                                                            TheColors.white)),
                                              ),
                                            ),
                                            const SizedBox(width: 12),
                                            Expanded(
                                              child: Obx(() {
                                                return ElevatedButton(
                                                  onPressed: controller
                                                          .isLoading.value
                                                      ? null
                                                      : () {
                                                          controller
                                                              .verify(data.id!);
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
                                                          "ផ្ទៀងផ្ទាត់",
                                                          style: TextStyles
                                                              .siemreap(
                                                            context,
                                                            fontSize:
                                                                smallFontSize,
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
                            },
                          );
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
