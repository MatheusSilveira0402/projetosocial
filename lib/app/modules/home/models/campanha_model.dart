class CampanhaModel {
  final String id ;
  final String titulo;
  final String descricao;
  final String tiposDoacao;
  final String localEntrega;
  final String contato;
  final String dataFim;

  CampanhaModel({
    required this.id,
    required this.titulo,
    required this.descricao,
    required this.tiposDoacao,
    required this.localEntrega,
    required this.contato,
    required this.dataFim,
  });

  Map<String, dynamic> toMap() {
  return {
    'id': id,
    'titulo': titulo,
    'descricao': descricao,
    'tiposdoacao': tiposDoacao, 
    'localentrega': localEntrega,
    'contato': contato,
    'datafim': dataFim, 
  };
}

factory CampanhaModel.fromMap(Map<String, dynamic> map) {
  return CampanhaModel(
    id: map['id'] ?? '',
    titulo: map['titulo'] ?? '',
    descricao: map['descricao'] ?? '',
    tiposDoacao: map['tiposdoacao'] ?? '',
    localEntrega: map['localentrega'] ?? '',
    contato: map['contato'] ?? '',
    dataFim: map['datafim'] ?? '', 
  );
}

}
