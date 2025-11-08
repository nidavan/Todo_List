import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/todo_bloc.dart';
import '../models/todo_item.dart';

class TodoTile extends StatelessWidget {
  final TodoItem todo;
  const TodoTile({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: ListTile(
        leading: IconButton(
          icon: Icon(
            todo.isCompleted ? Icons.check_circle : Icons.arrow_right_alt,
            color: todo.isCompleted ? Colors.green : Colors.grey,
          ),
          onPressed: () {
            todo.isCompleted = !todo.isCompleted;
            context.read<TodoBloc>().add(UpdateTodo(todo));
          },
        ),
        title: Text(
          todo.title,
          style: TextStyle(
            fontSize: 16,
            decoration: todo.isCompleted
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
        subtitle: Text(
          todo.priority == 1
              ? '🔥 High'
              : todo.priority == 2
                  ? '⚡ Medium'
                  : '🌿 Low',
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () => context.read<TodoBloc>().add(DeleteTodo(todo)),
        ),
      ),
    );
  }
}
