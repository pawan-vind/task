

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/retrofit/local/local_services.dart';
import 'package:task/routing/routes.dart';
import 'package:task/view/auth/sign_in/signin.dart';

import 'sign_up/signup.dart';

class MainAuth extends StatefulWidget {
  @override
  _MainAuthState createState() => _MainAuthState();
}

class _MainAuthState extends State<MainAuth> with SingleTickerProviderStateMixin{
   late TabController tabController;
     int tabValue = 0;
     @override
       void initState() {
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      setState(() {});
    });
    super.initState();
  } 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
             resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 100
                ),
                TabBar(
                   indicatorColor: Colors.blue,
                  dividerColor: Colors.grey,
                  padding: EdgeInsets.zero,
                  indicatorPadding: EdgeInsets.zero,
                  onTap: (value) {
                    setState(
                      () {
                        tabValue = value;
                      },
                    );
                  },
                  isScrollable: true,
                  controller: tabController,
                  unselectedLabelColor: Colors.black,
                  tabAlignment: TabAlignment.start,
                  tabs: const [
                    Text("Sign In"),
                    Text("Sign Up")
                  ],
                ),
                Expanded(
                flex: 5,
                  child: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: tabController,
                    children:  [
                      Signin(),
                      const SignUp()
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
