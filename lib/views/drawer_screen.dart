import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqlite_flutter/controller/cubit/cubit.dart';
import 'package:sqlite_flutter/controller/cubit/states.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit, TodoStates>(
      builder: (BuildContext context, Object? state) {
        var cubit = TodoCubit.get(context);
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Change Your Language".tr(),
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              MaterialButton(
                color: Colors.deepOrange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                onPressed: () {
                  cubit.changeLanguageToEnglish(context);
                },
                child: Text('English'.tr()),
              ),
              MaterialButton(
                color: Colors.green,
                onPressed: () {
                  cubit.changeLanguageToArabic(context);
                },
                child: Text('Arbic'.tr()),
              ),
            ]),
          ],
        );
      },
      listener: (BuildContext context, state) {},
    );
  }
}
