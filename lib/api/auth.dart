import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'get_user.dart';

Future<void> authenticateAndStoreToken(String username, String password) async {
  final url = Uri.parse(
      'http://192.168.17.109:8082/KnowledgeBaseNETSQLServer/oauth/gam/v2.0/access_token');

  final headers = {
    'Content-Type': 'application/x-www-form-urlencoded',
  };

  final body = {
    'username': username,
    'password': password,
    'client_id': 'utbx9QaY1YzuE4TqZMdxvKxgHT5d4unNwbigpHYr',
    'client_secret': 'xtcHgRTcRa3ZX86Sq12Anb9U4wiAQdMarN8hWdTF',
    'grant_type': 'password',
    'scope': 'fullcontrol'
  };

  final request = http.Request('POST', url);
  request.bodyFields = body;
  request.headers.addAll(headers);

  final response = await request.send();

  if (response.statusCode == 200) {
    final responseBody = await response.stream.bytesToString();
    final responseData = json.decode(responseBody);
    final token = responseData['access_token'];
    if (token != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);

      // Recuperar os dados do usuário após armazenar o token
      await recuperarDadosUsuario(token);
    } else {
      throw Exception('Failed to retrieve token from response');
    }
  } else {
    throw Exception('Failed to authenticate: ${response.reasonPhrase}');
  }
}



Future<String> getToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('token') ?? '';
}