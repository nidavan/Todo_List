part of 'todo_bloc.dart';

@immutable
sealed class TodoEvent {}

class LoadTodos extends TodoEvent {}
class AddTodo extends TodoEvent {
  final TodoItem todo;
  AddTodo(this.todo);
}
class UpdateTodo extends TodoEvent {
  final TodoItem todo;
  UpdateTodo(this.todo);
}
class DeleteTodo extends TodoEvent {
  final TodoItem todo;
  DeleteTodo(this.todo);
}
