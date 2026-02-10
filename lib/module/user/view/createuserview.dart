import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loanfrontend/core/theme/app_color.dart';
import 'package:loanfrontend/module/role/controller/rolecontroller.dart';
import 'package:loanfrontend/module/user/controller/usercontroller.dart';
import 'package:loanfrontend/share/widgets/app_bar.dart';
import 'package:loanfrontend/share/widgets/common_widgets.dart';
import 'package:loanfrontend/share/widgets/dropdown.dart';
import 'package:loanfrontend/share/widgets/elevated_button.dart';
import 'package:loanfrontend/share/widgets/response.dart';
import 'package:loanfrontend/share/widgets/textfield.dart';

class Createuserview extends StatefulWidget {
  const Createuserview({super.key});

  @override
  State<Createuserview> createState() => _CreateuserviewState();
}

class _CreateuserviewState extends State<Createuserview> {
  Rx<XFile?> clientImage = Rx<XFile?>(null);
  final controller = Get.find<Usercontroller>();
  final rolecontroller = Get.find<Rolecontroller>();
  final _formkey = GlobalKey<FormState>();
  final selectroleid = Rxn<int>();
  final namecontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final phonecontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    namecontroller.dispose();
    passwordcontroller.dispose();
    phonecontroller.dispose();
    phonecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TheColors.bgColor,
      appBar: CustomAppBar(title: "បង្កេីតអ្នកប្រេីប្រាស់ថ្មី"),
      body: Responsive(
        mobile: mobile(),
        web: web(),
      ),
    );
  }

  Widget mobile() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formkey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildClientInfoSection(),
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
    return Form(
      key: _formkey,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              // Main content area
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left side - Client Info
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 20.0),
                      child: _buildClientInfoSection(),
                    ),
                  ),
                ],
              ),

              // Submit button at the bottom
              const SizedBox(height: 32),
              SizedBox(
                width: 300,
                child: _buildSubmitButton(),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildClientInfoSection() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: TheColors.orange,
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonWidgets.buildHeader(context, "ព័ត៌មានអតិថិជន", Icons.person),
            const SizedBox(height: 16),
            _buildTextField("ឈ្មោះ", namecontroller, "ហុង សុខហ៊ា​"),
            _buildTextField("ពាក្យសម្ងាត់", passwordcontroller, "123"),
            _buildTextField("លេខទូរសព្", phonecontroller, "02145235"),
            _buildRoleDropdown(),
          ],
        ),
      ),
    );
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
        const SizedBox(height: 12),
      ],
    );
  }

  Widget _buildRoleDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets.buildLabel(context, "តួនាទី"),
        CustomDropdown(
            selectedValue: selectroleid,
            items: rolecontroller.data,
            hintText: "ជ្រេីសរេីស",
            onChanged: (value) {
              selectroleid.value = value;
            }),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return CustomElevatedButton(
      text: "បង្កេីតថ្មី",
      onPressed: () async {
        await controller.register(
            name: namecontroller.text,
            password: passwordcontroller.text,
            roleid: selectroleid.value!,
            phone: phonecontroller.text);
      },
    );
  }
}
