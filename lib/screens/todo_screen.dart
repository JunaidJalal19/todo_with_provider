import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_with_provider/database/local/app_database.dart';
import 'package:todo_with_provider/helpers/app_color.dart';
import 'package:todo_with_provider/provider/todo_provider.dart';
import 'package:todo_with_provider/routes/app_route.dart';
import 'package:todo_with_provider/widgets/card_overview.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {

  @override
  void initState() {
    super.initState();
    context.read<TodoProvider>().fetchInitialTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SizedBox(
        height: 60,
        width: 60,
        child: FilledButton(
          onPressed: (){
            Navigator.pushNamed(context, AppRoute.add_todo_screen);
          },
          style: FilledButton.styleFrom(
            padding: EdgeInsets.zero,
            backgroundColor: AppColor.primaryColor,
            foregroundColor: Colors.white,
            shape: CircleBorder(),
          ),
          child: Center(
              child: Icon(Icons.add, size: 28,)
          ),
        ),
      ),
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [

                // todo_overview
                CardOverview(),

                SizedBox(height: 8,),

                Consumer<TodoProvider>(
                  builder: (context, provider, child) {
                    List<Map<String, dynamic>> todos = provider.getTodoDatas();
                    return todos.isEmpty ? Expanded(
                      child: Center(
                        child: Text("no todos!"),
                      ),
                    ) : Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                          padding: EdgeInsets.only(top: 10),
                          itemCount: todos.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                                    child: CheckboxListTile(
                                        value: todos[index][AppDatabase.Is_Complete_Todo_Col] == 1 ? true : false,
                                        onChanged: (value){
                                          context.read<TodoProvider>().isComplete(id: todos[index][AppDatabase.ID_Col], value: value == true ? 1 : 0);
                                        },
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                      checkboxScaleFactor: 1.2,
                                      checkboxShape: CircleBorder(),
                                      controlAffinity: ListTileControlAffinity.leading,
                                      activeColor: AppColor.primaryColor,
                                      checkColor: Colors.white,

                                      title: Text(todos[index][AppDatabase.Todo_Col],
                                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                          fontWeight: .w600,
                                          color: todos[index][AppDatabase.Is_Complete_Todo_Col] == 1 ? Theme.of(context).hintColor : Colors.white,
                                          decoration: todos[index][AppDatabase.Is_Complete_Todo_Col] == 1 ? TextDecoration.lineThrough : TextDecoration.none,
                                          decorationThickness: 3,
                                          decorationColor: AppColor.primaryColor
                                        ),
                                      ),

                                      secondary: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                              onPressed: (){
                                                Navigator.pushNamed(context, AppRoute.add_todo_screen, arguments: todos[index]);
                                              },
                                              icon: Icon(Icons.edit_outlined)
                                          ),

                                          IconButton(
                                              onPressed: (){
                                                provider.deleteTodo(id: todos[index][AppDatabase.ID_Col]);
                                              },
                                              icon: Icon(Icons.delete_outline)
                                          )
                                        ],
                                      ),


                                    ),
                                  ),
                                ),
                              );
                            }
                        )
                    );

                  }

                ),

              ],
            ),
          )
      ),
    );
  }
}
