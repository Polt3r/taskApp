class Contato {
  String? sId;
  String? nome;
  String? email;
  String? telefone;
  String? endereco;
  String? foto;
  int? iV;

  Contato(
      {this.sId,
        this.nome,
        this.email,
        this.telefone,
        this.endereco,
        this.foto,
        this.iV});

  Contato.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    nome = json['nome'];
    email = json['email'];
    telefone = json['telefone'];
    endereco = json['endereco'];
    foto = json['foto'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['nome'] = nome;
    data['email'] = email;
    data['telefone'] = telefone;
    data['endereco'] = endereco;
    data['foto'] = foto;
    data['__v'] = iV;
    return data;
  }
}