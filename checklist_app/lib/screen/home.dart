import 'package:flutter/material.dart';
import 'package:checklist_app/screen/dashboard.dart';
import '../model/todo.dart';
import '../constants/colors.dart';
import '../widgets/todo_item.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<ToDo> todosList = [];
  final List<String> options = ['🔥 High', '⚡ Medium', '🌿 Low'];
  int selectedPriority = -1;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bGColor,
      /// bloc header
      appBar: AppBar(
        backgroundColor: bGColor,
        elevation: 0,
        title: const Text('Checklist App 📝'),
        centerTitle: true,
        actions: [
          /// bloc filter
          IconButton(
            icon: const Icon(Icons.filter_alt, color: blue, size: 30),
            tooltip: 'Filter ',
            onPressed: () {
              _showFilterTodoDialog(context);
            },
          ),
          SizedBox(width: 10),

          ///bloc dashboard
          IconButton(
            icon: const Icon(Icons.pie_chart, color: green, size: 30),
            tooltip: 'Go to Dashboard',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => Dashboard(todoList: todosList),
                ),
              );
            },
          ),
        ],
      ),

      ///bloc body
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          children: [
            Builder(
              builder: (BuildContext context) {
                if (todosList.isEmpty) {
                  return SizedBox.shrink();
                }

                /// bloc function sort data by priority
                final todos = List.from(todosList);
                todos.sort((a, b) {
                  if (a.priority == selectedPriority &&
                      b.priority != selectedPriority) {
                    return -1;
                  } else if (a.priority != selectedPriority &&
                      b.priority == selectedPriority) {
                    return 1;
                  }
                  return b.id!.compareTo(a.id!);
                });

                ///bloc show list data
                return Expanded(
                  child: ListView.builder(
                    itemCount: todos.length,
                    itemBuilder: (context, index) {
                      final itemTodo = todos[index];
                      return ToDoItem(
                        todo: itemTodo,
                        onToDoChanged: (todo) {
                          /// bloc change done item todo
                          setState(() {
                            todo.isDone = !todo.isDone;
                          });
                        },
                        onDeleteItem: (id) {
                          /// bloc delete item todo
                          setState(() {
                            todosList.removeWhere((item) => item.id == id);
                          });
                        },
                        onUpdateItem: (todo) {
                          /// bloc show update data
                          _showTodoDialog(context, isUpdate: true, todo: todo);
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),

      /// bloc float button
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showTodoDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  /// bloc show todo dialog add or update
  void _showTodoDialog(
    BuildContext context, {
    bool isUpdate = false,
    ToDo? todo,
  }) {
    final todoController = TextEditingController(
      text: isUpdate && todo != null ? todo.todoText : '',
    );
    int localPriority = isUpdate && todo != null ? todo.priority : 0;
    bool isTextFieldEmpty = false;
    showDialog(
      context: context,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: Text(isUpdate ? "Update Task" : 'Add Task'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: todoController,
                    decoration: InputDecoration(
                      labelText: 'Task title',
                      errorText: isTextFieldEmpty
                          ? 'Please enter a task title'
                          : null,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: List<Widget>.generate(options.length, (
                      int index,
                    ) {
                      return ChoiceChip(
                        padding: EdgeInsets.zero,
                        label: Text(options[index]),
                        selected: localPriority == index,
                        onSelected: (bool selected) {
                          setStateDialog(() {
                            localPriority = selected ? index : localPriority;
                          });
                        },
                      );
                    }),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  style: TextButton.styleFrom(foregroundColor: grey),
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: blue,
                    foregroundColor: white,
                  ),
                  onPressed: () {

                    /// bloc no input
                    if (todoController.text.trim().isEmpty) {
                      setStateDialog(() {
                        isTextFieldEmpty = true;
                      });
                      return;
                    }
                    if (isUpdate) {
                      /// bloc update todo list
                      final item = todosList.firstWhere(
                        (t) => t.id == todo?.id,
                      );
                      item.todoText = todoController.text;
                      item.priority = localPriority;
                    } else {
                       /// bloc add todo list
                      todosList.insert(
                        0,
                        ToDo(
                          id: DateTime.now().millisecondsSinceEpoch.toString(),
                          todoText: todoController.text,
                          priority: localPriority,
                        ),
                      );
                    }
                    setState(() {});
                    todoController.clear();
                    Navigator.pop(context);
                  },
                  child: const Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  /// bloc show filtter dialog
  void _showFilterTodoDialog(BuildContext context, {int priority = -1}) {
    int localPriority = priority;
    showDialog(
      context: context,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: Text('Filter'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: List<Widget>.generate(options.length, (
                      int index,
                    ) {
                      return ChoiceChip(
                        padding: EdgeInsets.zero,
                        label: Text(options[index]),
                        selected: localPriority == index,
                        onSelected: (bool selected) {
                          setStateDialog(() {
                            localPriority = selected ? index : localPriority;
                          });
                        },
                      );
                    }),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: grey,
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: blue,
                    foregroundColor: white,
                  ),
                  onPressed: () {
                    setState(() => selectedPriority = localPriority);
                    Navigator.pop(context);
                  },
                  child: const Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
