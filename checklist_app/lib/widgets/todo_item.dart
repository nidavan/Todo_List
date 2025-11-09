import 'package:flutter/material.dart';

import '../models/todo.dart';
import '../constants/colors.dart';

class ToDoItem extends StatelessWidget {
  final ToDo todo;
  final Function onToDoChanged;
  final Function onDeleteItem;
  final Function onUpdateItem;
  const ToDoItem({
    super.key, 
    required this.todo,
    required this.onToDoChanged,
    required this.onDeleteItem,
     required this.onUpdateItem,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
       onTap: () => onUpdateItem(todo),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: Colors.white,
        leading: InkWell(
          onTap: () {
            onToDoChanged(todo);
          },
          child: Icon(
            todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
            color: green,
          ),
        ) ,
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
          todo.priority == 0
              ? '🔥 High'
              : todo.priority == 1
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
