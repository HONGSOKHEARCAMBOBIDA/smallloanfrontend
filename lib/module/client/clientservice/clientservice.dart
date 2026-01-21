import 'dart:io';
import 'package:dio/dio.dart';
import 'package:loanfrontend/core/constant/api_endpoint.dart';
import 'package:loanfrontend/data/providers/api_provider.dart';
class ClientService {
  final ApiProvider apiProvider = ApiProvider();

  Future<bool> createclient({
    required String name,
    required int gender,
    required String maritalStatus,
    required String dateOfBirth,
    required String occupation,
    required String idCardNumber,
    required String phone,
    required int villageId,
    String? notes,
    File? clientImage,
  }) async {
    try {
      final formData = FormData.fromMap({
        'name': name,
        'gender': gender,
        'marital_status': maritalStatus,
        'date_of_birth': dateOfBirth,
        'occupation': occupation,
        'id_card_number': idCardNumber,
        'phone': phone,
        'village_id': villageId,
        'notes': notes,
        if (clientImage != null)
          'clientimage': await MultipartFile.fromFile(
            clientImage.path,
            filename: clientImage.path.split('/').last,
          ),
      });
      final response = await apiProvider.post(
        ApiEndpoint.addClient,
        formData,
      );
      return response.statusCode == 200 || response.statusCode == 201;
    } on DioException catch (e) {
      throw Exception(e.response?.data ?? "Network error");
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }
}
