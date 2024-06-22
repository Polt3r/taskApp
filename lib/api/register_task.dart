import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map<String, dynamic>> createTask({
  required String token,
  required String titulo,
  required String descricao,
  required String area,
  required String data,
}) async {
  var headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };
  var request = http.Request(
    'POST',
    Uri.parse('http://192.168.17.109:8082/KnowledgeBaseNETSQLServer/TaskAPI/CadastrarTarefa'),
  );
  request.body = json.encode({
    "TarefaSDT": {
      "TarefaId": 0,
      "TarefaTitulo": titulo,
      "TarefaDescricao": descricao,
      "TarefaData": data,
      "TarefaStatus": "Pendente",
      "TarefaArea": area,
    }
  });
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    return {
      "TarefaTitulo": titulo,
      "TarefaDescricao": descricao,
      "TarefaData": data,
      "TarefaArea": area,
    };
  } else {
    throw Exception('Failed to create task: ${response.reasonPhrase}');
  }
}
