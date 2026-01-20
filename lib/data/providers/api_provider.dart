import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart' as Getv;
import 'package:loanfrontend/core/constant/constants.dart';

class ApiProvider {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "${Appconstants.baseUrl}",
    ),
  );

  final GetStorage _box = GetStorage();
  bool _isLoggingOut = false;
  ApiProvider() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onError: (error, handler) async {
          if (!_isLoggingOut && (error.response?.statusCode == 403)) {
            _isLoggingOut = true;

            _box.remove('token');

            Getv.Get.offAllNamed('/login');
          }
          handler.next(error);
        },
      ),
    );
  }
  String getToken() {
    return _box.read('token') ?? '';
  }

  Options _getOptions({Map<String, String>? extraHeaders}) {
    return Options(
      headers: {
        'Authorization': 'Bearer ${getToken()}',
        'Content-Type': 'application/json',
        ...?extraHeaders,
      },
      followRedirects: false,
      validateStatus: (status) =>
          status != null && status >= 200 && status < 300,
    );
  }

  Future<Response> post(
    String endpoint,
    dynamic data,
    //មានន័យថា function នោះកំពុងធ្វើការ asynchronous call
  ) async {
    try {
      //  print("POST Request: $endpoint, Data: $data");
      final response = await _dio.post(
        endpoint.startsWith('/') ? endpoint : '/$endpoint',
        data: data,
        options: _getOptions(),
      );
      //  print("Response: ${response.data}");
      return response;
    } catch (e) {
      print("Error: $e");
      return _handleError(e);
    }
  }

  Future<Response> postbutdelete(String endpoint, dynamic data,
      {Map<String, String>? headers}) async {
    try {
      //  print("POST Request: $endpoint, Data: $data");
      final response = await _dio.delete(
        endpoint.startsWith('/') ? endpoint : '/$endpoint',
        data: data,
        options: _getOptions(extraHeaders: headers),
      );
      //  print("Response: ${response.data}");
      return response;
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<Response> get(String endpoint,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      //  print("GET Request: $endpoint, Params: $queryParameters");
      final response = await _dio.get(
        endpoint.startsWith('/') ? endpoint : '/$endpoint',
        queryParameters: queryParameters,
        options: _getOptions(),
      );
      //  print("Response: ${response.data}");
      return response;
    } catch (e) {
      print("Error: $e");
      return _handleError(e);
    }
  }

  Future<Response> put(
    String endpoint,
    dynamic data,
  ) async {
    try {
      //  print("PUT Request: $endpoint, Data: $data");
      final response = await _dio.put(
        endpoint.startsWith('/') ? endpoint : '/$endpoint',
        data: data,
        options: _getOptions(),
      );
      //  print("Response: ${response.data}");
      return response;
    } catch (e) {
      print("Error: $e");
      return _handleError(e);
    }
  }

  Future<Response> delete(String endpoint) async {
    try {
      //  print("DELETE Request: $endpoint");
      final response = await _dio.delete(
        endpoint.startsWith('/') ? endpoint : '/$endpoint',
        options: _getOptions(),
      );
      //   print("Response: ${response.data}");
      return response;
    } catch (e) {
      print("Error: $e");
      return _handleError(e);
    }
  }

  Response _handleError(dynamic error) {
    if (error is DioException) {
      return Response(
        requestOptions: error.requestOptions, // Fix: Use actual requestOptions
        statusCode: error.response?.statusCode ?? 500,
        data: {"error": error.response?.data ?? error.message},
      );
    }
    return Response(
      requestOptions: RequestOptions(path: ""),
      statusCode: 500,
      data: {"error": "Unexpected error occurred"},
    );
  }
}
