import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlite_flutter/controller/cubit/states.dart';

class TodoCubit extends Cubit<TodoStates> {
  TodoCubit() : super(InitialTodoState());
  static TodoCubit get(context) => BlocProvider.of(context);
  //SQl Lite
  // Create a database
  // create database table
  //create database file
  Database? database;
  void createDatabase() {
    //db Database

    openDatabase('databasetodo.db', version: 1, onCreate: (database, version) {
      // here our database is create (only for the first time)
      // if we don't the path file name
      print('The Databse is created');
      database
          .execute('create table tasks'
              '(id integer primary key,title text,date text,time text,description text,status text)')
          .then((value) {
        print("Our table is created ");
      }).catchError((error) {
        // here is an error
        print("an error when creating is table");
      });
    }, onOpen: (database) {
      print("Database is opened");
      gettingDataFromDatabase(database);
    }).then((value) {
      // the database file is succed to open
      database = value;
      emit(CreateTodoDatabaseState());
    }).catchError((error) {
      print("Error when opening the file");
    });
  }

  void insertToDatabase({
    required title,
    required date,
    required time,
    required description,
    String status = 'new',
  }) {
    database!.transaction((txn) async {
      txn
          .rawInsert(
              'insert into tasks(title,date, time,description,status) values'
              '("$title","$date","$time","$description","$status")')
          .then((value) {
        // print(value);
        gettingDataFromDatabase(database);
        emit(InsertingIntoTodoDatabaseState());
      }).catchError((error) {
        print('an error when inserting into database');
      });
    });
  }

  List tasks = [];
  void gettingDataFromDatabase(database) {
    tasks = [];
    database!.rawQuery('select * from tasks').then((value) {
      value.forEach((element) {
        tasks.add(element);
      });
      print('our data is appearing');
      print(value);
      emit(SuccessGettingDataFromDatabaseState());
    }).catchError((error) {
      print(
          "An error in getting the data from the database ${error.toString()}");
    });
  }

  void updateDataIntoDatabase({
    required String title,
    required String date,
    required String time,
    required String description,
    required int id,
  }) {
    // what we need to update
    // to reach for a task from a table is by ID
    database!
        .update(
      "tasks",
      {"title": title, "date": date, "time": time, "description": description},
      where: 'id=?',
      whereArgs: [id],
    )
        .then((value) {
      print('$value Updating data success');
      gettingDataFromDatabase(database);
    }).catchError((error) {
      print("Error when updating data");
    });
  }

  // how to delete data from the database

  void deleteDataFromDatabase({required int id}) {
    database!.rawDelete('delete from tasks where id=?', [id]).then((value) {
      print('$value deleted successfully');
      gettingDataFromDatabase(database);
    }).catchError((error) {
      print('an error while deteing the data');
    });
  }
}
