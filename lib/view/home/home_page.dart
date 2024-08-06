import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/constants/colors.dart';
import 'package:task/constants/testStyling.dart';
import 'package:task/controller/auth/auth_controller.dart';
import 'package:task/controller/homePage/home_page_controler.dart';

import '../../model/user_list_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomePageControler homePageControler = Get.put(HomePageControler());
  AuthController authController = Get.put(AuthController());
    final scrollController = ScrollController();
      int perPage = 10;

  bool isLoadingMore = false;

    fetchPendingReviewData() async {
    if (homePageControler.userListModel != null || isLoadingMore) {
      setState(() {
        isLoadingMore = true;
      });
      bool hasNewData = (await homePageControler.getUserList(page: homePageControler.currentPage.value)) as bool;
      if (hasNewData) {
        setState(() {
          isLoadingMore = false;
        });
      } else {
        homePageControler.currentPage.value -= 1;
        setState(() {
          isLoadingMore = false;
        });
      }
    }
  }

    Future<void> _scrollListener() async {
    if (isLoadingMore) return;

    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      setState(() {
        isLoadingMore = true;
      });

      homePageControler.currentPage.value += 1;
      await fetchPendingReviewData();
      setState(() {
        isLoadingMore = false;
      });
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(_scrollListener);
    homePageControler.getUserList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            // height: 35,
            // width: 35,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/images.jpg"),
                    fit: BoxFit.cover),
                shape: BoxShape.circle),
          ),
        ),
        title: Column(
          children: [
            Text(
              'Name',
              style: AppStyling.blackF12W400,
            ),
            Text(
              "email.ic",
              style: AppStyling.blackF12W400,
            )
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
                onTap: () {
                  authController.logout(context);
                },
                child: Icon(Icons.logout)),
          )
        ],
      ),
      body: Obx(() {
        return homePageControler.isLoading.value
            ?const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Obx(() {
                  return authController.isLoading.value
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Column(
                          children: [
                            const SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("User List"),
                                  Container(
                                    width: 100,
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(8)),
                                        border: Border.all(
                                            color: AppColors.greyColor)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Obx(() {
                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                homePageControler.isGrid.value =
                                                    false;
                                              },
                                              child: Icon(
                                                Icons.list,
                                                color: homePageControler
                                                            .isGrid.value ==
                                                        false
                                                    ? AppColors.darkblue
                                                    : AppColors.black,
                                              ),
                                            ),
                                            InkWell(
                                                onTap: () {
                                                  homePageControler
                                                      .isGrid.value = true;
                                                },
                                                child: Icon(
                                                  Icons.grid_4x4,
                                                  color: homePageControler
                                                          .isGrid.value
                                                      ? AppColors.darkblue
                                                      : AppColors.black,
                                                ))
                                          ],
                                        );
                                      }),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Obx(() => homePageControler.isGrid.value
                                ? Expanded(
                                    child: GridView.builder(
                                      controller: scrollController ,
                                      physics:
                                          const AlwaysScrollableScrollPhysics(),
                                      // shrinkWrap: true,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 3 / 3,
                                        crossAxisSpacing: 5,
                                        mainAxisSpacing: 5,
                                      ),
                                      itemCount: homePageControler.userListModel!.userList!.length,
                                      itemBuilder: (context, index) {
                                        UserList data = homePageControler.userListModel!.userList![index];
                                        return gridContainer(data);
                                      },
                                    ),
                                  )
                                : Expanded(
                                    child: ListView.builder(
                                      controller: scrollController ,
                                      itemCount: homePageControler.userListModel!.userList!.length,
                                      physics:
                                          const AlwaysScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        UserList data = homePageControler.userListModel!.userList![index];
                                        return listContainer(data);
                                      },
                                    ),
                                  ))
                          ],
                        );
                }),
              );
      }),
    );
  }

  Widget gridContainer(UserList data) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.greyColor),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(data.firstName.toString()),
            SizedBox(height: 5),
            Text(data.lastName.toString()),
            SizedBox(height: 5),
            Text(
              overflow: TextOverflow.ellipsis,
              data.email.toString()),
            SizedBox(height: 5),
            Text(data.phoneNo.toString()),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'View Profile',
                      style: AppStyling.darkblueF12W400,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      // primary: Colors.transparent,
                      shadowColor: Colors.transparent.withOpacity(0.1),
                      side: BorderSide(
                        // width: 2,
                        color: AppColors.darkblue,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget listContainer(UserList data) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.greyColor),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      margin: EdgeInsets.only(top: 10, bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${data.firstName} ${data.lastName}",
                    style: AppStyling.blackF12W400,
                  ),
                  Text(
                    "${data.email}   ${data.phoneNo}",
                      style: AppStyling.blackF12W400)
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text(
                'View Profile',
                style: AppStyling.darkblueF12W400,
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(8),
                backgroundColor: Colors.transparent,
                elevation: 0,
                // primary: Colors.transparent,
                shadowColor: Colors.transparent.withOpacity(0.1),
                side: BorderSide(
                  // width: 2,
                  color: AppColors.darkblue,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
