import 'package:flutter/material.dart';
import 'package:task/constants/colors.dart';

class PasswordTextField extends StatefulWidget {
  final String hintText;
  final bool? isPasswordfield;
  final TextEditingController textEditingController;
  const PasswordTextField(
      {super.key,
      required this.hintText,
      required this.textEditingController,
      this.isPasswordfield});

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return "Password is Empty";
        } else {
          return null;
        }
      },
      controller: widget.textEditingController,
      obscureText: _isObscure,
      decoration: InputDecoration(
        suffixIcon: InkWell(
            onTap: () {
              _isObscure = !_isObscure;
              setState(() {});
            },
            child: _isObscure
                ? const Icon(
                    Icons.visibility,
                    color: AppColors.greyColor,
                  )
                : const Icon(
                    Icons.visibility_off,
                    color: AppColors.greyColor,
                  )),
        labelText: widget.hintText,
        labelStyle: TextStyle(color: Colors.grey.shade400),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: Colors.grey.shade200,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: Colors.grey.shade200,
          ),
        ),
      ),
      style: const TextStyle(
        fontSize: 16.0,
        color: Colors.black,
      ),
    );
  }
}
