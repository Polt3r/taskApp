import 'dart:convert';

import '../model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static SharedPreferences? _preferences;

  static const _keyUser = 'user';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setUser(User user) async {
    final json = jsonEncode({
      'UsuarioApelido': user.apelido,
      'UsuarioNome': user.nome,
      'UsuarioEmail': user.email,
      'UsuarioNumero': user.numero,
    });
    await _preferences?.setString(_keyUser, json);
  }

  static User? getUser() {
    final json = _preferences?.getString(_keyUser);
    if (json != null) {
      final Map<String, dynamic> map = jsonDecode(json);
      return User.fromJson(map);
    }
    return null;
    
  }
}
