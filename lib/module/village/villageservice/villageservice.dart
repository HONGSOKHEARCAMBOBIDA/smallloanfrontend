import 'package:loanfrontend/core/constant/api_endpoint.dart';
import 'package:loanfrontend/data/models/villagemodel.dart';
import 'package:loanfrontend/data/providers/api_provider.dart';

class Villageservice {
  final ApiProvider apiProvider = ApiProvider();

  Future<List<Data>> getvillage(int communceid) async {
    try {
      final response =
          await apiProvider.get(ApiEndpoint.viewVillage(communceid));
      if (response.statusCode == 200) {
        final json = response.data;
        final model = VillageModel.fromJson(json);
        return model.data ?? [];
      } else {
        throw Exception(
          'Faild to load village: status code ${response.statusCode},Message: ${response.statusMessage}',
        );
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
