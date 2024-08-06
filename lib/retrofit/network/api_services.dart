// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:task/retrofit/local/local_services.dart';
import 'api_endpoints.dart';
import '../../retrofit/network/dio_client.dart';

class ApiServices {
  DioClient dio = DioClient();

  var token = LocalServices.getToken();

  login(dynamic data) async {
    try {
      var response = await dio.post(
        AppApiEndpoints.loginUrl,
        data: jsonEncode(data),
      );
      if (response != null) {
        return response;
      }
    } catch (error) {
      rethrow;
    }
    return null;
  }

  register(dynamic data) async {
    try {
      var response = await dio.post(
        AppApiEndpoints.register,
        data: jsonEncode(data),
      );
      if (response != null) {
        return response;
      }
    } catch (error) {
      rethrow;
    }
    return null;
  }

  userList() async {
    try {
      var response = await dio.get(
        AppApiEndpoints.userList,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      if (response != null) {
        return response;
      }
    } catch (error) {
      rethrow;
    }
    return null;
  }

  logout() async {
    try {
      var response = await dio.get(
        AppApiEndpoints.logout,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return response;
    } catch (error) {
      // Handle errors
      print("Error updating user profile: $error");
      rethrow;
    }
  }

}