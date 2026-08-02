import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/task_model.dart';

class StorageService {
  static const String key = "tasks";

  Future<void> saveTasks(List<TaskModel> tasks) async {
    final prefs = await SharedPreferences.getInstance();

    List<String> data =
    tasks.map((e) => jsonEncode(e.toJson())).toList();

    await prefs.setStringList(key, data);
  }

  Future<List<TaskModel>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getStringList(key);

    if (data == null) return [];

    return data
        .map((e) => TaskModel.fromJson(jsonDecode(e)))
        .toList();
  }
}