import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/provider/session_provider.dart';
import 'package:http/http.dart' as http;
import '../constants/app_colors.dart';
import '../repository/api.dart';
import '../repository/dbHelper/dbhelper.dart';
import '../repository/model/todoModel.dart';

class HomeProvider extends ChangeNotifier {
  final SessionProvider sessionProvider;

  HomeProvider({required this.sessionProvider});

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DateTime? selectedDate;
  TextEditingController title = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController time = TextEditingController();
  TextEditingController description = TextEditingController();
  late ScrollController Sccontroller;
  var page_ = 0;
  var limit = 10;
  var isFirstLoadRunning = false;
  var hasNextPage = true;
  var isLoadMoreRunning = false;
  final List<Todos> _todoList = [];
  final List<Todos> pendingTodoList = [];
  final List<Todos> completedTodoList = [];
  var taskId;
  String? selectedStatus = "Pending";
  final List<String> statusOptions = ['Completed', 'Pending'];
  var loading = false;
  var addLoading = false;

  List<Todos> get todoList => _todoList;

  String getGreeting() {
    final now = DateTime.now();
    final hour = now.hour;

    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else if (hour < 20) {
      return 'Good Evening';
    } else {
      return 'Good Night';
    }
  }

  void addTodo(Todos todo) {
    _todoList.add(todo);
    notifyListeners();
  }

  void removeTodo(int id) {
    _todoList.removeWhere((todo) => todo.id == id);
    notifyListeners();
  }

  String formatTime(TimeOfDay time) {
    // Format the time using 24-hour format
    String hour = time.hour.toString().padLeft(2, '0');
    String minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  DateTime setTime(time) {
    DateTime currentDate = DateTime.now();
    DateTime dateTimeWithSpecificTime = DateTime(
      currentDate.year,
      currentDate.month,
      currentDate.day,
      time.hour,
      time.minute,
    );
    return dateTimeWithSpecificTime;
  }

  /// time picker
  Future<TimeOfDay?> showStartTimePicker(context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      time.text = pickedTime.format(context).toString();
      ChangeNotifier();
    }
  }

  /// Function to display the date picker
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      var format = DateFormat('MMMM d, y').format(selectedDate!);
      date.text = format.toString();
      ChangeNotifier();
    }
  }

  setTaskData(Todos task, context) {
    title.text = "Demo Title";
    taskId = task.id;
    time.text = TimeOfDay.now().format(context).toString();
    var format = DateFormat('MMMM d, y').format(DateTime.now());
    date.text = format.toString();
    description.text = task.todo!;
  }

  /// pagination apis
  void firstProductsLoad() async {
    isFirstLoadRunning = true;
    page_ = 1;
    try {
      final res = await http.get(
        Uri.parse('${Api.baseURL}/todos?limit=$limit&skip=$page_'),
        headers: {
          'Authorization': 'Bearer ${sessionProvider.loginData.token}',
          'Accept': 'application/json'
        },
      );
      var result = jsonDecode(res.body);
      if (result['todos'] != null) {
        result['todos']!.forEach((element) {
          _todoList.add(Todos.fromJson(element));
          if (element['completed'] == false) {
            pendingTodoList.add(Todos.fromJson(element));
          } else {
            completedTodoList.add(Todos.fromJson(element));
          }
        });
        saveTaskListsLocally(_todoList);
      }
      isFirstLoadRunning = false;
      notifyListeners();
    } on SocketException catch (e) {
      Database db = await ToDoDatabaseHelper.dbInstance.database;
      final List<Map<String, dynamic>> maps = await db.query('note_table');
      if (maps != null) {
        for (var element in maps) {
          _todoList.add(Todos.fromJson(element));
        }
      }
      isFirstLoadRunning = false;
      notifyListeners();
    } catch (err) {
      isFirstLoadRunning = false;
      notifyListeners();
    }
  }

  Future<void> loadMoreProducts() async {
    var percentage =
        (Sccontroller.position.pixels / Sccontroller.position.maxScrollExtent);
    if (percentage > 0.89 && isLoadMoreRunning == false) {
      isLoadMoreRunning = true;
      page_ += 10; // Increase _page by 1
      notifyListeners();
      try {
        final res = await http.get(
          Uri.parse('${Api.baseURL}/todos?limit=$limit&skip=$page_'),
          headers: {
            'Authorization': 'Bearer ${sessionProvider.loginData.token}',
            'Accept': 'application/json'
          },
        );
        var result = jsonDecode(res.body);
        if (result['todos'] != null) {
          result['todos']!.forEach((element) {
            _todoList.add(Todos.fromJson(element));
            if (element['completed'] == false) {
              pendingTodoList.add(Todos.fromJson(element));
            } else {
              completedTodoList.add(Todos.fromJson(element));
            }
          });
          notifyListeners();
          saveTaskListsLocally(_todoList);
        } else {
          hasNextPage = false;
          notifyListeners();
        }
      } catch (err) {}
      isLoadMoreRunning = false;
      notifyListeners();
    }
  }

  /// add task
  Future<void> addTask() async {
    if (formKey.currentState!.validate()) {
      final url = Uri.parse('${Api.baseURL}/todos/add');
      await sessionProvider.getData();
      final Map<String, dynamic> requestBody = {
        'todo': description.text.trim(),
        'completed': false,
        'userId': sessionProvider.loginData.id,
      };
      try {
        loading = true;
        notifyListeners();
        final response = await http.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: json.encode(requestBody),
        );
        if (response.statusCode == 200 || response.statusCode == 201) {
          Get.back();
          Get.snackbar("Task Added", "Task added successfully",
              colorText: AppColors.kWhiteColor,
              backgroundColor: AppColors.kGreenColor,
              snackPosition: SnackPosition.BOTTOM,
              margin: const EdgeInsets.all(15));
          loading = false;
          notifyListeners();
        } else {
          Get.snackbar(
              "Unable to add task", "Unable to added task please try again",
              colorText: AppColors.kWhiteColor,
              backgroundColor: AppColors.kRedColor,
              snackPosition: SnackPosition.BOTTOM,
              margin: const EdgeInsets.all(15));
          loading = false;
          notifyListeners();
        }
      } on SocketException catch (e) {
        Todos json = Todos(
            id: 0,
            completed: 0,
            todo: description.text.trim(),
            userId: sessionProvider.loginData.id);
        addNewTaskLocally(json);
        loading = false;
        notifyListeners();
      } catch (error) {
        loading = false;
        notifyListeners();
      }
    }
  }

  /// update task
  Future<void> updateTodo() async {
    final url = Uri.parse('${Api.baseURL}/todos/$taskId');
    final Map<String, dynamic> requestBody = {
      'completed': selectedStatus == "Pending" ? false : true,
    };

    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestBody),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        Get.back();
        Get.snackbar("Task Updated", "Task updated successfully",
            colorText: AppColors.kWhiteColor,
            backgroundColor: AppColors.kGreenColor,
            snackPosition: SnackPosition.BOTTOM,
            margin: const EdgeInsets.all(15));
      } else {
        Get.snackbar(
            "Unable to update task", "Unable to update task please try again",
            colorText: AppColors.kWhiteColor,
            backgroundColor: AppColors.kRedColor,
            snackPosition: SnackPosition.BOTTOM,
            margin: const EdgeInsets.all(15));
      }
    } catch (error) {
      print('Error occurred: $error');
    }
  }

  /// delete Task
  Future<bool?> deleteTask(id) async {
    final url = Uri.parse('${Api.baseURL}/todos/$id');

    try {
      final response = await http.delete(url);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        Get.snackbar("Task Deleted", "Task deleted successfully",
            colorText: AppColors.kWhiteColor,
            backgroundColor: AppColors.kGreenColor,
            snackPosition: SnackPosition.BOTTOM,
            margin: const EdgeInsets.all(15));
        return true;
      } else {
        Get.snackbar("Unable to delete", "Unable to delete task",
            colorText: AppColors.kWhiteColor,
            backgroundColor: AppColors.kRedColor,
            snackPosition: SnackPosition.BOTTOM,
            margin: const EdgeInsets.all(15));
        return false;
      }
    } on SocketException catch (e) {
      savedLocallyDeltedTask(id);
      deleteFromTodoList(id, "note_table");
      notifyListeners();
      return false;
    } catch (error) {
      print('Error occurred: $error');
      return false;
    }
  }

  removeIndex(index) {
    todoList.removeAt(index);
    notifyListeners();
  }

  ///local db functions here
  saveTaskListsLocally(todoList) async {
    Database db = await ToDoDatabaseHelper.dbInstance.database;
    await ToDoDatabaseHelper.dbInstance.insertTask(todoList);
  }

  /// add new task locally
  addNewTaskLocally(todoList) async {
    Database db = await ToDoDatabaseHelper.dbInstance.database;
    await ToDoDatabaseHelper.dbInstance.addNewTask(todoList);
  }

  /// function for checking locally saved all task and then upload to server
  uploadLocallySavedNewTask() async {
    Database db = await ToDoDatabaseHelper.dbInstance.database;
    final List<Map<String, dynamic>> maps = await db.query('add_table');
    for (int i = 0; i < maps.length; i++) {
      await uploadSavedLocallyNewTask(
          userId: maps[i]['userid'],
          status: maps[i]['id'] == 0 ? false : true,
          des: maps[i]['todo'],
          localId: maps[i]['localId']);
    }
  }

  /// function for uploading locally saved new task to server api
  Future<void> uploadSavedLocallyNewTask({des, status, userId, localId}) async {
    final url = Uri.parse('${Api.baseURL}/todos/add');
    await sessionProvider.getData();
    final Map<String, dynamic> requestBody = {
      'todo': description.text.trim(),
      'completed': false,
      'userId': sessionProvider.loginData.id,
    };
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestBody),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        await deleteTodo(localId, 'add_table');
      } else {
        Get.snackbar(
            "Unable to add task", "Unable to added task please try again",
            colorText: AppColors.kWhiteColor,
            backgroundColor: AppColors.kRedColor,
            snackPosition: SnackPosition.BOTTOM,
            margin: const EdgeInsets.all(15));
        loading = false;
        notifyListeners();
      }
    } catch (error) {}
  }

  /// function for saved delete task locally db
  savedLocallyDeltedTask(id) async {
    Database db = await ToDoDatabaseHelper.dbInstance.database;
    await ToDoDatabaseHelper.dbInstance.locallyDeletedTask(id);
  }

  /// function for check mark deleted task then remove from server
  checkDeletedLocalSavedTask() async {
    Database db = await ToDoDatabaseHelper.dbInstance.database;
    final List<Map<String, dynamic>> maps = await db.query('delete_table');
    for (int i = 0; i < maps.length; i++) {
      deleteTaskServerSide(id: maps[i]['id'], localId: maps[i]['localId']);
    }
  }

  /// api call for delte localcaly saved delted task
  Future<bool?> deleteTaskServerSide({localId, id}) async {
    final url = Uri.parse('${Api.baseURL}/todos/$id');

    try {
      final response = await http.delete(url);
      if (response.statusCode == 200) {
        deleteTodo(localId, "delete_table");
      } else {}
    } catch (error) {
      print('Error occurred: $error');
      return false;
    }
  }

  Future<int> deleteTodo(int id, tableName) async {
    Database db = await ToDoDatabaseHelper.dbInstance.database;
    return await db.delete(
      '$tableName',
      where: 'localId = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteFromTodoList(int id, tableName) async {
    Database db = await ToDoDatabaseHelper.dbInstance.database;
    return await db.delete(
      '$tableName',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
