import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map<String, dynamic>> changeTask({
  required String token,
  required String titulo,
  required String descricao,
  required String area,
  required String data,
  required String status, required String id,
}) async {
  var headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };
  var request = http.Request(
    'POST',
    Uri.parse('http://192.168.17.109:8082/KnowledgeBaseNETSQLServer/TaskAPI/AlterarTarefa'),
  );
  request.body = json.encode({
    "TarefaSDT": {
      "TarefaId": id,
      "TarefaTitulo": titulo,
      "TarefaDescricao": descricao,
      "TarefaData": data,
      "TarefaStatus": status,
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
      "TarefaStatus": status,
    };
  } else {
    throw Exception('Failed to create task: ${response.reasonPhrase}');
  }
}
