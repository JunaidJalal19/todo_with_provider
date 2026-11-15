import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_with_provider/database/local/app_database.dart';
import 'package:todo_with_provider/provider/todo_provider.dart';
import 'package:todo_with_provider/routes/app_route.dart';
import 'package:todo_with_provider/screens/todo_screen.dart';

import 'helpers/app_color.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TodoProvider(dbInstance: AppDatabase.instance),
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo-App',
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        primaryColor: AppColor.primaryColor,
        cardTheme: CardThemeData(
          color: AppColor.secondaryColor,
          elevation: 0
        )
      ),
      themeMode: ThemeMode.dark,
      initialRoute: AppRoute.todo_screen,
      routes: AppRoute.route,
      onGenerateRoute: (setting) => AppRoute.generateRoutes(setting),
    );
  }
}


