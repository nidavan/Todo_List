import 'package:flutter/material.dart';

import '../model/todo.dart';
import '../constants/colors.dart';

class ToDoItem extends StatelessWidget {
  final ToDo todo;
  final onToDoChanged;
  final onDeleteItem;

  const ToDoItem({
    Key? key,
    required this.todo,
    required this.onToDoChanged,
    required this.onDeleteItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          onToDoChanged(todo);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: Colors.white,
        leading: Icon(
          todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
          color: green,
        ),
        title: Text(
          todo.todoText!,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: black,
            decoration: todo.isDone ? TextDecoration.lineThrough : TextDecoration.none,
          ),
        ),
        subtitle: Text(
          style: TextStyle(fontSize: 13, color: blue),
          todo.priority == 1
              ? '🔥 High'
              : todo.priority == 2
                  ? '⚡ Medium'
                  : '🌿 Low',
        ),
         trailing: IconButton(
          icon: const Icon(Icons.delete, color: red),
           onPressed: () {
              onDeleteItem(todo.id);
            },
        ),
      ),
    );
  }
}
