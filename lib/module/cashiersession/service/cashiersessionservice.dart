import 'package:loanfrontend/core/constant/api_endpoint.dart';
import 'package:loanfrontend/data/models/cashiersession.dart';
import 'package:loanfrontend/data/providers/api_provider.dart';

class Cashiersessionservice {
  final ApiProvider apiProvider = ApiProvider();
  Future<bool> createcashiersession() async {
    try {
      final iscreate = await apiProvider.post(ApiEndpoint.addcashiersession, 1);
      return iscreate.statusCode == 200 || iscreate.statusCode == 201;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<Data>> getcashiersession() async {
    try {
      final res = await apiProvider.get(ApiEndpoint.viewcashiersession);
      if (res.statusCode == 200) {
        final json = res.data;
        final model = CashierSessionModel.fromJson(json);
        return model.data ?? [];
      } else {
        throw Exception("Failed ${res.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed ${e.toString()}");
    }
  }

  Future<List<Data>> getcashiersessionforrollback() async {
    try {
      final res =
          await apiProvider.get(ApiEndpoint.viewcashiersessionforrollback);
      if (res.statusCode == 200) {
        final json = res.data;
        final model = CashierSessionModel.fromJson(json);
        return model.data ?? [];
      } else {
        throw Exception("Failed ${res.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed ${e.toString()}");
    }
  }

  Future<bool> verify(int id) async {
    try {
      final verify =
          await apiProvider.put(ApiEndpoint.VerifyCashierSession(id), 1);
      return verify.statusCode == 200 || verify.statusCode == 201;
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }

  Future<bool> rollbackverify(int id) async {
    try {
      final rollback = await apiProvider.delete(
        ApiEndpoint.RollbackVerify(id),
      );
      return rollback.statusCode == 200 || rollback.statusCode == 201;
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }
}
