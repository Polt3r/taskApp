import 'package:flutter/material.dart';
import '../api/get_task.dart';
import '../api/get_user.dart';
import '../components/my_header.dart';
import '../components/my_header_card.dart';
import '../components/my_list_area.dart';
import '../model/task.dart';
import 'task/details_task_page.dart'; // Importe a tela de detalhes da tarefa aqui

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<Task> tasks = [];
  String selectedFilter = 'Todas';
  String userName =
      'Usuário'; // Valor padrão caso não consiga recuperar o apelido
  bool isRefreshing = false; // Flag para controlar o estado de refresh

  @override
  void initState() {
    super.initState();
    _loadUser();
    _fetchTasks(); // Carregar tarefas ao iniciar
  }

  Future<void> _loadUser() async {
    final userData = await getUserData();
    setState(() {
      userName = userData['UsuarioApelido'] ?? 'No user data';
    });
  }

  Future<void> _fetchTasks() async {
    setState(() {
      isRefreshing = true; // Ativar o indicador de refresh
    });

    try {
      final taskList = await fetchTasks();
      setState(() {
        tasks = taskList;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Falha ao carregar tarefas: $e'),
        ),
      );
    } finally {
      setState(() {
        isRefreshing = false; // Desativar o indicador de refresh
      });
    }
  }

  void filterTasks(String area) {
    setState(() {
      selectedFilter = area;
    });
  }

  @override
  Widget build(BuildContext context) {
    int completedTasks =
        tasks.where((task) => task.taskStatus == 'Concluido').length;
    int totalTasks = tasks.length;

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _fetchTasks,
          child: SingleChildScrollView(
            physics:
                const AlwaysScrollableScrollPhysics(), // Forçar a rolagem sempre, para evitar conflitos com RefreshIndicator
            child: Column(
              children: [
                HeaderWidget(userName: userName),
                const SizedBox(height: 20),
                CustomCard(
                    completedTasks: completedTasks, totalTasks: totalTasks),
                const SizedBox(height: 20),
                FilterList(
                  onItemSelected: (selectedOption) {
                    setState(() {
                      selectedFilter = selectedOption;
                    });
                  },
                ),
                const SizedBox(height: 20),
                SafeArea(
                  child: isRefreshing
                      ? const Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: tasks.length,
                          itemBuilder: (context, index) {
                            Task task = tasks[index];
                            if (selectedFilter == 'Todas' ||
                                task.taskArea == selectedFilter) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: Container(
                                  padding: const EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ListTile(
                                    title: Text(task.taskTitle,
                                        style: const TextStyle(fontSize: 18)),
                                    onTap: () {
                                      // Navigate to task details
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              TaskDetails(task: task),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              );
                            } else {
                              return Container();
                            }
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var result = await Navigator.pushNamed(context, '/NewTask');
          if (result != null && result == 'task_created') {
            // Re-fetch tasks
            _fetchTasks();
          }
        },
        tooltip: 'Nova Tarefa',
        backgroundColor: Colors.black,
        child: const Icon(Icons.add),
      ),
    );
  }
}
