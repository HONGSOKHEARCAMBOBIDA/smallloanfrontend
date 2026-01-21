import 'package:loanfrontend/core/constant/api_endpoint.dart';
import 'package:loanfrontend/data/models/communcemodel.dart';
import 'package:loanfrontend/data/providers/api_provider.dart';

class Communceservice {
  final ApiProvider apiProvider = ApiProvider();
  Future<List<Data>> getcommunce(int districtid) async {
    try {
      final response =
          await apiProvider.get(ApiEndpoint.viewCommunce(districtid));
      if (response.statusCode == 200) {
        final json = response.data;
        final model = CommunceModel.fromJson(json);
        return model.data ?? [];
      } else {
        throw Exception(
          'Faild to get communce Message ${response.statusMessage}',
        );
      }
    } catch (e) {
      throw Exception('Fiald ${e.toString()}');
    }
  }
}
