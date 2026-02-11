import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loanfrontend/core/theme/app_color.dart';
import 'package:loanfrontend/data/models/usermodel.dart';
import 'package:loanfrontend/module/role/controller/rolecontroller.dart';
import 'package:loanfrontend/module/user/controller/usercontroller.dart';
import 'package:loanfrontend/share/widgets/app_bar.dart';
import 'package:loanfrontend/share/widgets/common_widgets.dart';
import 'package:loanfrontend/share/widgets/dropdown.dart';
import 'package:loanfrontend/share/widgets/elevated_button.dart';
import 'package:loanfrontend/share/widgets/response.dart';
import 'package:loanfrontend/share/widgets/textfield.dart';

class Updateuserview extends StatefulWidget {
  final Data usermodel;
  const Updateuserview({super.key, required this.usermodel});

  @override
  State<Updateuserview> createState() => _UpdateuserviewState();
}

class _UpdateuserviewState extends State<Updateuserview> {
  Rx<XFile?> clientImage = Rx<XFile?>(null);
  final controller = Get.find<Usercontroller>();
  final rolecontroller = Get.find<Rolecontroller>();
  final _formkey = GlobalKey<FormState>();
  final selectroleid = Rxn<int>();
  final namecontroller = TextEditingController();
  final usernamecontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  final phonecontroller = TextEditingController();
  var rolename = "".obs;
  @override
  void initState() {
    loaddata();
    super.initState();
  }

  void loaddata() {
    final user = widget.usermodel;
    selectroleid.value = user.roleId;
    namecontroller.text = user.name!;
    usernamecontroller.text = user.username!;
    emailcontroller.text = user.email!;
    phonecontroller.text = user.phone!;
    rolename.value = user.roleName!;
  }

  @override
  void dispose() {
    namecontroller.dispose();
    emailcontroller.dispose();
    phonecontroller.dispose();
    usernamecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TheColors.bgColor,
      appBar: const CustomAppBar(title: "កែប្រែអ្នកប្រេីប្រាស់"),
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
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Center(
        child: SizedBox(
          width: 400,
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                // Main content area
                _buildClientInfoSection(),

                // Submit button at the bottom
                const SizedBox(height: 32),
                _buildSubmitButton(),
                const SizedBox(height: 20),
              ],
            ),
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
            _buildTextField("Username", usernamecontroller, "@hear"),
            _buildTextField("Email", emailcontroller, "hear@gmail.com"),
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
    return Obx(() {
      return CustomElevatedButton(
        text: controller.isLoading.value ? "កំពុងកែប្រែ..." : "កែប្រែ",
        onPressed: () async {
          await controller.updateuser(
              id: widget.usermodel.id!,
              name: namecontroller.text,
              username: usernamecontroller.text,
              role_id: selectroleid.value!,
              email: emailcontroller.text,
              phone: phonecontroller.text);
        },
      );
    });
  }
}
