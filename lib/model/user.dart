class User {
  final String apelido;
  late final String nome;
  late final String email;
  final String numero;
  final String foto;

  User({
    required this.apelido,
    required this.nome,
    required this.email,
    required this.numero,
    required this.foto,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      apelido: json['UsuarioApelido'],
      nome: json['UsuarioNome'],
      email: json['UsuarioEmail'],
      numero: json['UsuarioNumero'],
      foto: json['UsuarioFoto'] ?? 'images/a_dot_burr.jpeg',
    );
  }
}
