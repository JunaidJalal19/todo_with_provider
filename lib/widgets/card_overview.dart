import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_with_provider/database/local/app_database.dart';
import 'package:todo_with_provider/provider/todo_provider.dart';

import '../helpers/app_color.dart';

class CardOverview extends StatelessWidget {
  const CardOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          crossAxisAlignment: .center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: .start,
                spacing: 5,
                children: [
                  Text(
                      "Todo Progress",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: .bold
                      )
                  ),
                  Text(
                      "Complete your first task",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).hintColor
                      )
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColor.primaryColor
              ),
              child: Consumer<TodoProvider>(
                builder: (context, provider, child) {
                  List<Map<String, dynamic>> todos = provider.getTodoDatas();
                  Iterable<Map<String, dynamic>> completeTodo = todos.where((todo) => todo[AppDatabase.Is_Complete_Todo_Col] == 1);
                  return Text("${completeTodo.length}/${todos.length}",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: .bold
                    ),
                  );
                }
              ),
            )
          ],
        ),
      ),
    );
  }
}
