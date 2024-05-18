import 'dart:async';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../model/todoModel.dart'; // Import the Note model

class ToDoDatabaseHelper {
  static const _databaseName = "note.db";
  static const databaseVersion = 1;
  static final ToDoDatabaseHelper dbInstance = ToDoDatabaseHelper.internal();

  factory ToDoDatabaseHelper() => dbInstance;
  static Database? _database;

  ToDoDatabaseHelper.internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String dbPath = path.join(documentsDirectory.path, _databaseName);
    bool deleteDatabase = false;

    Database db = await openDatabase(
      dbPath,
      version: databaseVersion,
      onConfigure: (Database db) async {
        int currentVersion = await db.getVersion();
        if (currentVersion != databaseVersion) {
          deleteDatabase = true;
        }
      },
      onCreate: _onCreate,
    );

    if (deleteDatabase) {
      await db.close();
      deleteDatabase;
      db = await openDatabase(
        dbPath,
        version: databaseVersion,
        onCreate: _onCreate,
      );
    }

    return db;
  }

  String notesTable = 'note_table';
  String newTable = 'add_table';
  String updateTable = 'update_table';
  String deleteTable = 'delete_table';
  String id = 'localId';
  String toid = 'id';
  String userId = 'userid';
  String description = 'todo';
  String status = 'completed';

  /// creating table here
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $notesTable (
            $id INTEGER PRIMARY KEY AUTOINCREMENT,
            $userId INTEGER NOT NULL,
            $toid INTEGER NOT NULL,
            $description TEXT NOT NULL,
            $status INTEGER NOT NULL
            )''');
    await db.execute('''
          CREATE TABLE $newTable (
            $id INTEGER PRIMARY KEY AUTOINCREMENT,
            $userId INTEGER NOT NULL,
            $toid INTEGER NOT NULL,
            $description TEXT NOT NULL,
            $status INTEGER NOT NULL
            )''');
    await db.execute('''
          CREATE TABLE $deleteTable (
            $id INTEGER PRIMARY KEY AUTOINCREMENT,
            $toid INTEGER NOT NULL
            )''');
  }

  /// inset task
  Future<void> insertTask(List<Todos> todos) async {
    Database db = await dbInstance.database;
    try {
      await db.execute('DROP TABLE IF EXISTS $notesTable');
      var result = await doesTableExist(db, notesTable);
      if (!result) {
        await db.execute('''
          CREATE TABLE $notesTable (
            $id INTEGER PRIMARY KEY AUTOINCREMENT,
            $userId INTEGER NOT NULL,
            $toid INTEGER NOT NULL,
            $description TEXT NOT NULL,
            $status INTEGER NOT NULL
            )''');
        for (int i = 0; i < todos.length; i++) {
          Map<String, dynamic> row = {
            userId: todos[i].userId,
            toid: todos[i].id,
            description: todos[i].todo,
            status: todos[i].completed,
          };
          await db.insert(notesTable, row);
        }
      }
    } catch (e, s) {
      print('Product add failed due to $e ???? $s');
    }
  }


  Future<void> addNewTask(Todos todos) async {
    Database db = await dbInstance.database;
    try {
      var result = await doesTableExist(db, newTable);
      if (!result) {
        await db.execute('''
          CREATE TABLE $newTable (
            $id INTEGER PRIMARY KEY AUTOINCREMENT,
            $userId INTEGER NOT NULL,
            $toid INTEGER NOT NULL,
            $description TEXT NOT NULL,
            $status INTEGER NOT NULL
            )''');
        Map<String, dynamic> row = {
          userId: todos.userId,
          toid: todos.id,
          description: todos.todo,
          status: todos.completed,
        };
        await db.insert(newTable, row);
      }else{
        Map<String, dynamic> row = {
          userId: todos.userId,
          toid: todos.id,
          description: todos.todo,
          status: todos.completed,
        };
        print("here is the row ${row}");
        await db.insert(newTable, row);
      }
    } catch (e, s) {
      print('Product add failed due to $e ???? $s');
    }
  }


  /// deleted task saved locally
  Future<void> locallyDeletedTask(taskid) async {
    Database db = await dbInstance.database;
    try {
      var result = await doesTableExist(db, deleteTable);
      if (!result) {
        await db.execute('''
          CREATE TABLE $deleteTable (
            $id INTEGER PRIMARY KEY AUTOINCREMENT,
            $toid INTEGER NOT NULL
            )''');
        Map<String, dynamic> row = {
          toid: taskid,
        };
        print("here is the row ${row}");
        await db.insert(deleteTable, row);
      }else{
        Map<String, dynamic> row = {
          toid: taskid,
        };
        print("here is delete the row ${row}");
        await db.insert(deleteTable, row);
      }
    } catch (e, s) {
      print('Product add failed due to $e ???? $s');
    }
  }

  /// checke table exist or not
  Future<bool> doesTableExist(Database db, String tableName) async {
    List<Map<String, dynamic>> tables = await db.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table' AND name='$tableName'");
    return tables.isNotEmpty;
  }
}
