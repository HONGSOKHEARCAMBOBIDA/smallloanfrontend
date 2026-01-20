import 'package:get_storage/get_storage.dart';

String? getToken() {
  final box = GetStorage();
  return box.read('token');
}