import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loanfrontend/core/theme/app_color.dart';
import 'package:loanfrontend/module/auth/controller/authcontroller.dart';
import 'package:loanfrontend/share/widgets/elevated_button.dart';
import 'package:loanfrontend/share/widgets/textfield.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final AuthController controller = Get.find<AuthController>();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TheColors.bgColor,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
        double width = constraints.maxWidth > 600
        ? 400 
        : constraints.maxWidth * 0.9;
            return Center(
              child: SingleChildScrollView(
                child: Container(
                  width: width,
                  decoration: BoxDecoration(
                    border: Border.all(color: TheColors.orange, width: 0.5),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: _buildForm(),
                  )
                ),
              ),
            );
          }
        ),
      ),
    );
  }
  Widget _buildForm() {
  return Form(
    key: _formKey,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.network(
          "https://cdn-icons-png.flaticon.com/128/5513/5513955.png",
          width: 100,
          height: 100,
        ),
        const SizedBox(height: 20),
        CustomTextField(
          controller: usernameController,
          hintText: "លេខទូរសព្ទ",
          prefixIcon: Icons.phone,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "សូមបញ្ចូលលេខទូរសព្ទ";
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        CustomTextField(
          controller: passwordController,
          hintText: "លេខកូដ",
          prefixIcon: Icons.lock,
          obscureText: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "សូមបញ្ចូលលេខកូដ";
            }
            return null;
          },
        ),
        const SizedBox(height: 24),
        Obx(() {
          return CustomElevatedButton(
            text: controller.isLoading.value ? "កំពុងភ្ជាប់..." : "ចូល",
            onPressed: controller.isLoading.value
                ? () {}
                : () {
                    if (_formKey.currentState!.validate()) {
                      controller.login(
                        username: usernameController.text,
                        password: passwordController.text,
                      );
                    }
                  },
          );
        }),
      ],
    ),
  );
}

}

