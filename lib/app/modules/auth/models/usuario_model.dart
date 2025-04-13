class UsuarioModel {
  String id = "";
  String nome = "";
  String email = "";
  String senha = "";
  String tipo = "";
  String telefone = "";

  UsuarioModel({
    required this.id,
    required this.nome,
    required this.email,
    required this.senha,
    required this.tipo,
    required this.telefone,
  });

  factory UsuarioModel.fromMap(Map<String, dynamic> map) {
    return UsuarioModel(
      id: map['id'],
      nome: map['nome'],
      email: map['email'],
      senha: map['senha'],
      tipo: map['tipo'],
      telefone: map['telefone'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'email': email,
      'senha': senha,
      'tipo': tipo,
      'telefone': telefone,
    };
  }

  copyWith({required id}) {}
}
