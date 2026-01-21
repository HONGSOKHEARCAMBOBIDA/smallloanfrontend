import 'package:get/get.dart';
import 'package:loanfrontend/data/models/villagemodel.dart';
import 'package:loanfrontend/module/village/villageservice/villageservice.dart';
import 'package:loanfrontend/share/widgets/snackbar.dart';

class Villagecontroller extends GetxController {
  final Villageservice villageservice = Villageservice();
  var village = <Data>[].obs;
  Future<void> fetvillage($communceid) async {
    try {
      final result = await villageservice.getvillage($communceid);
      village.assignAll(result);
    } catch (e) {
      CustomSnackbar.error(
        title: "ខុសប្រក្រតី",
        message: "ទិន្ន័យទាញមិនបាន ${e}",
      );
    }
  }
}
