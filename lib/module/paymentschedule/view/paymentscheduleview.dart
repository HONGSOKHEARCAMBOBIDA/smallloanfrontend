import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loanfrontend/core/theme/app_color.dart';
import 'package:loanfrontend/core/theme/text_styles.dart';
import 'package:loanfrontend/module/paymentschedule/controller/paymentschedulecontroller.dart';
import 'package:loanfrontend/share/widgets/app_bar.dart';
import 'package:loanfrontend/share/widgets/loading.dart';
import 'package:loanfrontend/share/widgets/paymentcard.dart';
import 'package:loanfrontend/share/widgets/schedulecard.dart';
import 'package:responsive_framework/responsive_framework.dart';

class PaymentScheduleView extends StatefulWidget {
  final int loanId;

  const PaymentScheduleView({super.key, required this.loanId});

  @override
  State<PaymentScheduleView> createState() => _PaymentScheduleViewState();
}

class _PaymentScheduleViewState extends State<PaymentScheduleView> {
  final Paymentschedulecontroller controller =
      Get.put(Paymentschedulecontroller());

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await controller.getPaymentSchedule(widget.loanId);
  }

  @override
  Widget build(BuildContext context) {
    final breakpoints = ResponsiveBreakpoints.of(context);
    final bool isMobile = breakpoints.isMobile;
    final bool isTablet = breakpoints.isTablet;
    final bool isDesktop = breakpoints.isDesktop;

    final int gridCount = isDesktop ? 4 : (isTablet ? 2 : 1);

    return Scaffold(
      backgroundColor: TheColors.bgColor,
      appBar: const CustomAppBar(
        title: "កាលវិភាគការបង់ប្រាក់",
      ),
      body: Obx(() {
        final paymentData = controller.paymentschedule.value;

        if (paymentData == null || controller.isLoading.value) {
          return const Center(child: CustomLoading());
        }

        final schedules = paymentData.schedule ?? [];

        return RefreshIndicator(
          onRefresh: _loadData,
          backgroundColor: TheColors.cutecolo,
          color: TheColors.warningColor,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Paymentcard(
                  paymentschedule: paymentData,
                  onTap: () {},
                ),
                const SizedBox(height: 24),

                /// Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'កាលវិភាគបង់ប្រាក់',
                      style: TextStyles.siemreap(
                        context,
                        fontSize: 18,
                        fontweight: FontWeight.bold,
                        color: TheColors.white,
                      ),
                    ),
                    Text(
                      'សរុប: ${schedules.length} លើក',
                      style: TextStyles.siemreap(
                        context,
                        fontSize: 14,
                        color: TheColors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                /// Content
                if (schedules.isNotEmpty)
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: schedules.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: gridCount,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      childAspectRatio: isDesktop ? 2.3 : 1.4,
                    ),
                    itemBuilder: (context, index) {
                      return ScheduleCard(
                        schedule: schedules[index],
                      );
                    },
                  )
                else
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: TheColors.gray.withOpacity(0.3),
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          size: 48,
                          color: TheColors.gray.withOpacity(0.5),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'មិនមានកាលវិភាគបង់ប្រាក់',
                          style: TextStyles.siemreap(
                            context,
                            fontSize: 16,
                            color: TheColors.gray,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
