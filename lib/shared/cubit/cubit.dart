import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tasksblok/constant/const.dart';
import 'package:tasksblok/screens/archived_tasks/archived_tasks_screen.dart';
import 'package:tasksblok/screens/done_tasks/done_tasks_screen.dart';
import 'package:tasksblok/screens/new_tasks/new_tasks_screen.dart';
import 'package:tasksblok/shared/cubit/states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInstialState());
  static AppCubit get(context) => BlocProvider.of(context);
  late Database database;
  List<Map> NewTasks = [];
  List<Map> DonetTsks = [];
  List<Map> ArchivedTasks = [];

  void creatDatabase() async {
    database = await openDatabase(
      'todo.db',
      version: 1,
      onCreate: (db, version) {
        print('Database Created');
        //id int
        // title string
        // date string
        // time string
        //status string
        db
            .execute(
                'CREATE TABLE tasks (id INTEGER PRIMARY KEY , title TEXT , date TEXT , time TEXT ,status TEXT)')
            .then((value) {
          print('table create');
        }).catchError((error) {
          print('error when create');
        });
      },
      onOpen: (database) {
        getDataFromDatabase(database);
        print('Database Open');
      },
    );
  }

  //EndcreateDatabase
  //InsertToDatabase
  insertToDatabase({
    required String date,
    required String title,
    required String time,
  }) async {
    await database.transaction((txn) {
      return
          //id INTEGER PRIMARY KEY , title TEXT , date TEXT , time TEXT ,status TEXT
          txn
              .rawInsert(
                  'INSERT INTO tasks(title , date , time ,status) VALUES("$title" , "$date","$time","new")')
              .then((value) {
        print('$value inserted successfully');
        emit(AppInsartDataBase());
        getDataFromDatabase(database);
      }).catchError((error) {
        print('error when inserted new record${error.toString()}');
      });
    });
  }

//end insertToDatabase
//start get gateDataFromdatabase
  void getDataFromDatabase(database) {
    DonetTsks = [];
    NewTasks = [];
    ArchivedTasks = [];
    emit(AppGetLodingDataBase());
    database.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach(
        (element) {
          if (element['status'] == 'new') {
            NewTasks.add(element);
          } else if (element['status'] == 'done') {
            DonetTsks.add(element);
          } else {
            ArchivedTasks.add(element);
          }
        },
      );
      emit(AppGetDataBase());
    });
  }

//end get gateDataFromdatabase

//statrt upgate data
  void updateData({required status, required id}) {
    database.rawUpdate(
        'UPDATE tasks SET status=? WHERE id=?', ['$status', id]).then((value) {
      getDataFromDatabase(database);
      emit(AppUpdateDataBase());
    });
  }

  void deleteData({required id}) {
    database.rawDelete('DELETE FROM tasks WHERE id = ?', ['$id']).then((value) {
      getDataFromDatabase(database);
      emit(AppDeleteDataBase());
    });
  }

//end upgate data
  //==================================
  bool isButtonShetShow = false;
  IconData fabIcon = Icons.edit;

  int currentIndex = 0;

  List<Widget> screens = [
    NewTasksScreen(),
    const DoneTasksScreen(),
    const ArchivedTasksScreen()
  ];

  List<String> titles = ['NewTasks', 'DoneTasks', 'ArchivedTasks'];

  //==================================

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeButtomNavBarState());
  }

  void ChangeButtomsheet(
    @required bool isShow,
    @required IconData icon,
  ) {
    isButtonShetShow = isShow;
    fabIcon = icon;
    emit(AppChangeButtomsheetState());
  }
}
