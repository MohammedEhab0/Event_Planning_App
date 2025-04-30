import 'package:event_planning_app/Utils/AppColors.dart';
import 'package:event_planning_app/Utils/AppStyle.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  bool?obscureText;
  Color? colorBorder;
  Color? cursorColor;
  String? hintText;
  TextStyle? hintTextStyle;
  int? maxLine;
  String? labelText;
  TextStyle? labelStyle;
  Color? prefixIconColor;
  Widget? prefixIcon;
  Color? suffixIconColor;
  Widget? suffixIcon;
  TextInputType? textInputType;
   TextEditingController? controller;
  String? Function(String?)? validator;
  CustomTextField({
    this.textInputType,
    this.maxLine,
    this.colorBorder,
    this.hintText,
    this.cursorColor,
    this.hintTextStyle,
    this.prefixIcon,
    this.prefixIconColor,
    this.suffixIcon,
    this.suffixIconColor,
    this.labelText,
    this.labelStyle,this.controller,this.validator,this.obscureText
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        obscuringCharacter:'*',obscureText:obscureText ?? false ,
        validator:validator , controller: controller, style: AppStyle.bold16gray,
        keyboardType: textInputType ?? TextInputType.text,
        maxLines: maxLine??1,
        cursorColor: cursorColor ?? AppColors.gray,
        decoration: InputDecoration(
            suffixIconColor: suffixIconColor,
            suffixIcon: suffixIcon,
            labelText: labelText,
            labelStyle: labelStyle,
            prefixIconColor: prefixIconColor ?? AppColors.gray,
            prefixIcon: prefixIcon,
            hintStyle: hintTextStyle ?? AppStyle.bold16gray,
            hintText: hintText,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                    width: 1,
                    style: BorderStyle.solid,
                    color: colorBorder ?? AppColors.gray)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                    width: 1,
                    style: BorderStyle.solid,
                    color: colorBorder ?? AppColors.gray)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                    width: 1, style: BorderStyle.solid, color: Colors.red)),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                    width: 1, style: BorderStyle.solid, color: Colors.red))));
  }
}
