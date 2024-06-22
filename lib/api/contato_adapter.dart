import 'dart:convert';
import 'package:app_lista_contatos/api/auth.dart';
import 'package:http/http.dart' as http;
import '../model/contato.dart';

Future<List<Contato>> getListaContatos() async {
  final token = await getToken();

  if (token.isEmpty) {
    throw Exception('Token not found. Please authenticate first.');
  }

  final response = await http.get(
    Uri.parse('http://192.168.17.109:8082/KnowledgeBaseNETSQLServer/TaskAPI/Contatos'),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    List<Contato> minhalista = (json.decode(response.body) as List)
        .map((item) => Contato.fromJson(item))
        .toList();
    return minhalista;
  } else if (response.statusCode == 401) {
    Map<String, dynamic> errorResponse = json.decode(response.body);
    String errorMessage = errorResponse['error']['message'];
    if (errorMessage == "GAM_SessionFinished") {
      throw Exception("Sessão finalizada. Por favor, faça login novamente.");
    } else {
      throw Exception("Erro de autorização: $errorMessage");
    }
  } else {
    throw Exception("Falha ao carregar contatos: ${response.statusCode}");
  }
}
