class ToDo {
  String? id;
  String? todoText;
  bool isDone;
  int priority;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
    this.priority = 0, // 0 = High, 1 = Medium, 2 = Low
  });
}