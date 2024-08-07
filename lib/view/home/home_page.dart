import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/constants/colors.dart';
import 'package:task/constants/testStyling.dart';
import 'package:task/controller/auth/auth_controller.dart';
import 'package:task/controller/homePage/home_page_controler.dart';
import 'package:task/retrofit/local/local_db.dart';

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

  @override
  void initState() {
    super.initState();

    homePageControler.getUserList(homePageControler.currentPage.value);
  }

  @override
  Widget build(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        homePageControler.fetchMoreItems(homePageControler.currentPage.value);
      }
    });
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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${LocalDB.getString("fname")} ${LocalDB.getString("lname")}",
              style: AppStyling.blackF16W500,
            ),
            Text(
              LocalDB.getString('email'),
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
                child: const Icon(Icons.logout)),
          )
        ],
      ),
      body: Obx(() {
        return homePageControler.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : CustomRefreshIndicator(
                builder: (
                  BuildContext context,
                  Widget child,
                  IndicatorController controller,
                ) {
                  return Stack(
                    alignment: Alignment.topCenter,
                    children: <Widget>[
                      if (!controller.isIdle)
                        Positioned(
                          top: 35.0 * controller.value,
                          child: SizedBox(
                            height: 30,
                            width: 30,
                            child: CircularProgressIndicator(
                              color: AppColors.black,
                              value: !controller.isLoading
                                  ? controller.value.clamp(0.0, 1.0)
                                  : null,
                            ),
                          ),
                        ),
                      Transform.translate(
                        offset: Offset(0, 100.0 * controller.value),
                        child: child,
                      ),
                    ],
                  );
                },
                // backgroundColor: AppColors.customBlack,
                onRefresh: () async {
                  homePageControler
                      .getUserList(homePageControler.currentPage.value);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Obx(() {
                    return authController.isLoading.value
                        ? const Center(
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
                                                  homePageControler
                                                      .isGrid.value = false;
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
                                        controller: scrollController,
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
                                        itemCount: homePageControler
                                                .isScrollLoading.value
                                            ? homePageControler.userListModel!
                                                    .userList!.length +
                                                1
                                            : homePageControler.userListModel!
                                                .userList!.length,
                                        itemBuilder: (context, index) {
                                          if (index <
                                              homePageControler.userListModel!
                                                  .userList!.length) {
                                            UserList data = homePageControler
                                                .userListModel!
                                                .userList![index];
                                            return gridContainer(data);
                                          } else {
                                            return homePageControler
                                                    .isScrollLoading.value
                                                ? const Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom: 20),
                                                    child: Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  )
                                                : Container();
                                            // : Container();
                                          }
                                        },
                                      ),
                                    )
                                  : Expanded(
                                      child: ListView.builder(
                                        controller: scrollController,
                                        itemCount: homePageControler
                                                .isScrollLoading.value
                                            ? homePageControler.userListModel!
                                                    .userList!.length +
                                                1
                                            : homePageControler.userListModel!
                                                .userList!.length,
                                        physics:
                                            const AlwaysScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          if (index <
                                              homePageControler.userListModel!
                                                  .userList!.length) {
                                            UserList data = homePageControler
                                                .userListModel!
                                                .userList![index];
                                            return listContainer(data);
                                          } else {
                                            return homePageControler
                                                    .isScrollLoading.value
                                                ? const Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom: 20),
                                                    child: Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  )
                                                : Container();
                                            // : Container();
                                          }
                                        },
                                      ),
                                    ))
                            ],
                          );
                  }),
                ),
              );
      }),
    );
  }

  Widget gridContainer(UserList data) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.greyColor),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(data.firstName.toString()),
            const SizedBox(height: 5),
            Text(data.lastName.toString()),
            const SizedBox(height: 5),
            Text(overflow: TextOverflow.ellipsis, data.email.toString()),
            const SizedBox(height: 5),
            Text(data.phoneNo.toString()),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      // primary: Colors.transparent,
                      shadowColor: Colors.transparent.withOpacity(0.1),
                      side: const BorderSide(
                        // width: 2,
                        color: AppColors.darkblue,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'View Profile',
                      style: AppStyling.darkblueF12W400,
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
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      margin: const EdgeInsets.only(top: 10, bottom: 10),
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
                  Text("${data.email}   ${data.phoneNo}",
                      style: AppStyling.blackF12W400)
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(8),
                backgroundColor: Colors.transparent,
                elevation: 0,
                // primary: Colors.transparent,
                shadowColor: Colors.transparent.withOpacity(0.1),
                side: const BorderSide(
                  // width: 2,
                  color: AppColors.darkblue,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'View Profile',
                style: AppStyling.darkblueF12W400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
