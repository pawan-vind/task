import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/constants/colors.dart';
import 'package:task/constants/testStyling.dart';
import 'package:task/view/elements/button.dart';

import '../../../controller/auth/auth_controller.dart';
import '../../elements/password_field.dart';
import '../../elements/text_field.dart';

class Signin extends StatefulWidget {
  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  TextEditingController passwordField = TextEditingController();
  TextEditingController emailController = TextEditingController();
    AuthController authController = Get.put(AuthController());
      final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Obx(() {
          return authController.isLoading.value ?
          const Center(child: CircularProgressIndicator(),)
           : Form(
            key: _formKey,
             child: SingleChildScrollView(
               child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: emailController,
                    color: Colors.transparent,
                    labelText: "Enter your email",
                  ),
                  const SizedBox(height: 10),
                  PasswordTextField(
                    hintText: "Enter your password",
                    isPasswordfield: true,
                    textEditingController: passwordField,
                  ),
                  const SizedBox(height: 20),
                  CustomLongButton(
                    name: "Login",
                    ontap: () {
                      if(_formKey.currentState!.validate()){
               authController.loginApi(context, emailController.text, passwordField.text);
                      }
                      
                    },
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Forgot Password?'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 60,
                        height: 1,
                        color: AppColors.black,
                      ),
                      const SizedBox(width: 10),
                      const Text('Or signin with'),
                      const SizedBox(width: 10),
                      Container(
                        width: 60,
                        height: 1,
                        color: AppColors.black,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.g_translate),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.facebook),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.apple),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(text: 'Don’t have a Account? ',
                             style: AppStyling.blackF12W400,
                            ),
                            TextSpan(
                              text: 'Sign up',
                              style: AppStyling.darkblueF12W400,
                              recognizer: TapGestureRecognizer()..onTap = (){
                                
                              }
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
                         ),
             ),
           );
        }
      ),
    );
  }
}
