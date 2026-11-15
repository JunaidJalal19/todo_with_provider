import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_with_provider/database/local/app_database.dart';
import 'package:todo_with_provider/provider/todo_provider.dart';

import '../helpers/app_color.dart';

class AddTodoScreen extends StatefulWidget {
 const AddTodoScreen({super.key, this.todo});

 final Map<String, dynamic>? todo;


  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  final TextEditingController todoController = TextEditingController();
  late bool isEdit;

  @override
  void initState() {
    super.initState();
    isEdit = widget.todo != null;
    todoController.text =  widget.todo?[AppDatabase.Todo_Col] ?? "";
  }

  @override
  void dispose() {
    todoController.dispose();
    super.dispose();
  }


  /// save and update func
  void saveTodo() {
    if(todoController.text.trim().isEmpty) return;

    if(isEdit) {
      context.read<TodoProvider>().updateTodo(id: widget.todo?[AppDatabase.ID_Col], todo: todoController.text);
      Navigator.pop(context);

    }else {
      context.read<TodoProvider>().addTodo(todo: todoController.text);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        leadingWidth: 60,
        leading: Padding(
          padding: const EdgeInsets.all(8),
          child: CircleAvatar(
            backgroundColor: AppColor.secondaryColor,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
              ),
            ),
          ),
        ),
        backgroundColor: Colors.black,
        title: Text(isEdit ? "Update Todo" : "Add Todo",
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: .bold
          ),
        ),
      ),
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                SizedBox(height: 20,),
                TextField(
                  controller: todoController,
                  cursorColor: AppColor.primaryColor,
                  decoration: InputDecoration(
                    hintText: "enter todo..",
                    hintStyle: TextStyle(
                      color: Colors.white.withValues(alpha: 0.5)
                    ),
                    filled: true,
                    fillColor: AppColor.secondaryColor,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(12)
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 20)
                  ),
                ),

                SizedBox(height: 30,),

                SizedBox(
                  height: 60,
                  width: double.infinity,
                  child: FilledButton(
                      onPressed: saveTodo,
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColor.primaryColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(12))
                      ),
                      child: Text("Save",
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: .w500
                        ),
                      )
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
}
