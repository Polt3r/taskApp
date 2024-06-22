import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import '../../api/change_task.dart';
import '../../api/delete_task.dart';
import '../../components/my_appbar.dart';
import '../../components/my_textview.dart';
import '../../components/my_textfield.dart'; // Assumindo que você tem um MyTextField similar ao MyTextView
import '../../model/task.dart'; // Importar a função de atualização da tarefa
import '../../api/auth.dart';

class TaskDetails extends StatefulWidget {
  final Task task;

  const TaskDetails({Key? key, required this.task}) : super(key: key);

  @override
  State<TaskDetails> createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController dateController;
  late TextEditingController areaController;
  late String status;
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.task.taskTitle);
    descriptionController =
        TextEditingController(text: widget.task.taskDescription);
    dateController =
        TextEditingController(text: widget.task.taskDate.toString());
    areaController = TextEditingController(text: widget.task.taskArea);
    status = widget.task.taskStatus;
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    dateController.dispose();
    areaController.dispose();
    super.dispose();
  }

  Future<void> updateTask() async {
    try {
      var token = await getToken();
      await changeTask(
        token: token,
        id: widget.task.taskId,
        titulo: titleController.text,
        descricao: descriptionController.text,
        area: areaController.text,
        data: dateController.text,
        status: status,
      );
      setState(() {
         // Atualiza os dados da tarefa no estado local
        
        isEditing = false;
        Navigator.pushNamed(context, '/Home');
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tarefa atualizada com sucesso!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Falha ao atualizar tarefa: $e')),
      );
    }
  }

  Future<void> deleteTaskHandler() async {
    try {
      await deleteTask(widget.task.taskId);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tarefa deletada com sucesso!')),
      );
      Navigator.pop(context); // Voltar para a tela anterior após deletar
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Falha ao deletar tarefa: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var selectedArea = 'Corpo';
    return Scaffold(
      appBar: buildAppBar(context, Icons.close),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isEditing
                ? MyTextField(
                    controller: titleController,
                    hintText: 'Nome da Tarefa',
                    obscureText: false,
                  )
                : Text(
                    widget.task.taskTitle,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
            const SizedBox(height: 16),
            isEditing
                ? MyTextField(
                    controller: descriptionController,
                    hintText: 'Descrição',
                    obscureText: false,
                  )
                : TextView(
                    label: 'Descrição', text: widget.task.taskDescription),
            const SizedBox(height: 16),
            isEditing
                ? GestureDetector(
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null) {
                        String formattedDate =
                            "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                        setState(() {
                          dateController.text = formattedDate;
                        });
                      }
                    },
                    child: AbsorbPointer(
                      child: MyTextField(
                        controller: dateController,
                        hintText: 'Data de Conclusão',
                        obscureText: false,
                      ),
                    ),
                  )
                : TextView(
                    label: 'Data', text: widget.task.taskDate.toString()),
            const SizedBox(height: 16),
            isEditing
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: DropdownButtonFormField<String>(
                      value: selectedArea,
                      items: ['Corpo', 'Alma', 'Mente', 'Renda', 'Amor']
                          .map((String area) {
                        return DropdownMenuItem<String>(
                          value: area,
                          child: Text(area),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedArea = newValue!;
                        });
                      },
                      decoration: const InputDecoration(
                        //labelText: 'Área',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  )
                : TextView(label: 'Área', text: widget.task.taskArea),
            const SizedBox(height: 16),
            isEditing
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: DropdownButtonFormField<String>(
                      value: status,
                      items: const [
                        DropdownMenuItem(
                            value: 'Concluido', child: Text('Concluido')),
                        DropdownMenuItem(
                            value: 'Em andamento', child: Text('Em andamento')),
                        DropdownMenuItem(
                            value: 'Pendente', child: Text('Pendente')),
                        DropdownMenuItem(
                            value: 'Em atraso', child: Text('Em atraso')),
                        DropdownMenuItem(
                            value: 'Cancelada', child: Text('Cancelada')),
                      ],
                      onChanged: (value) {
                        setState(() {
                          status = value!;
                        });
                      },
                      decoration: const InputDecoration(
                        labelText: 'Status',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  )
                : TextView(label: 'Status', text: widget.task.taskStatus),
          ],
        ),
      ),
      floatingActionButton: buildFloatingActionButton(),
    );
  }

  Widget buildFloatingActionButton() => isEditing
      ? FloatingActionButton(
          onPressed: updateTask,
          tooltip: 'Salvar',
          backgroundColor: Colors.green,
          child: const Icon(Icons.save),
        )
      : SpeedDial(
          backgroundColor: Colors.black,
          overlayColor: Colors.black,
          overlayOpacity: 0.2,
          animatedIcon: AnimatedIcons.menu_close,
          spacing: 16,
          children: [
            SpeedDialChild(
              child: const Icon(Icons.delete, color: Colors.white),
              backgroundColor: Colors.red.shade300,
              label: 'Excluir Tarefa',
              onTap: deleteTaskHandler,
            ),
            SpeedDialChild(
              child: const Icon(Icons.edit),
              label: 'Editar',
              onTap: () {
                setState(() {
                  isEditing = true;
                });
              },
            ),
          ],
        );
}
