import 'package:loanfrontend/core/constant/api_endpoint.dart';
import 'package:loanfrontend/data/providers/api_provider.dart';

class Recieptservice {
  final ApiProvider apiProvider = ApiProvider();
  Future<bool> createreciept({required int total, required int id}) async {
    try {
      final body = {'total_receipt': total};
      final res = await apiProvider.post(ApiEndpoint.addreciept(id), body);
      return res.statusCode == 200 || res.statusCode == 201;
    } catch (e) {
      throw Exception("Create loan failed: $e");
    }
  }
}
