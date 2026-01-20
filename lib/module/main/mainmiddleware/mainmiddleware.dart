import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MainMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final box = GetStorage();
    final token = box.read("token");

    // Redirect to login if token is null or empty
    if (token == null || token.toString().isEmpty) {
      return const RouteSettings(name: '/login');
    }
    return null; // No redirect
  }
}