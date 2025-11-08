import 'package:bloc/bloc.dart';
import 'package:checklist_app/models/todo_item.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final Box<TodoItem> todoBox;
  TodoBloc(this.todoBox) : super(TodoState(todos: [])) {
    on<TodoEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<LoadTodos>((event, emit) {
      final todos = todoBox.values.toList();
      emit(TodoState(todos: todos));
    });

    on<AddTodo>((event, emit) {
      todoBox.add(event.todo);
      emit(TodoState(todos: todoBox.values.toList()));
    });

    on<UpdateTodo>((event, emit) {
      event.todo.save();
      emit(TodoState(todos: todoBox.values.toList()));
    });

    on<DeleteTodo>((event, emit) {
      event.todo.delete();
      emit(TodoState(todos: todoBox.values.toList()));
    });
  }
}
