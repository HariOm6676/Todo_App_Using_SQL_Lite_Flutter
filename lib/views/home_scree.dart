import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqlite_flutter/controller/cubit/cubit.dart';
import 'package:sqlite_flutter/controller/cubit/states.dart';
import 'package:sqlite_flutter/views/add_task_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => TodoCubit()..createDatabase(),
      child: BlocConsumer<TodoCubit, TodoStates>(
          builder: (BuildContext context, state) {
            var cubit = TodoCubit.get(context);
            return Scaffold(
              appBar: AppBar(),
              body: ListView.builder(
                itemCount: cubit.tasks.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cubit.tasks[index]['title'],
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              Text(
                                cubit.tasks[index]['time'],
                                style: Theme.of(context).textTheme.caption,
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
                            alignment: AlignmentDirectional.bottomStart,
                            child: Text(
                              cubit.tasks[index]['description'],
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          )
                        ],
                      ),
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
          listener: (BuildContext context, Object? state) {}),
    );
  }
}
