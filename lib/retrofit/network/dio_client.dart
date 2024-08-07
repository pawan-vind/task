// ignore_for_file: avoid_single_cascade_in_expression_statements, avoid_print

import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:task/retrofit/network/exceptions/dio_network_exception_manager.dart';
import 'api_endpoints.dart';

class DioClient {


  final Dio _dio = Dio();

  DioClient({String? authToken}) {
    _dio
      ..options.baseUrl = AppApiEndpoints.baseUrl
      ..options.connectTimeout = const Duration(minutes: 1)
      ..options.receiveTimeout = const Duration(minutes: 1)
      ..httpClientAdapter
      ..options.responseType = ResponseType.json;

    if (authToken != null) {
      _dio
        ..options.headers = {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $authToken',
        };
    } else {
      _dio
        ..options.headers = {
          'Content-Type': 'application/json; charset=UTF-8',
        };
    }

    if (kDebugMode) {
      _dio.interceptors.add(LogInterceptor(
          responseBody: true,
          error: true,
          requestHeader: true,
          responseHeader: true,
          request: true,
          requestBody: true));
    }
  }

  Future<dynamic> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    log("GET URL -- $uri");
    log("GET QUERY PARAMETERS -- $queryParameters");
    log("GET OPTIONS -- $options");
    log("GET CANCEL -- $cancelToken");
    log("GET ON RECEIVE PROGRESS -- $onReceiveProgress");
    try {
      var response = await _dio.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      if (e is DioException) {
        String error = DioNetworkExceptionsManager.getDioException(e);

        throw error;
      } else {
        rethrow;
      }
    }
  }

  Future<dynamic> post(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    log("POST URL --- $uri");
    log("POST HEADER --- ${_dio.options.headers}");
    log("POST DATA --- $data");
    log("POST QUERY PARAMETERS --- $queryParameters");
    log("POST OPTIONS --- $options");
    log("POST CANCEL TOKEN --- $cancelToken");
    log("POST ON SEND PROGRESS --- $onSendProgress");
    log("POST ON RECEIVED PROGRESS --- $onReceiveProgress");
    try {
      Response response = await _dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      print("POST RESPONSE CODE -- ${response.statusCode}");
      print("POST RESPONSE -- $response");
      return response.data;
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      if (e is DioException) {
        String error = DioNetworkExceptionsManager.getDioException(e);

        throw error;
      } else {
        rethrow;
      }
      // throw error;
    }
  }

  Future<dynamic> put(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      Response response = await _dio.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      if (e is DioException) {
        String error = DioNetworkExceptionsManager.getDioException(e);

        throw error;
      } else {
        rethrow;
      }
    }
  }
}