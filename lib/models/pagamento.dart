class Pagamento {
  int id;
  String nome;
  double valor;
  bool isPago;

  Pagamento(this.id, this.nome, this.valor, this.isPago);

  @override
  String toString() {
    return 'id:$id ; nome:$nome ; valor:$valor ; isPago:$isPago';
  }
}
