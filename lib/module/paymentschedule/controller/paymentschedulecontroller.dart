import 'package:get/get.dart';
import 'package:loanfrontend/data/models/paymentschedule.dart';
import 'package:loanfrontend/module/paymentschedule/service/paymentscheduleservice.dart';
import 'package:loanfrontend/share/widgets/snackbar.dart';

class Paymentschedulecontroller extends GetxController {
  final Paymentscheduleservice service = Paymentscheduleservice();
  var paymentschedule = Rx<Data?>(null);
  Future<void> getPaymentSchedule(int id) async {
    try {
      final result = await service.getPaymentSchedule(id);
      paymentschedule.value = result; // just assign the single Data
    } catch (e) {
      CustomSnackbar.error(title: "ខុសប្រក្រតី", message: e.toString());
    }
  }
}
