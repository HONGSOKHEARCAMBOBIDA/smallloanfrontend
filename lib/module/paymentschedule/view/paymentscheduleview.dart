import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loanfrontend/core/theme/app_color.dart';
import 'package:loanfrontend/core/theme/text_styles.dart';
import 'package:loanfrontend/module/paymentschedule/controller/paymentschedulecontroller.dart';
import 'package:loanfrontend/share/widgets/app_bar.dart';
import 'package:loanfrontend/share/widgets/loading.dart';
import 'package:loanfrontend/share/widgets/paymentcard.dart';
import 'package:loanfrontend/share/widgets/schedulecard.dart';

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
    return Scaffold(
      backgroundColor: TheColors.bgColor,
      appBar: const CustomAppBar(
        title: "កាលវិភាគការបង់ប្រាក់",
      ),
      body: Obx(() {
        final paymentData = controller.paymentschedule.value;
        final isLoading = paymentData == null;

        if (isLoading) {
          return const Center(child: CustomLoading());
        }

        return RefreshIndicator(
          onRefresh: _loadData,
          backgroundColor: TheColors.cutecolo,
          color: TheColors.warningColor,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Paymentcard(
                  paymentschedule: paymentData!,
                  onTap: () {},
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
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
                        'សរុប: ${paymentData.schedule?.length ?? 0} លើក',
                        style: TextStyles.siemreap(
                          context,
                          fontSize: 14,
                          color: TheColors.gray,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                if (paymentData.schedule != null &&
                    paymentData.schedule!.isNotEmpty)
                  ...paymentData.schedule!.map((schedule) {
                    return Column(
                      children: [
                        ScheduleCard(
                          schedule: schedule,
                          onPayNow: () {},
                          onViewDetails: () {
                            // Handle view details
                          },
                        ),
                        const SizedBox(height: 12),
                      ],
                    );
                  }).toList()
                else
                  Container(
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
                          style: TextStyle(
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
