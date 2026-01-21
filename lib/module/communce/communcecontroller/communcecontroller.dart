import 'package:get/get.dart';
import 'package:loanfrontend/data/models/communcemodel.dart';
import 'package:loanfrontend/module/communce/communceservice/communceservice.dart';
import 'package:loanfrontend/share/widgets/snackbar.dart';

class Communcecontroller extends GetxController {
  final Communceservice communceservice = Communceservice();
  var communce = <Data>[].obs;

  Future<void> fetchcommunce(int district_id) async {
    try {
      final result = await communceservice.getcommunce(district_id);
      communce.assignAll(result);
    } catch (e) {
      CustomSnackbar.error(title: "ខុសប្រក្រតី", message: e.toString());
    }
  }
}
