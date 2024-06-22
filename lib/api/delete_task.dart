import 'package:http/http.dart' as http;
import '../../api/auth.dart';

Future<void> deleteTask(String taskId) async {
  var token = await getToken();
  var headers = {
    'Authorization': 'Bearer $token',
  };
  var request = http.Request(
    'GET', 
    Uri.parse('http://192.168.17.109:8082/KnowledgeBaseNETSQLServer/TaskAPI/DeletarTarefa?TarefaId=$taskId')
  );
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode != 200) {
    throw Exception('Falha ao deletar tarefa');
  }
}
