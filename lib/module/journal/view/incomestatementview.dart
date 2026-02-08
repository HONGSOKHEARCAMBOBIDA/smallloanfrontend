import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loanfrontend/core/theme/app_color.dart';
import 'package:loanfrontend/core/theme/text_styles.dart';
import 'package:loanfrontend/module/journal/controller/journalcontroller.dart';
import 'package:loanfrontend/share/widgets/app_bar.dart';
import 'package:loanfrontend/share/widgets/incomestatementcard.dart';
import 'package:loanfrontend/share/widgets/loading.dart';
import 'package:responsive_framework/responsive_framework.dart';

class Incomestatementview extends StatefulWidget {
  const Incomestatementview({super.key});

  @override
  State<Incomestatementview> createState() => _IncomestatementviewState();
}

class _IncomestatementviewState extends State<Incomestatementview> {
  final Journalcontroller controller = Get.find<Journalcontroller>();

  @override
  Widget build(BuildContext context) {
    final breakpoint = ResponsiveBreakpoints.of(context);
    final bool isMobile = breakpoint.isMobile;

    return Scaffold(
      backgroundColor: TheColors.bgColor,
      appBar: const CustomAppBar(title: "របាយការណ៍ ចំណេញ/ខាត"),
      body: Padding(
        padding: EdgeInsets.only(
          left: isMobile ? 8 : 600,
          right: isMobile ? 8 : 600,
          top: isMobile ? 8 : 100,
        ),
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CustomLoading());
          }

          final data = controller.incomestaement.value;

          if (data == null) {
            return Center(
              child: Text(
                'អត់ទាន់មានទិន្ន័យ',
                style: TextStyles.kantomruy(context, fontSize: 12),
              ),
            );
          }

          return SingleChildScrollView(
            child: Incomestatementcard(
              data: data, // ✅ correct
              onTap: () {}, // optional
            ),
          );
        }),
      ),
    );
  }
}
