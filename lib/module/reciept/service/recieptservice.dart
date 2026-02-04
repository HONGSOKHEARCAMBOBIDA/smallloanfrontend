import 'package:loanfrontend/core/constant/api_endpoint.dart';
import 'package:loanfrontend/data/models/recieptmodel.dart';
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

  Future<List<Data>> getreciept(
      {String? client_name,
      String? village_name,
      int? page,
      int? pageSize}) async {
    try {
      final params = <String, dynamic>{};
      if (client_name != null && client_name.isNotEmpty)
        params['client_name'] = client_name;
      if (page != null) params['page'] = page;
      if (pageSize != null) params['pageSize'] = pageSize;
      final response = await apiProvider.get(ApiEndpoint.viewreciept,
          queryParameters: params.isNotEmpty ? params : null);
      if (response.statusCode == 200) {
        final json = response.data;
        final model = RecieptModel.fromJson(json);
        return model.data ?? [];
      } else {
        throw Exception("Failed ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed ${e.toString()}");
    }
  }
}
