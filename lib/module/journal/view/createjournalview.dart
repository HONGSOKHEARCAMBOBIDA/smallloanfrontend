import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loanfrontend/core/helper/show_chataccount_buttonsheet.dart';
import 'package:loanfrontend/core/theme/app_color.dart';
import 'package:loanfrontend/core/theme/text_styles.dart';
import 'package:loanfrontend/module/chartaccount/controller/chartaccountcontroller.dart';
import 'package:loanfrontend/module/journal/controller/journalcontroller.dart';
import 'package:loanfrontend/share/widgets/app_bar.dart';
import 'package:loanfrontend/share/widgets/common_widgets.dart';
import 'package:loanfrontend/share/widgets/customoutlinebutton.dart';
import 'package:loanfrontend/share/widgets/datepicker.dart';
import 'package:loanfrontend/share/widgets/textfield.dart';
import 'package:responsive_framework/responsive_framework.dart';

class Createjournalview extends StatefulWidget {
  const Createjournalview({super.key});

  @override
  State<Createjournalview> createState() => _CreatejournalviewState();
}

class _CreatejournalviewState extends State<Createjournalview> {
  final journalcontroller = Get.find<Journalcontroller>();
  final chataccountcontroller = Get.find<Chartaccountcontroller>();
  final _formkey = GlobalKey<FormState>();
  final selectdate = Rxn<DateTime>();
  final selectdebitchataccountid = Rxn<int>();
  final selectcreditchataccountid = Rxn<int>();
  final amountcontroller = TextEditingController();
  final descriptioncontroller = TextEditingController();
  var selectdebitname = "ឈ្មេាះគណនេយ្យ (ចូល)".obs;
  var selectcreditname = "ឈ្មេាះគណនេយ្យ (ចេញ)".obs;

  @override
  void dispose() {
    amountcontroller.dispose();
    descriptioncontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final breakpoint = ResponsiveBreakpoints.of(context);
    final bool isMobile = breakpoint.isMobile;
    return Scaffold(
      backgroundColor: TheColors.bgColor,
      appBar: const CustomAppBar(title: "កត់ត្រាប្រតិបត្តិការផ្សេងៗ"),
      body: isMobile ? mobile() : web(),
    );
  }

  Widget mobile() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formkey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [_builbody(), CommonWidgets.SizeBoxh20, _buildsubmit()],
          ),
        ),
      ),
    );
  }

  Widget web() {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Center(
      child: SizedBox(
        width: screenWidth * 0.3, // 80% of screen width
        height: screenHeight * 0.5,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: TheColors.checked, width: 0.5),
              borderRadius: BorderRadius.circular(15),
            ),
            child: SingleChildScrollView(
              child: Form(
                key: _formkey,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      _builbody(),
                      CommonWidgets.SizeBoxh15,
                      _buildsubmit()
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _builbody() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: TheColors.checked, width: 1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () => CustomOutlinedButton(
                text: selectdebitname.value,
                onPressed: () {
                  showChataccoutSelectorSheet(
                    context: context,
                    chataccount: chataccountcontroller.data,
                    selectedchataccount: selectdebitchataccountid.value,
                    onSelected: (id) {
                      selectdebitchataccountid.value = id;
                      selectdebitname.value = chataccountcontroller.data
                          .firstWhere((p) => p.id == id)
                          .name!;
                    },
                  );
                },
              ),
            ),
            CommonWidgets.SizeBoxh15,
            Obx(
              () => CustomOutlinedButton(
                text: selectcreditname.value,
                onPressed: () {
                  showChataccoutSelectorSheet(
                    context: context,
                    chataccount: chataccountcontroller.data,
                    selectedchataccount: selectcreditchataccountid.value,
                    onSelected: (id) {
                      selectcreditchataccountid.value = id;
                      selectcreditname.value = chataccountcontroller.data
                          .firstWhere((p) => p.id == id)
                          .name!;
                    },
                  );
                },
              ),
            ),
            CommonWidgets.SizeBoxh15,
            CustomTextField(
              controller: amountcontroller,
              hintText: "បំពេញទឹកប្រាក់",
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "សូមបំពេញទឹកប្រាក់";
                }
                if (double.tryParse(value) == null) {
                  return "ទឹកប្រាក់មិនត្រឹមត្រូវ";
                }
                return null;
              },
            ),
            CommonWidgets.SizeBoxh15,
            CustomTextField(
              controller: descriptioncontroller,
              hintText: "បរិយាយ",
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "សូមបំពេញបរិយាយ";
                }
                return null;
              },
            ),
            CommonWidgets.SizeBoxh15,
            CustomDatePickerField(label: "", selectedDate: selectdate)
          ],
        ),
      ),
    );
  }

  bool _validateExtraFields() {
    if (selectdebitchataccountid.value == null) {
      Get.snackbar("បរាជ័យ", "សូមជ្រើសរើសគណនេយ្យ (ចូល)");
      return false;
    }
    if (selectcreditchataccountid.value == null) {
      Get.snackbar("បរាជ័យ", "សូមជ្រើសរើសគណនេយ្យ (ចេញ)");
      return false;
    }
    if (selectdate.value == null) {
      Get.snackbar("បរាជ័យ", "សូមជ្រើសរើសកាលបរិច្ឆេទ");
      return false;
    }
    return true;
  }

  Widget _buildsubmit() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Obx(() {
            return Expanded(
              child: ElevatedButton(
                onPressed: journalcontroller.isLoading.value
                    ? null
                    : () async {
                        if (!_formkey.currentState!.validate()) return;
                        if (!_validateExtraFields()) return;

                        final amount = double.parse(amountcontroller.text);

                        await journalcontroller.createjournal(
                          debit_account_id: selectdebitchataccountid.value!,
                          credit_account_id: selectcreditchataccountid.value!,
                          date: selectdate.value!.toIso8601String(),
                          amount: amount,
                          description: descriptioncontroller.text.trim(),
                        );

                        Get.back();
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: TheColors.checked,
                  minimumSize:
                      const Size(double.infinity, 50), // 👈 height here
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: journalcontroller.isLoading.value
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: TheColors.cutecolo,
                        ),
                      )
                    : Text(
                        "បន្ថែមប្រតិបត្តិការ",
                        style: TextStyles.siemreap(
                          context,
                          fontSize: 16,
                          color: TheColors.white,
                        ),
                      ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
