import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_chart/fl_chart.dart';
import '../bloc/todo_bloc.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

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
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          final todos = state.todos;
          final total = todos.length;
          final completed = todos.where((t) => t.isCompleted).length;
          final pending = total - completed;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('Your Progress Overview',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                if (total == 0)
                  const Text('No tasks yet! Add some first ✨')
                else
                  SizedBox(
                    height: 220,
                    child: PieChart(
                      PieChartData(
                        sections: [
                          PieChartSectionData(
                            color: Colors.green,
                            value: completed.toDouble(),
                            title: '✅ $completed',
                            radius: 70,
                          ),
                          PieChartSectionData(
                            color: Colors.orange,
                            value: pending.toDouble(),
                            title: '🕓 $pending',
                            radius: 70,
                          ),
                        ],
                        centerSpaceRadius: 40,
                      ),
                    ),
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
          );
        },
      ),
    );
  }
}
