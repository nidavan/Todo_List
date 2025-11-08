// import 'package:flutter/material.dart';
// import 'screen/home.dart'; // Import the HomeScreen

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Home Example',
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: Home(), // Use the imported HomeScreen
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'bloc/todo_bloc.dart';
import 'models/todo_item.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TodoItemAdapter());
  final box = await Hive.openBox<TodoItem>('todosBox');

  runApp(MyApp(todoBox: box));
}

class MyApp extends StatelessWidget {
  final Box<TodoItem> todoBox;
  const MyApp({super.key, required this.todoBox});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TodoBloc(todoBox)..add(LoadTodos()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Checklist App',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const HomeScreen(),
      ),
    );
  }
}
