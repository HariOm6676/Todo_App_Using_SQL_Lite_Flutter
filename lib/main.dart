// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqlite_flutter/controller/cubit/cubit.dart';
import 'package:sqlite_flutter/controller/cubit/states.dart';
import 'package:sqlite_flutter/shared/styles/themes.dart';
import 'package:sqlite_flutter/views/home_scree.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  bool isDark = sharedPreferences.getBool("isDark") ?? false;

  runApp(
    EasyLocalization(
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('ar', 'EG'),
          Locale('hi', 'IN')
        ],
        fallbackLocale: const Locale('en', 'US'),
        path: 'assets/transilations',
        child: MyApp(
          isDark: isDark,
        )),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.isDark,
  });
  final bool isDark;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => TodoCubit()
              ..createDatabase()
              ..changeThemeMode(darkMode: isDark)),
      ],
      child: BlocBuilder<TodoCubit, TodoStates>(
        builder: (BuildContext context, state) {
          var cubit = TodoCubit.get(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            title: 'Flutter Demo',
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: cubit.isDark ? ThemeMode.dark : ThemeMode.light,
            home: AnimatedSplashScreen(
              splash: Image.asset(
                'assets/images/download.jpg',
                fit: BoxFit.cover,
              ),
              nextScreen: const HomeScreen(),
              splashIconSize: double.infinity,
              splashTransition: SplashTransition.fadeTransition,
              pageTransitionType: PageTransitionType.fade,
              backgroundColor: Colors.transparent,
              duration: 1000,
            ),
          );
        },
      ),
    );
  }
}
