import 'package:loanfrontend/core/constant/api_endpoint.dart';
import 'package:loanfrontend/data/models/paymentschedule.dart';
import 'package:loanfrontend/data/providers/api_provider.dart';

class Paymentscheduleservice {
  final ApiProvider apiProvider = ApiProvider();
  Future<Data?> getPaymentSchedule(int id) async {
    try {
      final res = await apiProvider.get(ApiEndpoint.viewschedule(id));

      if (res.statusCode == 200) {
        final model = PaymentSchedule.fromJson(res.data);
        return model.data;
      } else {
        throw Exception('Failed ${res.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed ${e.toString()}');
    }
  }
}
