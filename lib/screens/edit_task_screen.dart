import 'package:flutter/material.dart';

import '../models/task_model.dart';
import '../services/storage_service.dart';

class EditTaskScreen extends StatefulWidget {
  final TaskModel task;
  final List<TaskModel> tasks;

  const EditTaskScreen({
    super.key,
    required this.task,
    required this.tasks,
  });

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  late TextEditingController title;
  late TextEditingController description;
  late TextEditingController dueDate;

  late String priority;

  final storage = StorageService();

  @override
  void initState() {
    super.initState();

    title = TextEditingController(text: widget.task.title);
    description = TextEditingController(text: widget.task.description);
    dueDate = TextEditingController(text: widget.task.dueDate);

    priority = widget.task.priority;
  }

  Future updateTask() async {
    widget.task.title = title.text;
    widget.task.description = description.text;
    widget.task.priority = priority;
    widget.task.dueDate = dueDate.text;

    await storage.saveTasks(widget.tasks);

    if (!mounted) return;

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Task")),
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
              onPressed: updateTask,
              child: const Text("Update Task"),
            ),
          ],
        ),
      ),
    );
  }
}