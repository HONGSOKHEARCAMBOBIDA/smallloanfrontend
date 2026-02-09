import 'package:flutter/material.dart';
import 'package:loanfrontend/core/constant/constants.dart';
import 'package:loanfrontend/core/theme/app_color.dart';
import 'package:loanfrontend/core/theme/text_styles.dart';
import 'package:loanfrontend/data/models/loanmodel.dart';
import 'package:loanfrontend/module/paymentschedule/binding/paymentschedulebinding.dart';
import 'package:loanfrontend/module/paymentschedule/view/paymentscheduleview.dart';
import 'package:loanfrontend/module/reciept/controller/recieptcontroller.dart';
import 'package:loanfrontend/share/widgets/common_widgets.dart';
import 'package:loanfrontend/share/widgets/customoutlinebutton.dart';
import 'package:loanfrontend/share/widgets/textfield.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:get/get.dart';

Future<void> showLoanButtonsheet({
  required BuildContext context,
  required Data loan,
}) {
  final breakpoints = ResponsiveBreakpoints.of(context);
  final bool isMobile = breakpoints.isMobile;
  final double smallFontSize = isMobile ? 12 : 14;
  return showModalBottomSheet(
    backgroundColor: TheColors.bgColor,
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) {
      return DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.85,
        maxChildSize: 0.95,
        minChildSize: 0.5,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: TheColors.gray,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  _buildClientHeader(loan, context),
                  const SizedBox(height: 20),
                  _buildSectionTitle("ព័ត៌មានកម្ចី", context),
                  _buildLoanInfo(loan, context),

                  const SizedBox(height: 20),

                  // Payment Information Section
                  _buildSectionTitle("ព័ត៌មានការបង់ប្រាក់", context),
                  _buildPaymentInfo(loan, context),

                  const SizedBox(height: 20),

                  // Staff Information Section
                  _buildSectionTitle("ព័ត៌មានបុគ្គលិក", context),
                  _buildStaffInfo(loan, context),

                  const SizedBox(height: 20),

                  // Location Information Section
                  _buildSectionTitle("ទីតាំង", context),
                  _buildLocationInfo(loan, context),

                  const SizedBox(height: 30),

                  // Action Buttons
                  _buildActionButtons(context, loan),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

Widget _buildClientHeader(Data loan, context) {
  final breakpoints = ResponsiveBreakpoints.of(context);
  final bool isMobile = breakpoints.isMobile;
  final double smallFontSize = isMobile ? 12 : 14;
  final double iconSize = isMobile ? 12 : 18;
  return Row(
    children: [
      CircleAvatar(
        radius: 30,
        backgroundImage:
            loan.clientImage != null && loan.clientImage!.isNotEmpty
                ? NetworkImage(
                    "${Appconstants.baseUrl}/clientimage/${loan.clientImage}",
                  )
                : const NetworkImage(
                    "https://cdn-icons-png.flaticon.com/512/17634/17634775.png",
                  ),
      ),
      const SizedBox(width: 16),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              loan.clientName ?? "អតិថិជនមិនស្គាល់",
              style: TextStyles.siemreap(
                context,
                fontSize: smallFontSize,
                fontweight: FontWeight.bold,
                color: TheColors.white,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  Icons.phone,
                  color: TheColors.lightOrage,
                  size: iconSize,
                ),
                CommonWidgets.SizeBoxwidh5,
                Text(
                  loan.clientPhone ?? "មិនមានលេខទូរសព្ទ",
                  style: TextStyles.siemreap(
                    context,
                    fontSize: 14,
                    color: TheColors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),
            Text(
              "${_getGenderText(loan.clientGender)} • ${loan.clientMaritalStatus ?? "មិនមាន"}",
              style: TextStyles.siemreap(
                context,
                fontSize: smallFontSize,
                color: TheColors.white,
              ),
            ),
          ],
        ),
      ),
      _buildStatusBadge(loan.status, context),
    ],
  );
}

Widget _buildStatusBadge(String? status, context) {
  Color color = TheColors.gray;
  String text = "មិនស្គាល់";

  switch (status) {
    case "1":
      color = TheColors.pending;
      text = "កំពុងរង់ចាំ";
      break;
    case "2":
      color = TheColors.checked;
      text = "បានត្រួតពិនិត្យ";
      break;
    case "3":
      color = TheColors.approve;
      text = "កំពុងដំណេីរការ";
      break;
    case "4":
      color = TheColors.successColor;
      text = "បានទម្លាក់ទុន";
      break;
  }

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Text(
      text,
      style: TextStyles.siemreap(
        context,
        fontSize: 12,
        color: TheColors.white,
        fontweight: FontWeight.w500,
      ),
    ),
  );
}

String _getGenderText(int? gender) {
  return gender == 1 ? "ប្រុស" : "ស្រី";
}

Widget _buildSectionTitle(String title, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Text(
      title,
      style: TextStyles.siemreap(
        context,
        fontSize: 16,
        color: TheColors.white,
      ),
    ),
  );
}

Widget _buildLoanInfo(Data loan, BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: TheColors.checked, width: 0.5)),
    child: Column(
      children: [
        _buildInfoRow("ប្រភេទកម្ចី", loan.loanProductName, context),
        _buildInfoRow("ចំនួនទឹកប្រាក់",
            "${loan.loanAmount?.toStringAsFixed(0)} ៛", context),
        _buildInfoRow("អត្រាការប្រាក់",
            "${loan.interestRate?.toStringAsFixed(1)} ៛", context),
        _buildInfoRow("ថ្លៃសេវាកម្ម",
            "${loan.processFee?.toStringAsFixed(0)} ៛", context),
        _buildInfoRow("រយៈពេល", "${loan.duration} ថ្ងៃ", context),
        _buildInfoRow("គោលបំណង", loan.purpose, context),
        _buildInfoRow("ប្រភេទឯកសារ", loan.documentTypeName, context),
      ],
    ),
  );
}

Widget _buildPaymentInfo(Data loan, BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: TheColors.checked, width: 0.5)),
    child: Column(
      children: [
        _buildInfoRow("ប្រាក់បង់ប្រចាំថ្ងៃ",
            "${loan.dailyPaymentAmount?.toStringAsFixed(0)} ៛", context),
        _buildInfoRow("កាលបរិច្ឆេទអនុម័ត", loan.approveDate, context),
        _buildInfoRow("ថ្ងៃចាប់ផ្ដើម", loan.loanStartDate, context),
        _buildInfoRow("ថ្ងៃបញ្ចប់", loan.loanEndDate, context),
        _buildInfoRow("កាលបរិច្ឆេទទម្លាក់ទុន", loan.disbursedDate, context),
      ],
    ),
  );
}

Widget _buildStaffInfo(Data loan, BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: TheColors.checked, width: 0.5)),
    child: Column(
      children: [
        _buildInfoRow("បុគ្គលិកថែទាំ", loan.coName, context),
        _buildInfoRow("អ្នកត្រួតពិនិត្យ", loan.checkByName, context),
        _buildInfoRow("អ្នកអនុម័ត", loan.approveByName, context),
        _buildInfoRow("អ្នកបញ្ចាំង", loan.disburseByName, context),
      ],
    ),
  );
}

Widget _buildLocationInfo(Data loan, BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: TheColors.checked, width: 0.5)),
    child: Column(
      children: [
        _buildInfoRow("ភូមិ", loan.villageName, context),
        _buildInfoRow("ឃុំ/សង្កាត់", loan.communceName, context),
        _buildInfoRow("ស្រុក/ខណ្ឌ", loan.districtName, context),
        _buildInfoRow("ខេត្ត/រាជធានី", loan.provinceName, context),
      ],
    ),
  );
}

Widget _buildInfoRow(String label, String? value, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            "$label:",
            style: TextStyles.siemreap(
              context,
              fontSize: 14,
              color: TheColors.lightOrage,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 3,
          child: Text(
            value ?? "មិនមាន",
            style: TextStyles.siemreap(
              context,
              fontSize: 14,
              color: TheColors.white,
              fontweight: FontWeight.w500,
            ),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    ),
  );
}

Widget _buildActionButtons(BuildContext context, Data loan) {
  final controller = Get.find<Recieptcontroller>();

  final breakpoint = ResponsiveBreakpoints.of(context);
  final bool isMobile = breakpoint.isMobile;
  final bool isTablet = breakpoint.isTablet;
  final bool isDesktop = breakpoint.isDesktop;
  final int gridCount = isDesktop ? 3 : (isTablet ? 2 : 1);
  final double smallFontSize = isMobile ? 12 : 15;
  final totalcontroller = TextEditingController();
  return Row(
    children: [
      Expanded(
        child: CustomOutlinedButton(
          borderColor: TheColors.green,
          onPressed: () {
            // Navigator.pop(context);
            Get.defaultDialog(
              title: "ប្រមូលប្រាក់",
              titleStyle: TextStyles.moul(context,
                  fontSize: smallFontSize, color: TheColors.warningColor),
              backgroundColor: TheColors.bgColor, // important
              content: Padding(
                padding: const EdgeInsets.all(8.0),
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
                        "អតិថិជ​ន :${loan.clientName}",
                        style: TextStyles.siemreap(context),
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
                              onPressed: () => Get.back(),
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: TheColors.red),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text("ចាកចេញ",
                                  style: TextStyles.siemreap(context,
                                      fontSize: smallFontSize,
                                      color: TheColors.white)),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Obx(() {
                              return ElevatedButton(
                                onPressed: controller.isLoading.value
                                    ? null
                                    : () async {
                                        final total =
                                            int.tryParse(totalcontroller.text);
                                        await controller.createreciept(
                                            id: loan.id!, total: total!);
                                        Get.back();
                                      },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: TheColors.green,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: controller.isLoading.value
                                    ? const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: TheColors.cutecolo,
                                        ),
                                      )
                                    : Text(
                                        "បង់ប្រាក់",
                                        style: TextStyles.siemreap(
                                          context,
                                          fontSize: smallFontSize,
                                          color: TheColors.white,
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
          text: "បង់ប្រាក់",
        ),
      ),
      const SizedBox(width: 12),
      if (loan.status == "3")
        Expanded(
          child: CustomOutlinedButton(
            borderColor: TheColors.cutecolo,
            onPressed: () {
              // Approve action
              Get.to(() => PaymentScheduleView(loanId: loan.id!),
                  binding: Paymentschedulebinding());
            },
            text: "មេីលតារាំងបង់ប្រាក់",
          ),
        ),
    ],
  );
}
