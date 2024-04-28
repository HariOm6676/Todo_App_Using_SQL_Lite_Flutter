import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqlite_flutter/controller/cubit/cubit.dart';
import 'package:sqlite_flutter/controller/cubit/states.dart';

Widget CustomTextFormFeild({
  required TextEditingController? controller,
  required TextInputType? keyboardType,
  required FormFieldValidator<String>? validator,
  required String label,
  required IconData prefixIcon,
  required String hintText,
  GestureTapCallback? onTap,
  int? lines,
}) {
  return BlocBuilder<TodoCubit, TodoStates>(
    builder: (BuildContext context, state) {
      var cubit = TodoCubit.get(context);
      Color hintColor = cubit.isDark
          ? Colors.white
          : Colors.black
              .withOpacity(0.5); // Set input text color based on theme
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextFormField(
          maxLines: lines,
          onTap: onTap,
          style: TextStyle(color: hintColor), // Set input text color
          decoration: InputDecoration(
            labelText: label.tr(),
            labelStyle: TextStyle(color: hintColor),
            prefixIcon: Icon(
              prefixIcon,
              color: hintColor,
            ),
            hintText: hintText.tr(),
            hintStyle: TextStyle(color: hintColor),
            isDense: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide:
                  BorderSide(color: cubit.isDark ? Colors.white : Colors.black),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide(color: hintColor),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide(color: hintColor),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide(color: hintColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide(color: hintColor),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide(color: hintColor),
            ),
          ),
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
        ),
      );
    },
  );
}
