import 'package:flutter/material.dart';
import 'text_style.dart';

class EditText extends StatelessWidget {
  String? hintText;
  IconData? prefixIcon, suffixIcon;
  bool isPasswordType;
  Color textColor, borderColor;
  TextEditingController controller;
  VoidCallback? iconPressed;
  TextInputType? keyBoardType;
  TextStyle? hintStyle, textStyle;
  double? borderRadius;
  String? Function(String?)? validator;
  String? Function(String?)? onChanged;
  double? iconSize;
  TextInputAction? textInputAction;

  EditText(
      {super.key,
      required this.hintText,
      required this.controller,
      this.prefixIcon,
      this.suffixIcon,
      this.isPasswordType=false,
      this.textColor=Colors.grey,
      this.borderColor=Colors.grey,
      this.iconPressed,
      this.keyBoardType= TextInputType.text,
      this.hintStyle,
      this.textStyle,
      this.borderRadius,
      this.validator,
      this.onChanged,
      this.iconSize,
      this.textInputAction});


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isPasswordType,
      enableSuggestions: !isPasswordType,
      autocorrect: !isPasswordType,
      controller: controller,
      validator: validator,
      onChanged: onChanged,
      decoration: InputDecoration(
        contentPadding:
        const EdgeInsets.symmetric(vertical: 13.5, horizontal: 15.0),
        hintText: hintText,
        hintStyle: hintStyle ?? text4().copyWith(color:Colors.grey),
        prefixIcon: prefixIcon != null
            ? Icon(
          prefixIcon,
          color: Colors.grey,
        )
            : null,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
                borderRadius != null ? borderRadius ?? 0.0 : 30.0),
            borderSide: const BorderSide(width: 2, color: Colors.grey)),
        suffixIcon: suffixIcon != null
            ? isPasswordType
            ? IconButton(
            onPressed: iconPressed,
            icon: Icon(
              suffixIcon,
              color: Colors.grey,
              size: iconSize,
            ))
            : IconButton(
            onPressed: iconPressed,
            icon: Icon(suffixIcon, color: Colors.grey, size: iconSize))
            : null,
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          borderSide: BorderSide(color: Colors.red, width: 1),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          borderSide: BorderSide(color: Colors.red, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
              borderRadius != null ? borderRadius ?? 0.0 : 30.0),
          borderSide: const BorderSide(width: 1, color: Colors.grey),
        ),
      ),
      style: textStyle ?? text6().copyWith(color: textColor),
      textInputAction: textInputAction,
      keyboardType: isPasswordType ? TextInputType.visiblePassword : keyBoardType,
    );
  }
}
