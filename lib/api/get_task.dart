import 'package:app_lista_contatos/api/auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/task.dart';

Future<List<Task>> fetchTasks() async {
  final token = await getToken();
  var headers = {
    'Authorization': 'Bearer $token',
  };

  var request = http.Request(
    'GET',
    Uri.parse('http://192.168.17.109:8082/KnowledgeBaseNETSQLServer/TaskAPI/RecuperarTarefa')
  );
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    var responseBody = await response.stream.bytesToString();
    List<dynamic> taskDataList = json.decode(responseBody);
    return taskDataList.map((data) => Task.fromJson(data)).toList();
  } else {
    throw Exception('Failed to load tasks');
  }
}
