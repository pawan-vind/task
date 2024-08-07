import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/constants/colors.dart';
import 'package:task/constants/testStyling.dart';
import 'package:task/view/elements/button.dart';

import '../../../controller/auth/auth_controller.dart';
import '../../elements/password_field.dart';
import '../../elements/text_field.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController passwordField = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
      AuthController authController = Get.put(AuthController());
            final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Obx( () {
          return authController.isLoading.value ?
          const Center(child: CircularProgressIndicator(),):
           Form(
            key: _formKey,
             child: SingleChildScrollView(
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.start,
                 crossAxisAlignment: CrossAxisAlignment.end,
                 children: [
                  const SizedBox(height: 20),
                   CustomTextField(
                     controller: firstName,
                     color: Colors.transparent,
                     labelText: "First name",
                   ),
                   const SizedBox(height: 10),
                   CustomTextField(
                      controller: lastName,
                     color: Colors.transparent,
                     labelText: "Last name",
                   ),
                   const SizedBox(height: 10),
                   CustomTextField(
                      controller: phoneNumber,
                     color: Colors.transparent,
                     labelText: "Phone number",
                   ),
                   const SizedBox(height: 10),
                   CustomTextField(
                      controller: emailController,
                     color: Colors.transparent,
                     labelText: "Email",
                   ),
                   const SizedBox(height: 10),
                   PasswordTextField(
                     hintText: "Enter your password",
                     isPasswordfield: true,
                     textEditingController: passwordField,
                   ),
                   const SizedBox(height: 10),
                    PasswordTextField(
                     hintText: "Confirm password",
                     isPasswordfield: true,
                     textEditingController: confirmPassword,
                   ),
                   const SizedBox(height: 10),
                   CustomLongButton(
                     name: "Sign Up",
                     ontap: () {
                       if(_formKey.currentState!.validate()){
                       authController.registerApi(context, firstName.text, lastName.text, phoneNumber.text, passwordField.text, confirmPassword.text, emailController.text);
               
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
