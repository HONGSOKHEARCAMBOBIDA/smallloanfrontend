import 'package:loanfrontend/core/constant/api_endpoint.dart';
import 'package:loanfrontend/data/models/districtmodel.dart';
import 'package:loanfrontend/data/providers/api_provider.dart';

class Districtservice {
  final ApiProvider apiProvider = ApiProvider();
  Future<List<Data>> getdistrict(int provinceid) async {
    try {
      final response =
          await apiProvider.get(ApiEndpoint.viewDistrict(provinceid));
      if (response.statusCode == 200) {
        final json = response.data;
        final model = DistrictModel.fromJson(json);
        return model.data ?? [];
      } else {
        throw Exception('Faild ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Faild ${e.toString()}');
    }
  }
}
