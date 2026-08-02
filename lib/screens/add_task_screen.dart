import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../models/task_model.dart';
import '../services/storage_service.dart';

class AddTaskScreen extends StatefulWidget {
  final List<TaskModel> tasks;

  const AddTaskScreen({
    super.key,
    required this.tasks,
  });

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final title = TextEditingController();
  final description = TextEditingController();
  final dueDate = TextEditingController();

  String priority = "Medium";

  final storage = StorageService();

  Future saveTask() async {
    widget.tasks.add(
      TaskModel(
        id: const Uuid().v4(),
        title: title.text,
        description: description.text,
        priority: priority,
        dueDate: dueDate.text,
      ),
    );

    await storage.saveTasks(widget.tasks);

    if (!mounted) return;

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Task")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            TextField(
              controller: title,
              decoration: const InputDecoration(labelText: "Title"),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: description,
              decoration: const InputDecoration(labelText: "Description"),
            ),

            const SizedBox(height: 15),

            DropdownButtonFormField<String>(
              value: priority,
              items: const [
                DropdownMenuItem(value: "High", child: Text("High")),
                DropdownMenuItem(value: "Medium", child: Text("Medium")),
                DropdownMenuItem(value: "Low", child: Text("Low")),
              ],
              onChanged: (v) => priority = v!,
            ),

            const SizedBox(height: 15),

            TextField(
              controller: dueDate,
              decoration: const InputDecoration(labelText: "Due Date"),
            ),

            const SizedBox(height: 25),

            ElevatedButton(
              onPressed: saveTask,
              child: const Text("Save Task"),
            ),
          ],
        ),
      ),
    );
  }
}