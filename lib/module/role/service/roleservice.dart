import 'package:dio/dio.dart';
import 'package:loanfrontend/core/constant/api_endpoint.dart';
import 'package:loanfrontend/data/models/rolemodel.dart';
import 'package:loanfrontend/data/models/rolepermission.dart' as mymodel;
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

  Future<List<mymodel.Data>> getroleassignpermission(int id) async {
    try {
      final response =
          await apiProvider.get(ApiEndpoint.viewrolehaspermission(id));

      if (response.statusCode == 200) {
        final json = response.data;
        final model = mymodel.RolePermissionModel.fromJson(json);
        return model.data ?? [];
      } else {
        throw Exception('Failed to load roles: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Failed: ${e.toString()}');
    } catch (e) {
      throw Exception('Failed to load roles: ${e.toString()}');
    }
  }
}
