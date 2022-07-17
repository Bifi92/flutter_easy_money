class Recebimento {
  int id;
  String nome;
  double valor;

  Recebimento(this.id, this.nome, this.valor);

  @override
  String toString() {
    return 'id:$id ; nome:$nome ; valor:$valor';
  }
}
