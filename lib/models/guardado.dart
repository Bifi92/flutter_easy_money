class Guardado {
  int id;
  String nome;
  double valor;

  Guardado(this.id, this.nome, this.valor);

  @override
  String toString() {
    return 'id:$id ; nome:$nome ; valor:$valor';
  }
}
