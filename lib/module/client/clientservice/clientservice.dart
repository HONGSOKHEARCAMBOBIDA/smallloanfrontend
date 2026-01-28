import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loanfrontend/core/constant/api_endpoint.dart';
import 'package:loanfrontend/data/models/clientlistmodel.dart';
import 'package:loanfrontend/data/models/clientmodel.dart' as clientmodel;
import 'package:loanfrontend/data/providers/api_provider.dart';

class ClientService {
  final ApiProvider apiProvider = ApiProvider();

  Future<bool> createclient({
    required String idempotency,
    required String name,
    required int gender,
    required String maritalStatus,
    required String dateOfBirth,
    required String occupation,
    required String idCardNumber,
    required String phone,
    required int villageId,
    String? notes,
    XFile? clientImage,
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
          if (kIsWeb)
            'clientimage': MultipartFile.fromBytes(
              await clientImage.readAsBytes(),
              filename: clientImage.name,
            )
          else
            'clientimage': await MultipartFile.fromFile(
              clientImage.path,
              filename: clientImage.name,
            ),
      });
      final response = await apiProvider.post(ApiEndpoint.addClient, formData,
          idempotency: idempotency);
      return response.statusCode == 200 || response.statusCode == 201;
    } on DioException catch (e) {
      throw Exception(e.response?.data ?? "Network error");
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }

  Future<List<Data>> listclient(
      {String? name, int? page, int? pageSize}) async {
    try {
      final params = <String, dynamic>{};
      if (name != null && name.isNotEmpty) params['name'] = name;
      if (page != null) params['page'] = page;
      if (pageSize != null) params['pageSize'] = pageSize;

      final response = await apiProvider.get(
        'listclient',
        queryParameters: params.isNotEmpty ? params : null,
      );

      if (response.statusCode == 200) {
        final json = response.data;
        final model = ListClientModel.fromJson(json);
        return model.data ?? [];
      } else {
        throw Exception("Failed ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed ${e.toString()}");
    }
  }

  Future<List<clientmodel.Data>> getclientforcreateloan() async {
    try {
      final response = await apiProvider.get(ApiEndpoint.viewClient);
      if (response.statusCode == 200) {
        final json = response.data;
        final model = clientmodel.ViewClientModel.fromJson(json);
        return model.data ?? [];
      } else {
        throw Exception("Failed ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed ${e.toString()}");
    }
  }

  Future<bool> updateclient({
    required int id,
    required String name,
    required int gender,
    required String maritalStatus,
    required String dateOfBirth,
    required String occupation,
    required String idCardNumber,
    required String phone,
    required int villageId,
    String? notes,
    XFile? clientImage,
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
          if (kIsWeb)
            'clientimage': MultipartFile.fromBytes(
              await clientImage.readAsBytes(),
              filename: clientImage.name,
            )
          else
            'clientimage': await MultipartFile.fromFile(
              clientImage.path,
              filename: clientImage.name,
            ),
      });
      final response = await apiProvider.put(
        ApiEndpoint.editClient(id),
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
