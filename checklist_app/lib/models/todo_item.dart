import 'package:hive/hive.dart';

part 'todo_item.g.dart';

@HiveType(typeId: 0)
class TodoItem extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  bool isCompleted;

  @HiveField(2)
  int priority; // 1 = High, 2 = Medium, 3 = Low

  TodoItem({
    required this.title,
    this.isCompleted = false,
    this.priority = 3,
  });
}
