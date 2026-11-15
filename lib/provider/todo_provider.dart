import 'package:flutter/cupertino.dart';
import 'package:todo_with_provider/database/local/app_database.dart';

class TodoProvider extends ChangeNotifier {
  final AppDatabase _dbInstance;

  TodoProvider({required this._dbInstance});

  List<Map<String, dynamic>> _todos = [];

  // get todos
  List<Map<String, dynamic>> getTodoDatas() => _todos;


  /// <><><><><><><><><><><> events <>><>><><><><>><>><><><><>><>><><>///

  // get all todos
  Future<void> fetchInitialTodos() async {
    _todos = await _dbInstance.fetchAllTodo();
    notifyListeners();
  }

  // add_todo
  void addTodo({required String todo}) async {
    bool isDone = await _dbInstance.addTodo(todo: todo);

    if (isDone) {
      fetchInitialTodos();
    }
  }

  // update_todo
  void updateTodo({required int id, required String todo}) async {
    bool isUpdate = await _dbInstance.updateTodo(id: id, todo: todo);

    if(isUpdate) {
      fetchInitialTodos();
    }
  }


  // isCompleteTodo
  Future<void> isComplete({required int id, required int value}) async {
    bool isUpdate = await _dbInstance.isCompleteTodo(id: id, value: value);

    if(isUpdate) {
      fetchInitialTodos();
    }
  }


  // delete
  void deleteTodo({required int id}) async {
    bool isDelete = await _dbInstance.deleteTodo(id: id);

    if(isDelete) {
      fetchInitialTodos();
    }
  }




}