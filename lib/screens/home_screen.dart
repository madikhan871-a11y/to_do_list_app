import 'package:flutter/material.dart';

import '../models/task_model.dart';
import '../services/storage_service.dart';
import '../widgets/task_tile.dart';
import 'add_task_screen.dart';
import 'edit_task_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final StorageService storage = StorageService();

  List<TaskModel> tasks = [];

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  Future loadTasks() async {
    tasks = await storage.loadTasks();
    setState(() {});
  }

  Future save() async {
    await storage.saveTasks(tasks);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TaskZen"),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddTaskScreen(tasks: tasks),
            ),
          );
          loadTasks();
        },
      ),
      body: tasks.isEmpty
          ? const Center(
        child: Text("No Tasks Yet"),
      )
          : ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (_, index) {
          final task = tasks[index];

          return TaskTile(
            task: task,
            onDelete: () {
              tasks.removeAt(index);
              save();
            },
            onEdit: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EditTaskScreen(
                    task: task,
                    tasks: tasks,
                  ),
                ),
              );
              loadTasks();
            },
            onChanged: (value) {
              task.isCompleted = value!;
              save();
            },
          );
        },
      ),
    );
  }
}