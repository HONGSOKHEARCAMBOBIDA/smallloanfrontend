// view/createloanview.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loanfrontend/core/constant/api_endpoint.dart';
import 'package:loanfrontend/core/helper/show_client_buttonsheet.dart';
import 'package:loanfrontend/core/helper/show_loanproduct_buttonsheet.dart';
import 'package:loanfrontend/core/helper/show_user_buttonsheet.dart';
import 'package:loanfrontend/core/theme/app_color.dart';
import 'package:loanfrontend/core/theme/text_styles.dart';
import 'package:loanfrontend/module/auth/controller/authcontroller.dart';
import 'package:loanfrontend/module/client/clientcontroller/clientcontroller.dart';
import 'package:loanfrontend/module/documenttype/controller/documenttyecontroller.dart';
import 'package:loanfrontend/module/loan/controller/loancontroller.dart';
import 'package:loanfrontend/module/loanproduct/controller/loanproductcontroller.dart';
import 'package:loanfrontend/share/widgets/app_bar.dart';
import 'package:loanfrontend/share/widgets/common_widgets.dart';
import 'package:loanfrontend/share/widgets/customoutlinebutton.dart';
import 'package:loanfrontend/share/widgets/dropdown.dart';
import 'package:loanfrontend/share/widgets/elevated_button.dart';
import 'package:loanfrontend/share/widgets/loading.dart';
import 'package:loanfrontend/share/widgets/snackbar.dart';
import 'package:loanfrontend/share/widgets/textfield.dart';
import 'package:responsive_framework/responsive_framework.dart';

class Createloanview extends StatefulWidget {
  const Createloanview({super.key});

  @override
  State<Createloanview> createState() => _CreateloanviewState();
}

class _CreateloanviewState extends State<Createloanview> {
  final authcontroller = Get.find<AuthController>();
  final loancontroller = Get.find<LoanController>();
  final loanproductcontroller = Get.find<Loanproductcontroller>();
  final clientcontroller = Get.find<ClientController>();
  final documenttypecontroller = Get.find<Documenttyecontroller>();

  final _formkey = GlobalKey<FormState>();
  final selectclient = Rxn<int>();
  final selectloanproduct = Rxn<int>();
  final selectdocumenttype = Rxn<int>();
  final selectcheckby = Rxn<int>();
  final selectapproveby = Rxn<int>();
  final loanamount = TextEditingController();
  final purpose = TextEditingController();

  // Guarantor related
  final guarantors = <Map<String, dynamic>>[].obs;
  final selectedGuarantors = <int>[].obs;
  final relationshipController = TextEditingController();
  final signedDateController = TextEditingController();
  final notesController = TextEditingController();

  final selectClientName = 'ជ្រើសអតិថិជន'.obs;
  final selectLoanProductName = 'ជ្រើសប្រភេទកម្ចី'.obs;
  final selectCheckName = 'អ្នកត្រូវពិនិត្យ'.obs;
  final selectApproveName = 'អ្នកត្រូវអនុម័ត'.obs;
  final selectGuarantorName = 'ជ្រើសអ្នកធានា'.obs;

  @override
  void initState() {
    clientcontroller.getclientforcreateloan();
    authcontroller.getuser();
    super.initState();
  }

  Future<void> createloan() async {
    if (!_formkey.currentState!.validate()) return;

    if (selectclient.value == null ||
        selectloanproduct.value == null ||
        selectdocumenttype.value == null ||
        selectcheckby.value == null ||
        selectapproveby.value == null) {
      CustomSnackbar.error(title: Message.Error, message: Message.BadRequest);
      return;
    }

    if (guarantors.isEmpty) {
      CustomSnackbar.error(
          title: Message.Error, message: Message.BadRequestClient);
      return;
    }

    final amount = double.tryParse(loanamount.text);
    if (amount == null) {
      CustomSnackbar.error(title: Message.Error, message: Message.BadRequest);
      return;
    }

    await loancontroller.createloan(
      clientid: selectclient.value!,
      loanproductid: selectloanproduct.value!,
      loanamount: amount,
      purpose: purpose.text,
      documenttypeid: selectdocumenttype.value!,
      checkby: selectcheckby.value!,
      approveby: selectapproveby.value!,
      guarantors: guarantors.toList(),
    );
  }

  void _addGuarantor() {
    if (selectedGuarantors.isEmpty) {
      CustomSnackbar.error(
          title: Message.BadRequest, message: Message.BadRequestClient);
      return;
    }

    if (relationshipController.text.isEmpty) {
      CustomSnackbar.error(title: Message.Error, message: Message.BadRequest);
      return;
    }

    for (var guarantorId in selectedGuarantors) {
      if (guarantors.any((g) => g['client_id'] == guarantorId)) {
        CustomSnackbar.error(
            title: Message.Error, message: Message.ClientDuplicate);
        continue;
      }

      guarantors.add({
        'client_id': guarantorId,
        'relationship': relationshipController.text,
      });
    }
    selectedGuarantors.clear();
    relationshipController.clear();
    selectGuarantorName.value = 'ជ្រើសអ្នកធានា';
  }

  void _removeGuarantor(int index) {
    guarantors.removeAt(index);
  }

  @override
  void dispose() {
    loanamount.dispose();
    purpose.dispose();
    relationshipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final breakpoints = ResponsiveBreakpoints.of(context);
    final bool isMobile = breakpoints.isMobile;
    final bool isTablet = breakpoints.isTablet;
    final bool isDesktop = breakpoints.isDesktop;
    return Scaffold(
        appBar: const CustomAppBar(title: "ស្នេីរកម្ចី"),
        backgroundColor: TheColors.bgColor,
        body: isMobile ? mobile() : web());
  }

  Widget mobile() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildclientSection(),
                CommonWidgets.SizeBoxh15,
                _buildloanprodcutftdocumenttype(),
                CommonWidgets.SizeBoxh15,
                _builduserSection(),
                CommonWidgets.SizeBoxh15,
                _buildloanInfoSection(),
                CommonWidgets.SizeBoxh15,
                _buildGuarantorSection(),
                CommonWidgets.SizeBoxh15,
                _buildGuarantorList(),
                CommonWidgets.SizeBoxh15,
                _buildSubmitButton(),
              ],
            ),
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
        width: screenWidth * 0.5, // 80% of screen width
        height: screenHeight * 0.8, // 50% of screen height
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: TheColors.gray, width: 0.5),
            borderRadius: BorderRadius.circular(15),
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildclientSection(),
                    CommonWidgets.SizeBoxh15,
                    _buildloanprodcutftdocumenttype(),
                    CommonWidgets.SizeBoxh15,
                    _builduserSection(),
                    CommonWidgets.SizeBoxh15,
                    _buildloanInfoSection(),
                    CommonWidgets.SizeBoxh15,
                    _buildGuarantorSection(),
                    CommonWidgets.SizeBoxh15,
                    _buildGuarantorList(),
                    CommonWidgets.SizeBoxh15,
                    _buildSubmitButton(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildclientSection() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: TheColors.gray, width: 0.5),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonWidgets.buildLabel(context, "អតិថិជន"),
            const SizedBox(height: 8),
            Obx(
              () => CustomOutlinedButton(
                text: selectClientName.value,
                onPressed: () {
                  showClientSelectorsheet(
                    context: context,
                    client: clientcontroller.clientforcreateloan,
                    selectedClientId: selectclient.value,
                    onSelected: (id) {
                      selectclient.value = id;
                      selectClientName.value = clientcontroller
                          .clientforcreateloan
                          .firstWhere((p) => p.id == id)
                          .name!;
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildloanprodcutftdocumenttype() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: TheColors.gray, width: 0.5),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Loan Product
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonWidgets.buildLabel(context, "ប្រភេទកម្ចី"),
                const SizedBox(height: 8),
                Obx(
                  () => CustomOutlinedButton(
                    text: selectLoanProductName.value,
                    onPressed: () {
                      showLoanproudctSelectorsheet(
                        context: context,
                        loanprouct: loanproductcontroller.loanproduct,
                        selectedloanprouctId: selectloanproduct.value,
                        onSelected: (id) {
                          selectloanproduct.value = id;
                          selectLoanProductName.value = loanproductcontroller
                              .loanproduct
                              .firstWhere((p) => p.id == id)
                              .name!;
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Document Type
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonWidgets.buildLabel(context, "ទ្រព្យបញ្ជាំ"),
                CustomDropdown(
                  selectedValue: selectdocumenttype,
                  items: documenttypecontroller.documenttype,
                  hintText: "ទ្រព្យបញ្ជាំ",
                  onChanged: (value) {
                    selectdocumenttype.value = value;
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _builduserSection() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: TheColors.gray, width: 0.5),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Check By
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonWidgets.buildLabel(context, "អ្នកត្រូវពិនិត្យ"),
                  const SizedBox(height: 8),
                  Obx(
                    () => CustomOutlinedButton(
                      text: selectCheckName.value,
                      onPressed: () {
                        showUserSelectorsheet(
                          context: context,
                          user: authcontroller.user,
                          selecteduserId: selectcheckby.value,
                          onSelected: (id) {
                            selectcheckby.value = id;
                            selectCheckName.value = authcontroller.user
                                .firstWhere((p) => p.id == id)
                                .name!;
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            // Approve By
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonWidgets.buildLabel(context, "អ្នកត្រូវអនុម័ត"),
                  const SizedBox(height: 8),
                  Obx(
                    () => CustomOutlinedButton(
                      text: selectApproveName.value,
                      onPressed: () {
                        showUserSelectorsheet(
                          context: context,
                          user: authcontroller.user,
                          selecteduserId: selectapproveby.value,
                          onSelected: (id) {
                            selectapproveby.value = id;
                            selectApproveName.value = authcontroller.user
                                .firstWhere((p) => p.id == id)
                                .name!;
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildloanInfoSection() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: TheColors.gray, width: 0.5),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField("ចំនួនប្រាក់ស្នើសុំ", loanamount, "1000000"),
            CommonWidgets.SizeBox8,
            _buildTextField("គោលបំណងកម្ចី", purpose, "ពង្រីកមុខរបរ"),
          ],
        ),
      ),
    );
  }

  Widget _buildGuarantorSection() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: TheColors.gray, width: 0.5),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonWidgets.buildLabel(context, "ជ្រើសអ្នកធានា"),
            const SizedBox(height: 8),
            Obx(
              () => CustomOutlinedButton(
                text: selectGuarantorName.value,
                onPressed: () {
                  showClientSelectorsheet(
                    context: context,
                    client: clientcontroller.clientforcreateloan,
                    selectedClientId: null,
                    allowMultiple: true,
                    onMultipleSelected: (ids) {
                      selectedGuarantors.assignAll(ids);

                      if (ids.isNotEmpty) {
                        final client = clientcontroller.clientforcreateloan
                            .firstWhere((p) => p.id == ids.last);
                        selectGuarantorName.value =
                            client.name ?? 'ជ្រើសអ្នកធានា';
                      }
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            _buildTextField(
                "ទំនាក់ទំនង", relationshipController, "បងប្អូន/មិត្ត"),
            const SizedBox(height: 16), // Signed Date
            Center(
              child: CustomElevatedButton(
                text: "បញ្ចូលអ្នកធានា",
                onPressed: _addGuarantor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGuarantorList() {
    return Obx(() {
      if (guarantors.isEmpty) {
        return Container();
      }

      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: TheColors.gray, width: 0.5),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Text(
                  "បញ្ជីអ្នកធានា (${guarantors.length}) នាក់",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: TheColors.white,
                  ),
                ),
                const SizedBox(height: 16),
                ...guarantors.asMap().entries.map((entry) {
                  final index = entry.key;
                  final guarantor = entry.value;
                  final client = clientcontroller.clientforcreateloan
                      .firstWhereOrNull((c) => c.id == guarantor['client_id']);
                  final relationship =
                      guarantor['relationship']?.toString() ?? 'មិនបានបញ្ជាក់';
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ChoiceChip(
                      label: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            client!.name ?? 'មិនមានឈ្មោះ',
                            style: TextStyles.kantomruy(
                              context,
                              color: TheColors.white,
                              fontweight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            relationship,
                            style: TextStyles.kantomruy(
                              context,
                              color: TheColors.white,
                              fontSize: 11,
                            ),
                          )
                        ],
                      ),
                      selected: false,
                      backgroundColor: TheColors.green,
                      selectedColor: TheColors.red,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide.none),
                      avatar: const Icon(
                        Icons.close,
                        size: 18,
                        color: TheColors.red,
                      ),
                      onSelected: (_) {
                        _removeGuarantor(index);
                      },
                    ),
                  );
                })
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildTextField(
      String label, TextEditingController controller, String hintText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets.buildLabel(context, label),
        const SizedBox(height: 4),
        CustomTextField(
          controller: controller,
          hintText: hintText,
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return Obx(() {
      return loancontroller.isLoading.value
          ? const Center(child: CustomLoading())
          : Padding(
              padding: const EdgeInsets.only(left: 14, right: 14),
              child: CustomElevatedButton(
                text: "បង្កើតថ្មី",
                onPressed: createloan,
              ),
            );
    });
  }
}
