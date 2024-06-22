import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


Future<void> recuperarDadosUsuario(String token) async {
  final url = Uri.parse('http://192.168.17.109:8082/KnowledgeBaseNETSQLServer/TaskAPI/RecuperarUsuario');
  final headers = {
    'Authorization': 'Bearer $token',
  };

  final response = await http.get(url, headers: headers);

  if (response.statusCode == 200) {
    final responseData = json.decode(response.body);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userData', json.encode(responseData));
  } else {
    throw Exception('Failed to retrieve user data: ${response.reasonPhrase}');
  }
}

Future<Map<String, dynamic>> getUserData() async {
  final prefs = await SharedPreferences.getInstance();
  final userDataString = prefs.getString('userData');
  if (userDataString != null) {
    return json.decode(userDataString);
  }
  return {};
}
