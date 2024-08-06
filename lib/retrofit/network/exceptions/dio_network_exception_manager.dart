import 'dart:io';
import 'package:dio/dio.dart';
import '../../common/response_common_model.dart';

class DioNetworkExceptionsManager {
  static String getDioException(error) {
    if (error is Exception) {
      try {
        if (error is DioException) {
          switch (error.type) {
            case DioExceptionType.cancel:
              return 'Request is cancelled';
            case DioExceptionType.connectionTimeout:
              return 'Please try again request timed out';
            case DioExceptionType.unknown:
              return 'Please connect to internet';
            case DioExceptionType.receiveTimeout:
              return 'Request Timeout';
            case DioExceptionType.sendTimeout:
              return 'Request Timeout';
            default:
              {
                String errorMessage = '';
                ResponseCommonModel responseCommonModel =
                    ResponseCommonModel.fromJson(error.response?.data ?? {});
                if (responseCommonModel.exceptionMessage != null &&
                    responseCommonModel.exceptionMessage!.isNotEmpty) {
                  return responseCommonModel.exceptionMessage!;
                }

                switch (error.response!.statusCode!) {
                  case 400:
                    errorMessage = 'Unauthorized request session is expired';
                    break;
                  case 401:
                    errorMessage = 'User credentials are not valid';
                    break;
                  case 403:
                    errorMessage = 'Unauthorized request session is expired';
                    break;
                  case 404:
                    errorMessage = 'Not found';
                    break;
                  case 409:
                    errorMessage = 'Not found';
                    break;
                  case 408:
                    errorMessage = 'Request Timeout';
                    break;
                  case 500:
                    errorMessage = 'something wrong on our side';
                    break;
                  case 503:
                    errorMessage = 'Service is not available at this time';
                    break;
                  default:
                    errorMessage = 'Some thing wrong at our end';
                }
                return errorMessage;
              }
          }
        } else if (error is SocketException) {
          return 'Please check your internet connection';
        } else {
          return 'Please try again later';
        }
      } on FormatException {
        return 'Format Exception';
      } catch (_) {
        return 'Something went wrong';
      }
    } else {
      if (error.toString().contains("is not a subtype of")) {
        return 'Unable to process the request ';
      } else {
        return error.error ?? 'Something went wrong';
      }
    }
  }
}