import 'package:loanfrontend/core/constant/api_endpoint.dart';
import 'package:loanfrontend/data/models/chataccountmodel.dart';
import 'package:loanfrontend/data/providers/api_provider.dart';

class Chartaccountservice {
  final ApiProvider apiProvider = ApiProvider();
  Future<List<Data>> getchataccount() async {
    try {
      final res = await apiProvider.get(ApiEndpoint.viewchartaccount);
      if (res.statusCode == 200 || res.statusCode == 201) {
        final json = res.data;
        final model = ChatAccountModel.fromJson(json);
        return model.data ?? [];
      } else {
        throw Exception("Failed ${res.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed ${e.toString()}");
    }
  }
}
