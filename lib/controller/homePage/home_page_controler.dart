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
  RxBool isScrollLoading = false.obs;
  RxInt currentPage = 1.obs;
  var reachedEnd = false.obs;

  UserListModel? _userListModel;
  UserListModel? get userListModel => _userListModel;

  UserListModel? _useraddListModel;
  UserListModel? get useraddListModel => _useraddListModel;
  List<UserList>? userList;

  @override
  void onInit() {
    super.onInit();
    fetchMoreItems(currentPage.value);
  }

  fetchMoreItems(int page) async {
    isScrollLoading.value = true;
    try {
      var response = await ApiServices().userList(page: page);
 _useraddListModel = UserListModel.fromJson(response);
      if (_userListModel!.status == true) {
        for (int i = 0; i < _useraddListModel!.userList!.length; i++) {
          _userListModel!.userList!.add(_useraddListModel!.userList![i]);
        }
        currentPage.value++;
        if (currentPage.value >= _userListModel!.lastPage!) {
          reachedEnd.value = true;
        }
        isScrollLoading.value = false;
        return _userListModel;
      } else {
        isScrollLoading.value = false;
        return null;
      }
    } catch (e) {
      isScrollLoading.value = false;
      print(e);
    }
  }

  Future<UserListModel?> getUserList(int page) async {
    isLoading.value = true;
    try {
      var response = await ApiServices().userList(page: page);

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
