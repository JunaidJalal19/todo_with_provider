import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_with_provider/screens/add_todo_screen.dart';
import 'package:todo_with_provider/screens/todo_screen.dart';

class AppRoute {
  AppRoute._();

  static const todo_screen = "/";
  static const add_todo_screen = "/addTodo";

  static final Map<String, WidgetBuilder> route = {
    todo_screen: (context) => TodoScreen(),
    //add_todo_screen: (context) => AddTodoScreen(),
  };

  static Route<dynamic> generateRoutes(RouteSettings setting) {
    switch(setting.name) {
      // case todo_screen :
      //   return MaterialPageRoute(builder: (context) => TodoScreen());

      case add_todo_screen:
        final value = setting.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(builder: (context) => AddTodoScreen(todo: value,));

      default:
        throw Exception('Route not found: ${setting.name}');

    }
  }
}