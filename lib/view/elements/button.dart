// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:task/constants/colors.dart';
import 'package:task/constants/testStyling.dart';

// ignore: must_be_immutable
class CustomLongButton extends StatelessWidget {
  final void Function()? ontap;
  final String name;
  bool? isLoading;

  Color? buttonColor;

  CustomLongButton(
      {super.key,
      required this.ontap,
      required this.name,
      this.isLoading = false,
      this.buttonColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: ontap,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              buttonColor ?? AppColors.darkblue),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            // ignore: prefer_const_constructors

            const EdgeInsets.symmetric(vertical: 14.0, horizontal: 14.0),
          ),
          shape: (isLoading != null && isLoading == true)
              ? MaterialStateProperty.all(const CircleBorder())
              : MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
        ),
        child: (isLoading != null && isLoading == true)
            ? const SizedBox(
                // height: 35,
                // width: 70,
                child: Center(child: CircularProgressIndicator()))
            : FittedBox(
                child: Text(name, style: AppStyling.textTabGreyF10W500),
              ),
      ),
    );
  }
}