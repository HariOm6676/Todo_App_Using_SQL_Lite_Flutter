import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqlite_flutter/controller/cubit/cubit.dart';
import 'package:sqlite_flutter/controller/cubit/states.dart';
import 'package:sqlite_flutter/shared/component.dart';

class UpdateTaskScreen extends StatefulWidget {
  final int id;
  
  var title;
  
  var date;
  
  var time;
  
  var des;
  UpdateTaskScreen({Key? key,
    required this.id,
    required this.title,
    required this.date,
    required this.time,
    required this.des,});


  @override
  State<UpdateTaskScreen> createState() => _UpdateTaskScreenState();
}

class _UpdateTaskScreenState extends State<UpdateTaskScreen> {
  TextEditingController titleController = TextEditingController();

  TextEditingController timeController = TextEditingController();

  TextEditingController dateController = TextEditingController();

  TextEditingController desController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit, TodoStates>(
      listener: (BuildContext context, state) {
        if (state is SuccessGettingDataFromDatabaseState) {
          Navigator.pop(context);
        }
      },
      builder: (BuildContext context, Object? state) {
        var cubit = TodoCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('Update Your Task'.tr()),
          ),
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomTextFormFeild(
                    controller: titleController,
                    keyboardType: TextInputType.text,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Please add your title'.tr();
                      }
                    },
                    label: 'Title',
                    prefixIcon: Icons.title,
                    hintText: 'Add Your Title',
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  CustomTextFormFeild(
                    onTap: () {
                      showTimePicker(
                              context: context, initialTime: TimeOfDay.now())
                          .then((value) {
                        timeController.text = value!.format(context);
                      }).catchError((error) {
                        timeController.clear();
                      });
                    },
                    controller: timeController,
                    keyboardType: TextInputType.datetime,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Please add your time'.tr();
                      }
                    },
                    label: 'Time',
                    prefixIcon: Icons.watch_later_outlined,
                    hintText: 'Add Your Time',
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  CustomTextFormFeild(
                    onTap: () {
                      showDatePicker(
                              context: context,
                              firstDate: DateTime.now(),
                              lastDate: DateTime.parse('2024-12-30'),
                              initialDate: DateTime.now())
                          .then((value) {
                        dateController.text = DateFormat.yMMMd().format(value!);
                      }).catchError((error) {
                        dateController.clear();
                      });
                    },
                    controller: dateController,
                    keyboardType: TextInputType.datetime,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Please add your Date'.tr();
                      }
                    },
                    label: 'Date',
                    prefixIcon: Icons.calendar_view_day,
                    hintText: 'Add Your Date',
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  CustomTextFormFeild(
                    lines: 5,
                    controller: desController,
                    keyboardType: TextInputType.text,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Please add your Description'.tr();
                      }
                    },
                    label: 'Description',
                    prefixIcon: Icons.note,
                    hintText: 'Add Your Description',
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  MaterialButton(
                    height: 40.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0)),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        cubit.updateDataIntoDatabase(
                            title: titleController.text,
                            date: dateController.text,
                            time: timeController.text,
                            description: desController.text,
                            id: widget.id);
                      }
                    },
                    minWidth: double.infinity,
                    color: Colors.deepOrange,
                    child: Text('Update Task'.tr()),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
