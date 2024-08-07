import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  String? labelText;
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
      controller: controller,
      validator: (input) {
        if (labelText == "Email" || labelText == "Enter your email") {
          return input!.isValidEmail() ? null : "Check your email";
        } else  {
          return input!.isNotEmpty ? null : "Required";
        }
      },
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

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}
