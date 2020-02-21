import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:todolist/model/todo.dart';

class DbHelper {
  static final DbHelper _dbHelper = DbHelper._internal();
  DbHelper._internal();
  factory DbHelper() {
    return _dbHelper;
  }

  String tblTodo = "todo";
  String colId = "id";
  String colTitle = "title";
  String colDescription = "description";
  String colPriority = "priority";
  String colDate = "date";

  static Database _db;
  Future<Database> get db async {
    if (_db == null) {
      _db = await initializeDb();
    }
    return _db;
  }

  Future<Database> initializeDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + "todos1.db";
    var dbTodos = await openDatabase(path, version: 1, onCreate: _createDb);
    return dbTodos;
  }

  void _createDb(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $tblTodo($colId INTEGER PRIMARY KEY, $colTitle Text, $colDescription Text, $colPriority INTEGER, $colDate TEXT)");
  }

  Future<int> insertTodo(Todo todo) async {
    Database db = await this.db;
    var result = await db.insert(tblTodo, todo.toMap());
    return result;
  }

  Future<List> getTodos() async {
    Database db = await this.db;
    var sql = "SELECT * FROM $tblTodo ORDER BY $colPriority ASC";
    var result = await db.rawQuery(sql);
    return result;
  }

  Future<int> getCount() async {
    Database db = await this.db;
    var sql = "SELECT COUNT(*) FROM $tblTodo";
    var result = Sqflite.firstIntValue(await db.rawQuery(sql));
    return result;
  }

  Future<int> updateTodos(Todo todo) async {
    Database db = await this.db;
    var result = await db
        .update(tblTodo, todo.toMap(), where: "$colId=?", whereArgs: [todo.id]);
    return result;
  }

  Future<int> deleteTodos(int id) async {
    Database db = await this.db;
    var result = await db.delete(tblTodo, where: "$colId=?", whereArgs: [id]);
    // var result = await db.rawDelete('DELETE FROM $tblTodo WHERE $colId=$id');
    return result;
  }
}
