import 'package:loanfrontend/core/constant/api_endpoint.dart';
import 'package:loanfrontend/data/models/loginmodel.dart';
import 'package:loanfrontend/data/models/usermodel.dart' as usermodel;
import 'package:loanfrontend/data/providers/api_provider.dart';

class AuthService {
  final ApiProvider apiProvider = ApiProvider();

  Future<LoginResModel> login(
      {required String username, required String password}) async {
    try {
      final body = {'username': username, 'password': password};

      final response = await apiProvider.post(
        "login",
        body,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return LoginResModel.fromJson(response.data);
      } else {
        throw Exception('Login failed: ${response.data}');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<usermodel.Data>> getuser() async {
    try {
      final response = await apiProvider.get(ApiEndpoint.viewuser);
      if (response.statusCode == 200) {
        final json = response.data;
        final model = usermodel.UserModel.fromJson(json);
        return model.data ?? [];
      } else {
        throw Exception("Failed ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed ${e.toString()}");
    }
  }
}
