import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:loanfrontend/core/theme/app_color.dart';
import 'package:loanfrontend/core/theme/text_styles.dart';
import 'package:loanfrontend/module/client/clientcontroller/clientcontroller.dart';
import 'package:loanfrontend/module/communce/communcecontroller/communcecontroller.dart';
import 'package:loanfrontend/module/district/districtcontroller/districtcontroller.dart';
import 'package:loanfrontend/module/province/provincecontroller/provincecontroller.dart';
import 'package:loanfrontend/module/village/villagecontroller/villagecontroller.dart';
import 'package:loanfrontend/share/widgets/app_bar.dart';
import 'package:loanfrontend/share/widgets/snackbar.dart';

class Createclientview extends StatefulWidget {
  const Createclientview({super.key});

  @override
  State<Createclientview> createState() => _CreateclientviewState();
}

class _CreateclientviewState extends State<Createclientview> {
  Rx<File?> clientImage = Rx<File?>(null);
  final clientcontroller = Get.find<ClientController>();
  final provincecontroller = Get.find<Provincecontroller>();
  final districtcontroller = Get.find<Districtcontroller>();
  final communcecontroller = Get.find<Communcecontroller>();
  final villagecontroller = Get.find<Villagecontroller>();
  final _formkey = GlobalKey<FormState>();
  final selectprovinceid = Rxn<int>();
  final selectdistrictid = Rxn<int>();
  final selectcommunceid = Rxn<int>();
  final selectvillageid = Rxn<int>();
  final namecontroller = TextEditingController();
  final selectgender = Rxn<int>();
  final maritalStatus = TextEditingController();
  final selectdob = Rxn<DateTime>();
  final occupationcontroller = TextEditingController();
  final idCardNumbercontroller = TextEditingController();
  final phonecontroller = TextEditingController();
  final notescontroller = TextEditingController();
  var selectprovincename = "ជ្រើសរើសខេត្ត".obs;
  var selectdistrictname = "ជ្រើសរើសស្រុក".obs;
  var selectcommuncename = "ជ្រើសរើសឃុំ".obs;
  var selectvillagename = "ជ្រើសរើសភូមិ".obs;
  final List<Map<String, dynamic>> gender = [
    {"id": 1, "name": "ប្រុស"},
    {"id": 2, "name": "ស្រី"},
    {"id": 3, "name": "ផ្សេងទៀត"},
  ];
  void _loadlocation() {
    provincecontroller.fetchprovince();
  }

  @override
  void initState() {
    _loadlocation();
    super.initState();
  }

  Future<void> createclient() async {
    if (_formkey.currentState!.validate()) {
      if (selectvillageid.value == null) {
        CustomSnackbar.error(title: "ខុស", message: "ភ្លេចរេីសភូមិអតិថិជន");
        return;
      }
      try {
        await clientcontroller.createclient(
            name: namecontroller.text.trim(),
            gender: selectgender.value!,
            maritalStatus: maritalStatus.text.trim(),
            dateOfBirth: selectdob.value.toString(),
            occupation: occupationcontroller.text.trim(),
            idCardNumber: idCardNumbercontroller.text.trim(),
            phone: phonecontroller.text.trim(),
            villageId: selectvillageid.value!);
      } catch (e) {
        CustomSnackbar.error(title: "កំហុស", message: "មិនអាចចុះឈ្មោះបាន: $e");
      }
    }
  }
  Widget _buildLabel(String label) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        children: [
          Text(label, style: TextStyles.siemreap(context, fontSize: 12)),
          SizedBox(height: 5),
        ],
      ),
    );
  }
  Widget _buildHeader(String label, IconData icon) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Row(
        children: [
          Icon(icon, color: TheColors.orange, size: 18),
          SizedBox(width: 6),
          Text(
            label,
            style: TextStyles.siemreap(
            context,
            fontweight: FontWeight.bold,
            fontSize: 14,
            color: TheColors.black
            ),
          ),
        ],
      ),
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    namecontroller.dispose();
    maritalStatus.dispose();
    occupationcontroller.dispose();
    idCardNumbercontroller.dispose();
    phonecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "បង្កេីតអតិថិជនថ្មី"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [],
      ),
    );
  }
}
