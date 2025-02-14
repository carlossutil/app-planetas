class Planet {
  int? id;
  String nome;
  double distancia;
  double tamanho;
  String? apelido;

  Planet({this.id, required this.nome, required this.distancia, required this.tamanho, this.apelido});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'distancia': distancia,
      'tamanho': tamanho,
      'apelido': apelido,
    };
  }

  factory Planet.fromMap(Map<String, dynamic> map) {
    return Planet(
      id: map['id'],
      nome: map['nome'],
      distancia: map['distancia'].toDouble(),
      tamanho: map['tamanho'].toDouble(),
      apelido: map['apelido'],
    );
  }
}