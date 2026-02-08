import 'package:loanfrontend/core/constant/api_endpoint.dart';
import 'package:loanfrontend/data/models/balanchsheetmodel.dart' as model;
import 'package:loanfrontend/data/models/incomestatementmodel.dart'
    as incomestatementmodel;
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
      required String transaction_date,
      required int chart_account_id,
      required double debit_amount,
      required double credit_amount,
      required String description}) async {
    try {
      final body = {
        'transaction_date': transaction_date,
        'chart_account_id': chart_account_id,
        'debit_amount': debit_amount,
        'credit_amount': credit_amount,
        'description': description
      };
      final res = await apiProvider.put(ApiEndpoint.editjournal(id), body);
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

  Future<model.BalanchsheetModel?> getBalanceSheet(
      {required String? enddate}) async {
    try {
      final params = <String, dynamic>{};
      if (enddate != null && enddate.isNotEmpty) {
        params['end'] = enddate;
      }
      final res = await apiProvider.get(
        ApiEndpoint.viewbalancesheetperiod, // Add this endpoint
        queryParameters: params.isNotEmpty ? params : null,
      );
      if (res.statusCode == 200) {
        final json = res.data;
        final balanceSheet = model.BalanchsheetModel.fromJson(json);
        return balanceSheet;
      } else {
        throw Exception("Failed to fetch balance sheet: ${res.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed to fetch balance sheet: ${e.toString()}");
    }
  }

  Future<incomestatementmodel.Data?> getincomestatement(
      {required String? enddate}) async {
    try {
      final param = <String, dynamic>{};
      if (enddate != null && enddate.isNotEmpty) {
        param['end'] = enddate;
      }
      final res = await apiProvider.get(ApiEndpoint.incomestatement,
          queryParameters: param.isNotEmpty ? param : null);
      if (res.statusCode == 200) {
        final json = res.data;
        final incomestatement =
            incomestatementmodel.IncomeStateMenModel.fromJson(json);
        return incomestatement.data;
      } else {
        throw Exception("Faild to get incomestaement");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
