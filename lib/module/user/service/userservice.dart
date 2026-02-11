import 'package:loanfrontend/core/constant/api_endpoint.dart';
import 'package:loanfrontend/data/models/usermodel.dart';
import 'package:loanfrontend/data/providers/api_provider.dart';

class Userservice {
  final ApiProvider apiProvider = ApiProvider();
  Future<bool> register(
      {required String name,
      required String password,
      required int roleid,
      required String phone}) async {
    try {
      final body = {
        'name': name,
        'password': password,
        'role_id': roleid,
        'phone': phone
      };
      final res = await apiProvider.post(ApiEndpoint.register, body);
      return res.statusCode == 200 || res.statusCode == 201;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<Data>> getuser() async {
    try {
      final response = await apiProvider.get(ApiEndpoint.viewuser);
      if (response.statusCode == 200) {
        final json = response.data;
        final model = UserModel.fromJson(json);
        return model.data ?? [];
      } else {
        throw Exception("Failed ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed ${e.toString()}");
    }
  }

  Future<bool> updateuser(
      {required int id,
      required String name,
      required String username,
      required int role_id,
      required String email,
      required String phone}) async {
    try {
      final body = {
        'name': name,
        'username': username,
        'role_id': role_id,
        'email': email,
        'phone': phone
      };
      final res = await apiProvider.put(ApiEndpoint.updateuser(id), body);
      return res.statusCode == 200 || res.statusCode == 201;
    } catch (e) {
      throw Exception("Failed ${e.toString()}");
    }
  }

  Future<bool> changestatususer({required int id}) async {
    try {
      final update = await apiProvider.put(ApiEndpoint.changestatususer(id), 1);
      return update.statusCode == 200 || update.statusCode == 201;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
