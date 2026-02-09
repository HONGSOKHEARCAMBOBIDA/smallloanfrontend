import 'package:loanfrontend/core/constant/api_endpoint.dart';
import 'package:loanfrontend/data/models/loanapprovemodel.dart' as modelapprove;
import 'package:loanfrontend/data/models/loancheckmodel.dart';
import 'package:loanfrontend/data/models/loanmodel.dart' as loanmodel;
import 'package:loanfrontend/data/providers/api_provider.dart';

class Loanservice {
  final ApiProvider apiProvider = ApiProvider();

  Future<bool> createloan({
    required int clientid,
    required int loanproductid,
    required double loanamount,
    required String purpose,
    required int documenttypeid,
    required int checkby,
    required int approveby,
    required List<Map<String, dynamic>> guarantors,
  }) async {
    try {
      final body = {
        'client_id': clientid,
        'loan_product_id': loanproductid,
        'loan_amount': loanamount,
        'purpose': purpose,
        'document_type_id': documenttypeid,
        'check_by_id': checkby,
        'approve_by_id': approveby,
        'guarantor_id': guarantors,
      };

      final response = await apiProvider.post(ApiEndpoint.createloan, body);

      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      throw Exception("Create loan failed: $e");
    }
  }

  Future<List<Data>> getloanforcheck() async {
    try {
      final response = await apiProvider.get(ApiEndpoint.getloanforcheck);
      if (response.statusCode == 200) {
        final json = response.data;
        final model = LoanCheckModel.fromJson(json);
        return model.data ?? [];
      } else {
        throw Exception("Failed ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed ${e.toString()}");
    }
  }

  Future<List<modelapprove.Data>> getloanforapprove() async {
    try {
      final response = await apiProvider.get(ApiEndpoint.getloanforapprove);
      if (response.statusCode == 200) {
        final json = response.data;
        final model = modelapprove.Loanapprovemodel.fromJson(json);
        return model.data ?? [];
      } else {
        throw Exception("Failed ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed ${e.toString()}");
    }
  }

  Future<bool> checkloan(id) async {
    try {
      final response = await apiProvider.put(ApiEndpoint.checkloan(id), 1);
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception("Failed ${response.data}");
      }
    } catch (e) {
      throw Exception("Failed ${e.toString()}");
    }
  }

  Future<bool> approveloan(id) async {
    try {
      final response = await apiProvider.put(ApiEndpoint.approveloan(id), 1);
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception("Failed ${response.data}");
      }
    } catch (e) {
      throw Exception("Failed ${e.toString()}");
    }
  }

  Future<List<loanmodel.Data>> getloan(
      {String? name, String? startdate, int? page, int? pageSize}) async {
    try {
      final params = <String, dynamic>{};
      if (name != null && name.isNotEmpty) params['name'] = name;
      if (startdate != null) params['start'] = startdate;
      if (page != null) params['page'] = page;
      if (pageSize != null) params['pageSize'] = pageSize;
      final response = await apiProvider.get(ApiEndpoint.viewloan,
          queryParameters: params.isNotEmpty ? params : null);
      if (response.statusCode == 200) {
        final json = response.data;
        final model = loanmodel.LoanModel.fromJson(json);
        return model.data ?? [];
      } else {
        throw Exception("Failed ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed ${e.toString()}");
    }
  }

  Future<bool> deleteLoanbeforapprove({required int id}) async {
    try {
      final isdelete =
          await apiProvider.delete(ApiEndpoint.deleteLoanbeforapprove(id));
      return isdelete.statusCode == 200 || isdelete.statusCode == 201;
    } catch (e) {
      throw Exception("Failed ${e.toString()}");
    }
  }
}
