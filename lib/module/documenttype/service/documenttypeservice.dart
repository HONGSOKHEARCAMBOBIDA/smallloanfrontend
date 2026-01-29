import 'package:loanfrontend/core/constant/api_endpoint.dart';
import 'package:loanfrontend/data/models/documenttypemodel.dart';
import 'package:loanfrontend/data/providers/api_provider.dart';

class Documenttypeservice {
  final ApiProvider apiProvider = ApiProvider();
  Future<List<Data>> getdocumenttype() async {
    try {
      final response = await apiProvider.get(ApiEndpoint.viewdocumenttype);
      if (response.statusCode == 200) {
        final json = response.data;
        final model = DocumentTypeMode.fromJson(json);
        return model.data ?? [];
      } else {
        throw Exception("Failed ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed ${e.toString()}");
    }
  }
}
