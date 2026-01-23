import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loanfrontend/core/helper/show_communce_buttonsheet.dart';
import 'package:loanfrontend/core/helper/show_district_buttonsheet.dart';
import 'package:loanfrontend/core/helper/show_province_buttonsheet.dart';
import 'package:loanfrontend/core/helper/show_village_buttonsheet.dart';
import 'package:loanfrontend/core/theme/app_color.dart';
import 'package:loanfrontend/core/theme/text_styles.dart';
import 'package:loanfrontend/module/client/clientcontroller/clientcontroller.dart';
import 'package:loanfrontend/module/communce/communcecontroller/communcecontroller.dart';
import 'package:loanfrontend/module/district/districtcontroller/districtcontroller.dart';
import 'package:loanfrontend/module/province/provincecontroller/provincecontroller.dart';
import 'package:loanfrontend/module/village/villagecontroller/villagecontroller.dart';
import 'package:loanfrontend/share/widgets/app_bar.dart';
import 'package:loanfrontend/share/widgets/common_widgets.dart';
import 'package:loanfrontend/share/widgets/customoutlinebutton.dart';
import 'package:loanfrontend/share/widgets/datepicker.dart';
import 'package:loanfrontend/share/widgets/elevated_button.dart';
import 'package:loanfrontend/share/widgets/response.dart';
import 'package:loanfrontend/share/widgets/snackbar.dart';
import 'package:loanfrontend/share/widgets/textfield.dart';
import 'package:flutter/foundation.dart';

class Createclientview extends StatefulWidget {
  const Createclientview({super.key});

  @override
  State<Createclientview> createState() => _CreateclientviewState();
}

class _CreateclientviewState extends State<Createclientview> {
  Rx<XFile?> clientImage = Rx<XFile?>(null);
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

  @override
  void initState() {
    _loadlocation();
    super.initState();
  }

  void _loadlocation() {
    provincecontroller.fetchprovince();
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
          villageId: selectvillageid.value!,
        );
      } catch (e) {
        CustomSnackbar.error(title: "កំហុស", message: "មិនអាចចុះឈ្មោះបាន: $e");
      }
    }
  }

  @override
  void dispose() {
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
      backgroundColor: TheColors.bgColor,
      appBar: CustomAppBar(title: "បង្កេីតអតិថិជនថ្មី"),
      body: Responsive(
        mobile: mobile(),
        web: web(),
      ),
    );
  }

  Widget mobile() {
    return SingleChildScrollView(
      child: Form(
        key: _formkey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildProfileImageSection(),
              CommonWidgets.SizeBoxh15,
              _buildClientInfoSection(),
              CommonWidgets.SizeBoxh15,
              _buildLocationSection(),
              CommonWidgets.SizeBoxh15,
              _buildSubmitButton(),
            ],
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
            // Profile image at the top
            _buildProfileImageSection(radius: 120),
            const SizedBox(height: 32),
            
            // Main content area
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left side - Client Info
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                    child: _buildClientInfoSection(),
                  ),
                ),
                
                const SizedBox(width: 40), // Consistent spacing between columns
                
                // Right side - Location Info
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                    child: _buildLocationSection(),
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
  Widget _buildProfileImageSection({double radius = 50}) {
    return Center(
      child: Column(
        children: [
          Obx(() {
            return Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: TheColors.warningColor,
                  width: 0.9,
                ),
                borderRadius: BorderRadius.circular(radius),
              ),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: CircleAvatar(
                  radius: radius,
                  backgroundColor: TheColors.bgColor,
                  backgroundImage: clientImage.value != null
                      ? kIsWeb
                          ? NetworkImage(clientImage.value!.path)
                          : FileImage(File(clientImage.value!.path))
                              as ImageProvider
                      : null,
                  child: clientImage.value == null
                      ? Icon(
                          Icons.person,
                          size: radius * 0.8,
                          color: TheColors.errorColor,
                        )
                      : null,
                ),
              ),
            );
          }),
          const SizedBox(height: 12),
          OutlinedButton(
            style: ButtonStyle(
              side: MaterialStateProperty.all(
                BorderSide(
                  color: TheColors.warningColor,
                  width: 1,
                ),
              ),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
              ),
            ),
            onPressed: () async {
              final image = await clientcontroller.pickImage();
              if (image != null) {
                clientImage.value = image;
              }
            },
            child: Text(
              "ជ្រើសរើសរូបភាព",
              style: TextStyles.siemreap(
                context,
                color: TheColors.orange,
                fontSize: 12,
              ),
            ),
          ),
        ],
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
            CommonWidgets.buildHeader(
                context, "ព័ត៌មានអតិថិជន", Icons.person),
            const SizedBox(height: 16),
            _buildTextField("ឈ្មោះ", namecontroller, "ហុង សុខហ៊ា​"),
            _buildGenderDropdown(),
            _buildTextField(
                "ស្ថានភាពគ្រួសារ", maritalStatus, "នៅលីវ"),
            _buildTextField("មុខរបរ", occupationcontroller, "កសិករ"),
            _buildTextField("លេខអត្តសញ្ញាណប័ណ្ណ", idCardNumbercontroller,
                "12035478"),
            _buildTextField("លេខទូរសព្", phonecontroller, "02145235"),
            _buildDatePicker(),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationSection() {
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
            CommonWidgets.buildHeader(
                context, "ទីកន្លែងកំណេីត", Icons.location_on_outlined),
            const SizedBox(height: 16),
            _buildLocationButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationButtons() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Obx(
                () => CustomOutlinedButton(
                  alignment: MainAxisAlignment.center,
                  text: selectprovincename.value,
                  onPressed: () {
                    showProvinceSelectorSheet(
                      context: context,
                      provinces: provincecontroller.provinces,
                      selectedProvince: selectprovinceid.value,
                      onSelected: (id) {
                        selectprovinceid.value = id;
                        selectprovincename.value = provincecontroller.provinces
                            .firstWhere((p) => p.id == id)
                            .name!;
                        selectdistrictid.value = null;
                        selectdistrictname.value = "ជ្រើសរើសស្រុក";
                        selectcommunceid.value = null;
                        selectcommuncename.value = "ជ្រើសរើសឃុំ";
                        selectvillageid.value = null;
                        selectvillagename.value = "ជ្រើសរើសភូមិ";
                        districtcontroller.district.clear();
                        communcecontroller.communce.clear();
                        villagecontroller.village.clear();
                        districtcontroller.fetchdistrict(id);
                      },
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Obx(
                () => CustomOutlinedButton(
                  alignment: MainAxisAlignment.center,
                  text: selectdistrictname.value,
                  onPressed: selectprovinceid.value == null
                      ? null
                      : () {
                          showDistrictSelectorSheet(
                            context: context,
                            district: districtcontroller.district,
                            selecteddistrict: selectdistrictid.value,
                            onSelected: (id) {
                              selectdistrictid.value = id;
                              selectdistrictname.value = districtcontroller
                                  .district
                                  .firstWhere((p) => p.id == id)
                                  .name!;
                              selectcommunceid.value = null;
                              selectcommuncename.value = "ជ្រើសរើសឃុំ";
                              selectvillageid.value = null;
                              selectvillagename.value = "ជ្រើសរើសភូមិ";
                              communcecontroller.communce.clear();
                              communcecontroller.fetchcommunce(id);
                            },
                          );
                        },
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Obx(
                () => CustomOutlinedButton(
                  alignment: MainAxisAlignment.center,
                  text: selectcommuncename.value,
                  onPressed: selectdistrictid.value == null
                      ? null
                      : () {
                          showCommunceSelectorSheet(
                            context: context,
                            communce: communcecontroller.communce,
                            selectedCommunce: selectcommunceid.value,
                            onSelected: (id) {
                              selectcommunceid.value = id;
                              selectcommuncename.value = communcecontroller
                                  .communce
                                  .firstWhere((p) => p.id == id)
                                  .name!;
                              selectvillageid.value = null;
                              selectvillagename.value = "ជ្រើសរើសភូមិ";
                              villagecontroller.village.clear();
                              villagecontroller.fetvillage(id);
                            },
                          );
                        },
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Obx(
                () => CustomOutlinedButton(
                  alignment: MainAxisAlignment.center,
                  text: selectvillagename.value,
                  onPressed: selectcommunceid.value == null
                      ? null
                      : () {
                          showVillageSelectorsheet(
                            context: context,
                            village: villagecontroller.village,
                            selectedVillageId: selectvillageid.value,
                            onSelected: (id) {
                              selectvillageid.value = id;
                              selectvillagename.value = villagecontroller
                                  .village
                                  .firstWhere((p) => p.id == id)
                                  .name!;
                            },
                          );
                        },
                ),
              ),
            ),
          ],
        ),
      ],
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

  Widget _buildGenderDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets.buildLabel(context, "ភេទ"),
        const SizedBox(height: 4),
        Obx(
          () => DropdownButtonFormField<int>(
            value: selectgender.value,
            decoration: InputDecoration(
              labelText: "ភេទ",
              labelStyle: TextStyles.siemreap(
                context,
                fontSize: 12,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(CommonWidgets.radius),
                borderSide: BorderSide(
                  color: TheColors.orange,
                  width: CommonWidgets.borderwidth,
                ),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: TheColors.orange,
                  width: CommonWidgets.borderwidth,
                ),
                borderRadius: BorderRadius.circular(CommonWidgets.radius),
              ),
            ),
            items: gender.map((gender) {
              return DropdownMenuItem<int>(
                value: gender['id'] as int,
                child: Text(
                  gender['name'],
                  style: TextStyles.siemreap(
                    context,
                    fontSize: CommonWidgets.fontsize12,
                  ),
                ),
              );
            }).toList(),
            dropdownColor: TheColors.bgColor,
            borderRadius: BorderRadius.circular(CommonWidgets.radius),
            icon: const Icon(
              Icons.arrow_drop_down,
              color: TheColors.orange,
            ),
            iconSize: 17,
            elevation: 2,
            menuMaxHeight: 140,
            style: TextStyles.siemreap(
              context,
              fontSize: 12,
            ),
            onChanged: (value) {
              selectgender.value = value;
            },
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget _buildDatePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets.buildLabel(context, "ថ្ងៃ-ខែ-ឆ្នាំ-កំណេីត"),
        const SizedBox(height: 4),
        CustomDatePickerField(
          label: "",
          selectedDate: selectdob,
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return CustomElevatedButton(
      text: "បង្កេីតថ្មី",
      onPressed: createclient,
    );
  }
}