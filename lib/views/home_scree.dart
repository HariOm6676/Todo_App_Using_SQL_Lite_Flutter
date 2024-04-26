import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqlite_flutter/controller/cubit/cubit.dart';
import 'package:sqlite_flutter/controller/cubit/states.dart';
import 'package:sqlite_flutter/views/add_task_screen.dart';
import 'package:sqlite_flutter/views/drawer_screen.dart';
import 'package:sqlite_flutter/views/update_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit, TodoStates>(
        builder: (BuildContext context, Object? state) {
          var cubit = TodoCubit.get(context);
          print(cubit.tasks);
          return Scaffold(
            drawer: Drawer(
              child: DrawerScreen(),
            ),
            appBar: AppBar(
              title: Text('My Tasks'.tr()),
              elevation: 1,
              backgroundColor: Colors.deepOrange.shade200,
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
            body: ConditionalBuilder(
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
                                  mainAxisAlignment: MainAxisAlignment.start,
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
                                              .caption,
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            cubit.deleteDataFromDatabase(
                                                id: cubit.tasks[index]['id']);
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
                                            .headline6,
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
                              'There is no task here',
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
