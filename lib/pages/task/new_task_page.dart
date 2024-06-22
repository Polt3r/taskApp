import 'package:flutter/material.dart';
import '../../api/auth.dart';
import '../../api/register_task.dart';
import '../../components/my_appbar.dart';
import '../../components/my_button.dart';
import '../../components/my_textfield.dart';
import '../home.dart';

class NewTask extends StatefulWidget {
  const NewTask({Key? key}) : super(key: key);

  @override
  State<NewTask> createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final dateController = TextEditingController();
  String selectedArea = 'Corpo';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, Icons.close),
      body: Container(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: const Text(
                "Vamos criar um nova tarefa?",
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.grey,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 20),
            MyTextField(
              controller: titleController,
              hintText: 'Nome da Tarefa',
              obscureText: false,
            ),
            const SizedBox(height: 20),
            MyTextField(
              controller: descriptionController,
              hintText: 'Descrição',
              obscureText: false,
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: DropdownButtonFormField<String>(
                value: selectedArea,
                items: ['Corpo', 'Alma', 'Mente', 'Renda', 'Amor'].map((String area) {
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
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (pickedDate != null) {
                  String formattedDate = "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
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
            ),
            const SizedBox(height: 40),
            MyButton(
              textLabel: "CRIAR",
              onTap: () async {
                try {
                  var token = await getToken();
                  var responseData = await createTask(
                    token: token,
                    titulo: titleController.text,
                    descricao: descriptionController.text,
                    area: selectedArea,
                    data: dateController.text,
                  );
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(), // Redirecionar para a HomePage
                      ),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Falha ao cadastrar tarefa: $e'),
                  ));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
