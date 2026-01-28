import 'package:loanfrontend/core/constant/api_endpoint.dart';
import 'package:loanfrontend/data/models/loanproductmodel.dart';
import 'package:loanfrontend/data/providers/api_provider.dart';

class Loanproductservice {
  final ApiProvider apiProvider = ApiProvider();
  Future<List<Data>> getloanproduct() async {
    try {
      final response = await apiProvider.get(ApiEndpoint.loanproduct);
      if (response.statusCode == 200) {
        final json = response.data;
        final model = LoanProductModel.fromJson(json);
        return model.data ?? [];
      } else {
        throw Exception("Failed ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed ${e.toString()}");
    }
  }
}
