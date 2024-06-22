import 'package:http/http.dart' as http;


Future<void> logoutUser({required String token}) async {

  var headers = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': 'Bearer $token',
  };
  var request = http.Request('GET', Uri.parse('http://192.168.17.109:8082/KnowledgeBaseNETSQLServer/TaskAPI/Logout'));
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    return;
  } else {
    throw Exception(response.reasonPhrase);
  }
}
