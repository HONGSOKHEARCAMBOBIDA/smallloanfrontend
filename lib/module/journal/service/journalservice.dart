import 'package:loanfrontend/core/constant/api_endpoint.dart';
import 'package:loanfrontend/data/models/journalmodel.dart';
import 'package:loanfrontend/data/providers/api_provider.dart';

class Journalservice {
  final ApiProvider apiProvider = ApiProvider();
  Future<bool> createjournal(
      {required String date,
      required int debit_account_id,
      required int credit_account_id,
      required double amount,
      required String description}) async {
    try {
      final body = {
        'transaction_date': date,
        'debit_account_id': debit_account_id,
        'credit_account_id': credit_account_id,
        'amount': amount,
        'description': description
      };
      final res = await apiProvider.post(ApiEndpoint.addjournal, body);
      return res.statusCode == 200 || res.statusCode == 201;
    } catch (e) {
      throw Exception("Create journal failed: $e");
    }
  }

  Future<bool> updatejournal(
      {required int id,
      required String date,
      required int debit_account_id,
      required int credit_account_id,
      required double amount,
      required String description}) async {
    try {
      final body = {
        'transaction_date': date,
        'debit_account_id': debit_account_id,
        'credit_account_id': credit_account_id,
        'amount': amount,
        'description': description
      };
      final res = await apiProvider.post(ApiEndpoint.editjournal(id), body);
      return res.statusCode == 200 || res.statusCode == 201;
    } catch (e) {
      throw Exception("update journal failed: $e");
    }
  }

  Future<List<Data>> getjournal(
      {String? reference_code,
      String? between,
      int? page,
      int? pageSize}) async {
    try {
      final params = <String, dynamic>{};
      if (reference_code != null && reference_code.isNotEmpty)
        params['reference_code'] = reference_code;
      if (between != null && between.isNotEmpty) params['between'] = between;
      if (page != null) params['page'] = page;
      if (pageSize != null) params['pageSize'] = pageSize;
      final res = await apiProvider.get(ApiEndpoint.viewjournal,
          queryParameters: params.isNotEmpty ? params : null);
      if (res.statusCode == 200) {
        final json = res.data;
        final model = JournalModel.fromJson(json);
        return model.data ?? [];
      } else {
        throw Exception("Failed ${res.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed ${e.toString()}");
    }
  }

  Future<bool> deletejournal({required int id}) async {
    try {
      final isdelete = await apiProvider.delete(ApiEndpoint.deletejournal(id));
      return isdelete.statusCode == 200 || isdelete.statusCode == 201;
    } catch (e) {
      throw Exception("Failed ${e.toString()}");
    }
  }
}
