import 'package:get/get.dart';
import 'package:loanfrontend/data/models/districtmodel.dart';
import 'package:loanfrontend/module/district/districtservice/districtservice.dart';
import 'package:loanfrontend/share/widgets/snackbar.dart';

class Districtcontroller extends GetxController {
  final Districtservice districtservice = Districtservice();
  var district = <Data>[].obs;

  Future<void> fetchdistrict(int proviceid) async {
    try {
      final result = await districtservice.getdistrict(proviceid);
      district.assignAll(result);
    } catch (e) {
      CustomSnackbar.error(title: "ខុសប្រក្រតី", message: e.toString());
    }
  }
}
