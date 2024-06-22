import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final int completedTasks;
  final int totalTasks;

  const CustomCard({super.key, required this.completedTasks, required this.totalTasks});

  String getCompletionMessage() {
    double completionRate = totalTasks > 0 ? (completedTasks / totalTasks) : 0;

    if (completionRate == 1) {
      return "Parabéns! Você conseguiu!";
    } else if (completionRate >= 0.75) {
      return "Você consegue, só mais um pouco!";
    } else if (completionRate >= 0.5) {
      return "Você está no caminho certo";
    } else if (completionRate >= 0.2) {
      return "Não deixe para amanhã, faça hoje!";
    } else {
      return "Não deixe para amanhã, faça hoje!";
    }
  }

  @override
  Widget build(BuildContext context) {
    String message = getCompletionMessage();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width * 0.95,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Possui $completedTasks de $totalTasks tarefas concluídas.',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
