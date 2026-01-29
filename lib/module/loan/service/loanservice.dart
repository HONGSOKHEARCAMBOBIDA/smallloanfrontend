import 'package:loanfrontend/core/constant/api_endpoint.dart';
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
}
