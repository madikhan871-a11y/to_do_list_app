class TaskModel {
  String id;
  String title;
  String description;
  String priority;
  String dueDate;
  bool isCompleted;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.priority,
    required this.dueDate,
    this.isCompleted = false,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "priority": priority,
      "dueDate": dueDate,
      "isCompleted": isCompleted,
    };
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      priority: json["priority"],
      dueDate: json["dueDate"],
      isCompleted: json["isCompleted"],
    );
  }
}