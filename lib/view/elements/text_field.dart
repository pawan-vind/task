import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  final String? labelText;
  final Widget? prefixIcon;
  final Color? color;
  final bool? isEmailfield;
  final TextEditingController? controller;
  final TextInputFormatter? formatter;
  final TextInputType? keyboardType;
  final bool? isFirstName;
  final bool? isLastName;
  final bool? isBusinessName;
  final bool? isContact;
  final bool? isPhoneFormatter;
  final bool? isEnable;

  CustomTextField(
      {super.key,
      this.labelText,
      this.prefixIcon,
      this.color,
      this.controller,
      this.formatter,
      this.isEmailfield = false,
      this.isPhoneFormatter,
      this.keyboardType,
      this.isFirstName = false,
      this.isLastName = false,
      this.isBusinessName = false,
      this.isContact = false,
      this.isEnable = true});




  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: isEnable,
      // cursorColor: AppColors.customBlack,
      controller: controller,
      decoration: InputDecoration(
        fillColor: color,
        filled: true,
        labelText: labelText,
        prefixIcon: prefixIcon,
        labelStyle: TextStyle(color: Colors.grey.shade400),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: Colors.grey.shade200,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: Colors.grey.shade200,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: Colors.grey.shade200,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: Colors.red.shade200,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      keyboardType: keyboardType,
    );
  }
}