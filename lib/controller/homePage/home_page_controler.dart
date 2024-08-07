import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/state_manager.dart';
import 'package:task/model/user_list_model.dart';

import '../../retrofit/network/api_services.dart';

class HomePageControler extends GetxController {
  RxBool isGrid = false.obs;
  RxBool isLoading = false.obs;
  RxInt currentPage = 1.obs;
    var hasMoreData = true.obs; // Indicates if there is more data to load

  UserListModel? _userListModel;
  UserListModel? get userListModel => _userListModel;

  Future<UserListModel?> getUserList() async {
    isLoading.value = true;
    try {
      var response = await ApiServices().userList();

      _userListModel = UserListModel.fromJson(response);
      if (_userListModel!.status == true) {
        isLoading.value = false;
        return _userListModel;
      } else {
        isLoading.value = false;
        return null;
      }
    } catch (e) {
      isLoading.value = false;
      print(e);
      return null;
    }
  }
}
