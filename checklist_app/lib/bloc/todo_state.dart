part of 'todo_bloc.dart';

@immutable
// sealed class TodoState {
  
// }

// final class TodoInitial extends TodoState {}

// final class GetTodos extends TodoState {
//   final List<TodoItem> todos;

//   GetTodos({required this.todos});

//   GetTodos copyWith({List<TodoItem>? todos}) {
//     return GetTodos(todos: todos ?? this.todos);
//   }
// }
final class TodoState {
  final List<TodoItem> todos;

  const TodoState({required this.todos});

  TodoState copyWith({List<TodoItem>? todos}) {
    return TodoState(todos: todos ?? this.todos);
  }
}

