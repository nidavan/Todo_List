
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
  int _priority = 3;
  final _todoController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bGColor,
      appBar: _buildAppBar(),
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      for (ToDo todo in todosList.reversed)
                        ToDoItem(
                          todo: todo,
                          onToDoChanged: _handleToDoChange,
                          onDeleteItem: _deleteToDoItem,
                        ),
                    ],
                  ),
                ),
              ],
            ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addTodoDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addTodoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        int localPriority = _priority;
        bool isTextFieldEmpty = false;
        final List<String> options = ['🔥 High', '⚡ Medium', '🌿 Low'];
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: const Text('Add Task'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _todoController,
                    decoration: InputDecoration(
                      labelText: 'Task title',
                      errorText: isTextFieldEmpty ? 'Please enter a task title' : null,
                      
                    ),
                    
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 2.0,
                    children: List<Widget>.generate(options.length, (int index) {
                      return ChoiceChip(
                        padding: EdgeInsets.zero,
                        shape: CircleBorder(),
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
                    foregroundColor: grey, // Text color
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
                    if (_todoController.text.trim().isEmpty) {
                      setStateDialog(() {
                        isTextFieldEmpty = true;
                      });
                      return;
                    }
                    setState(() {
                        _priority = localPriority;
                        _addToDoItem(_todoController.text, _priority);
                      });
                    _todoController.clear();
                    Navigator.pop(context);
                  },
                  child: const Text('Add'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteToDoItem(String id) {
    setState(() {
      todosList.removeWhere((item) => item.id == id);
    });
  }

  void _addToDoItem(String toDo, int priority) {
    setState(() {
      todosList.add(
        ToDo(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          todoText: toDo,
          priority: priority,
        ),
      );
    });
    _todoController.clear();
  }

  void _runFilter(String enteredKeyword) {
    List<ToDo> results = [];
    if (enteredKeyword.isEmpty) {
      results = todosList;
    } else {
      results = todosList
          .where(
            (item) => item.todoText!.toLowerCase().contains(
                  enteredKeyword.toLowerCase(),
                ),
          )
          .toList();
    }

    setState(() {
      todosList = results;
    });
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: bGColor,
      elevation: 0,
      title: const Text('Checklist App 📝'),
      centerTitle: true,
      actions: [
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
    );
  }
}
