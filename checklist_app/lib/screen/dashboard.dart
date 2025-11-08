import 'package:checklist_app/model/todo.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../constants/colors.dart';

class Dashboard extends StatefulWidget {
  final List<ToDo> todoList;
  const Dashboard({super.key, required this.todoList});

  @override
  State<Dashboard> createState() => _Dashboard();
}

class _Dashboard extends State<Dashboard> {
  int total = 0;
  int completed = 0;
  int pending = 0;

  @override
  void initState() {
    total = widget.todoList.length;
    completed = widget.todoList.where((t) => t.isDone).length;
    pending = total - completed;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('📊 Dashboard'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Align(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Your Progress Overview',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, ),
            ),
            const SizedBox(height: 20),
            Builder(
              builder: (BuildContext context) {
                if (total == 0) {
                  return Text('No tasks yet! Add some first ✨');
                }
                return SizedBox(
                  height: 220,
                  child: PieChart(
                    PieChartData(
                      sections: [
                        PieChartSectionData(
                          color: green,
                          value: completed.toDouble(),
                          title: '✅ $completed',
                          radius: 70,
                        ),
                        PieChartSectionData(
                          color: orange,
                          value: pending.toDouble(),
                          title: '🕓 $pending',
                          radius: 70,
                        ),
                      ],
                      centerSpaceRadius: 40,
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 30),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text('📋 Total: $total'),
                    Text('✅ Completed: $completed'),
                    Text('🕓 Incomplete: $pending'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
