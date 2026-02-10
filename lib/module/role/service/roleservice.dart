import 'package:loanfrontend/core/constant/api_endpoint.dart';
import 'package:loanfrontend/data/models/rolemodel.dart';
import 'package:loanfrontend/data/providers/api_provider.dart';

class Roleservice {
  final ApiProvider apiProvider = ApiProvider();
  Future<List<Data>> getrole() async {
    try {
      final res = await apiProvider.get(ApiEndpoint.viewrole);
      if (res.statusCode == 200) {
        final model = RoleModel.fromJson(res.data);
        return model.data ?? [];
      } else {
        throw Exception("Failed ${res.statusCode}");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
