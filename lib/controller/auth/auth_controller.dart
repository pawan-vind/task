import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/utils/toast.dart';

import '../../model/login_model.dart';
import '../../model/register_model.dart';
import '../../retrofit/local/local_db.dart';
import '../../retrofit/local/local_services.dart';
import '../../retrofit/network/api_services.dart';
import '../../routing/routes.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;
  LoginModel? _loginModel;
  LoginModel? get loginModel => _loginModel;

  RegisterModel? _registerModel;
  RegisterModel? get registerModel => _registerModel;

  Future<LoginModel?> loginApi(BuildContext context, String email, String password) async {
    isLoading.value = true;
    try {
      var response = await ApiServices().login(
        {"email": email, "password": password},
      );

      _loginModel = LoginModel.fromJson(response);
      if (loginModel!.status == true) {
        LocalDB.saveString("token", _loginModel!.record!.authtoken!);
        LocalDB.saveString("fname", _loginModel!.record!.firstName!);
        LocalDB.saveString("lname", _loginModel!.record!.lastName!);
        LocalDB.saveString("email", _loginModel!.record!.email!);
        isLoading.value = false;
        UiUtils().showToast(context, _loginModel!.message!, Colors.green);
        Get.toNamed(Routes.homePage);
        return _loginModel;
      } else {
        isLoading.value = false;
        UiUtils().showToast(context, _loginModel!.message!, Colors.red);
        return null;
      }
    } catch (e) {
      isLoading.value = false;
      print(e);
      return null;
    }
  }

  Future<RegisterModel?> registerApi(
    BuildContext context,
      String firstName,
      String lastName,
      String phoneNumber,
      String password,
      String confirmPassword,
      String email) async {
    isLoading.value = true;
    try {
      var response = await ApiServices().register(
{
    "first_name":firstName,
    "last_name":lastName,
    "country_code":"+91",
    "phone_no":phoneNumber,
    "email":email,
    "password":password,
    "confirm_password":confirmPassword
}
      );

      _registerModel = RegisterModel.fromJson(response);
      if (_registerModel!.status == true) {
        LocalDB.saveString("token", _registerModel!.data!.token!);
        
        isLoading.value = false;
         UiUtils().showToast(context, "Sucessfully Register, Please Login", Colors.green);
        Get.toNamed(Routes.mainAuth);

        return _registerModel;
      } else {
        UiUtils().showToast(context, _registerModel!.message!, Colors.red);
        isLoading.value = false;
        return null;
      }
    } catch (e) {
      isLoading.value = false;
      print(e);
      return null;
    }
  }

  Future logout(BuildContext context) async {
    isLoading.value = true;
    try {
      var response = await ApiServices().logout();
      if (response['status'] == true) {
        LocalServices.removeToken();
        UiUtils().showToast(context, response["message"], Colors.green);
        Get.offNamed(Routes.mainAuth);
      }else{
         isLoading.value = false;
         UiUtils().showToast(context, response["message"], Colors.red);
      }
      isLoading.value = false;
      return response['message'];
    } catch (e) {
      isLoading.value = false;
      print(e);
    }
    return null;
  }
}
