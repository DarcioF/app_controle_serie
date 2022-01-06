class Serie {
  final int id;
  final String nome;
  final int numero_epsodio;
  final int numero_temporada;

  Serie(this.id, this.nome, this.numero_epsodio, this.numero_temporada);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'numero_epsodio': numero_epsodio,
      'numero_temporada': numero_temporada,
    };
  }
}
