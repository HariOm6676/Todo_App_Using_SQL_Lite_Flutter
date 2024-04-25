import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget CustomTextFormFeild({
  required TextEditingController? controller,
  required TextInputType? keyboardType,
  required FormFieldValidator<String>? validator,
  required String label,
  required IconData prefixIcon,
  required String hintText,
  GestureTapCallback? onTap,
  int? lines,
}) =>
    TextFormField(
      maxLines: lines,
      onTap: onTap,
      decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(prefixIcon),
          hintText: hintText,
          isDense: true,
          enabledBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          disabledBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          errorBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          focusedBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          focusedErrorBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
    );
