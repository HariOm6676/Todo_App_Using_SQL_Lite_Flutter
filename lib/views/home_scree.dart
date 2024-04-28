import 'dart:math';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sqlite_flutter/controller/cubit/cubit.dart';
import 'package:sqlite_flutter/controller/cubit/states.dart';
import 'package:sqlite_flutter/views/add_task_screen.dart';
import 'package:sqlite_flutter/views/drawer.dart';
import 'package:sqlite_flutter/views/update_screen.dart';

List<String> backgroundImagePaths = [
  'assets/images/1.jpg',
  'assets/images/2.jpg',
  'assets/images/3.jpg',
  'assets/images/4.jpg',
  'assets/images/5.jpg',
  'assets/images/6.jpg',
  'assets/images/7.jpg',
  'assets/images/8.jpg',
  'assets/images/9.jpg',
  'assets/images/10.jpg',
  'assets/images/11.jpg',
  'assets/images/12.jpg',
  'assets/images/13.jpg',
  'assets/images/14.jpg',
  'assets/images/15.jpg',
  'assets/images/16.jpg',
  'assets/images/17.jpg',
  'assets/images/18.jpg',
  'assets/images/19.jpg',
  'assets/images/20.jpg',
  'assets/images/21.jpg',
  'assets/images/22.jpg',
  'assets/images/23.jpg',
  'assets/images/24.jpg',
  'assets/images/25.jpg',
  'assets/images/26.jpg',
  'assets/images/27.jpg',
  'assets/images/28.jpg',
  'assets/images/29.jpg',
  // Add more image paths as needed
];

String getRandomImagePath() {
  final Random random = Random();
  return backgroundImagePaths[random.nextInt(backgroundImagePaths.length)];
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = TodoCubit.get(context);
    final String backgroundImage =
        getRandomImagePath(); // Get random image path
    cubit.createDatabase();

    return BlocConsumer<TodoCubit, TodoStates>(
        builder: (BuildContext context, Object? state) {
          print(cubit.tasks);
          return Scaffold(
            drawer: CustomDrawer(),
            // Drawer(
            //   child: DrawerScreen(),
            // ),
            appBar: AppBar(
              title: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: !cubit.isDark ? Colors.black : Colors.white,
                    strokeAlign: BorderSide.strokeAlignCenter,
                    width: 2,
                  ), // Border color
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.all(8.0), // Adjust padding as needed
                  child: Text(
                    'My Tasks'.tr(),
                    style: GoogleFonts.robotoCondensed(
                      textStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: !cubit.isDark ? Colors.black : Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              elevation: 1,
              backgroundColor: Colors.transparent,
              actions: [
                BlocBuilder<TodoCubit, TodoStates>(
                  builder: (BuildContext context, state) => IconButton(
                    onPressed: () {
                      BlocProvider.of<TodoCubit>(context).changeThemeMode();
                    },
                    icon: Icon(
                      BlocProvider.of<TodoCubit>(context).isDark
                          ? Icons.dark_mode
                          : Icons.light_mode,
                    ),
                  ),
                ),
              ],
            ),
            body: Stack(
              children: [
                Container(
                  width: double.infinity, // Set width to fill the entire screen
                  height: double.infinity,
                  child: Image.asset(
                    backgroundImage,
                    fit: BoxFit.fill,
                  ),
                ),
                ConditionalBuilder(
                  condition: state is! LoadingGetDataFromDatabaseState,
                  fallback: (BuildContext context) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  builder: (BuildContext context) {
                    print("Inside Conditional Builder Checking State");
                    print(state);
                    print("Inside Conditional Builder checking cubit");
                    print(cubit.tasks.isNotEmpty);
                    print(cubit.tasks);
                    return (cubit.tasks.isNotEmpty)
                        ? ListView.builder(
                            itemCount: cubit.tasks.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return UpdateTaskScreen(
                                        id: cubit.tasks[index]['id'],
                                        title: cubit.tasks[index]['title'],
                                        date: cubit.tasks[index]['date'],
                                        time: cubit.tasks[index]['time'],
                                        des: cubit.tasks[index]['description'],
                                      );
                                    },
                                  ));
                                },
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              cubit.tasks[index]['title'],
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1,
                                            ),
                                            Text(
                                              cubit.tasks[index]['time'],
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1,
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                cubit.deleteDataFromDatabase(
                                                    id: cubit.tasks[index]
                                                        ['id']);
                                              },
                                              icon: Icon(Icons.delete),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          alignment:
                                              AlignmentDirectional.bottomStart,
                                          child: Text(
                                            cubit.tasks[index]['description'],
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        : Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(Icons.hourglass_empty),
                                Text(
                                  'There is no task here'.tr(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(color: Colors.deepOrange),
                                )
                              ],
                            ),
                          );
                  },
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return AddTaskScreen();
                }));
              },
              child: const Icon(Icons.add),
            ),
          );
        },
        listener: (BuildContext context, state) {});
  }
}
