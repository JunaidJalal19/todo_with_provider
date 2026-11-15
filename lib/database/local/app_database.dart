import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  AppDatabase._();

  static final AppDatabase instance = AppDatabase._();

  // table and column names
  static const String Table_Name = "todo";
  static const String ID_Col = "id";
  static const String Todo_Col = "todo_msg";
  static const String Is_Complete_Todo_Col = "isComplete";

  Database? mDb;

  // get db
  Future<Database> getDb() async {
    mDb ??= await openDb();
    return mDb!;
  }


  // open database
  Future<Database> openDb() async {
    Directory appDir = await getApplicationDocumentsDirectory();
    String dbPath = join(appDir.path, "todoDatabase.db");

    return await openDatabase(dbPath, version: 1, onCreate: (db, version) {
      db.execute("""
      create table $Table_Name ( 
      $ID_Col integer primary key autoincrement, 
      $Todo_Col text,
      $Is_Complete_Todo_Col integer )
      """);
    });
  }


  /// database events <><>><>><><> ///


  // fetch all_todo
  Future<List<Map<String, dynamic>>> fetchAllTodo() async {
    Database db = await getDb();
    return await db.query(Table_Name);
  }


  // addTodo
  Future<bool> addTodo({required String todo}) async {
    Database db = await getDb();

    int effectedRow = await db.insert(Table_Name, {
      Todo_Col: todo,
      Is_Complete_Todo_Col: 0,
    });

    return effectedRow > 0;
  }


  // update_todo
  Future<bool> updateTodo({required int id, required String todo}) async {
    Database db = await getDb();

    int effectedRow = await db.update(Table_Name, {
      Todo_Col: todo,
    }, where: "$ID_Col = ?", whereArgs: [id]);

    return effectedRow > 0;
  }


  // isComplete_todo
  Future<bool> isCompleteTodo({required int id, required int value}) async {
    Database db = await getDb();

    int effectedRow = await db.update(Table_Name, {
      Is_Complete_Todo_Col: value
    }, where: "$ID_Col = ?", whereArgs: [id]);

    return effectedRow > 0;
  }


  // delete_todo
  Future<bool> deleteTodo({required int id}) async {
    Database db = await getDb();

    int effectedRow = await db.delete(Table_Name, where: "$ID_Col = ?", whereArgs: [id]);
    return effectedRow > 0;
  }



}