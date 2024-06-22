import 'dart:convert';
import 'package:http/http.dart' as http;
import 'auth.dart';

Future<void> cadastrarUsuario({
  required String apelido,
  required String nome,
  required String email,
  required String senha,
}) async {
  var headers = {
    'Content-Type': 'application/json',
  };
  var request = http.Request(
      'POST',
      Uri.parse(
          'http://192.168.17.109:8082/KnowledgeBaseNETSQLServer/TaskNoAuth/CadastrarUsuario'));
  request.body = json.encode({
    "UsuarioSDT": {
      "UsuarioApelido": apelido,
      "UsuarioNome": nome,
      "UsuarioEmail": email,
      "UsuarioNumero": 0,
      "UsuarioSenha": senha,
      "UsuarioFoto": "",
      "UsuarioStatus": true
    }
  });
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    try {
      await authenticateAndStoreToken(email, senha);
        return;
    } catch (e) {
      throw Exception("Falha ao cadastrar usuário");
    }
  } else {
    throw Exception("Falha ao cadastrar usuário");
  }
}
