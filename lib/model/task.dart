class Task {
  final String taskId;
  final String taskTitle;
  final String taskDescription;
  final DateTime taskDate;
  final String taskArea;
  final String taskStatus;

  Task({
    required this.taskId,
    required this.taskTitle,
    required this.taskDescription,
    required this.taskDate,
    required this.taskArea,
    this.taskStatus = 'Pendente',
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      taskId: json['TarefaId'],
      taskTitle: json['TarefaTitulo'],
      taskDescription: json['TarefaDescricao'],
      taskDate: DateTime.parse(json['TarefaData']),
      taskArea: json['TarefaArea'],
      taskStatus: json['TarefaStatus'],
    );
  }

}
