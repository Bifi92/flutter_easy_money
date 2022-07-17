import 'package:easy_money/dao/pagamentos_dao.dart';
import 'package:easy_money/dao/recebimentos_dao.dart';
import 'package:easy_money/models/pagamento.dart';
import 'package:easy_money/models/recebimento.dart';

class BalancoDao {
  Future<double> getTotalSobra() async {
    double totalPago = await getTotalPago();
    double totalRecebido = await getTotalRecebido();

    return totalRecebido - totalPago;
  }

  Future<double> getTotalPago() async {
    double total = 0;

    PagamentosDao pagamentosDao = PagamentosDao();

    for (Pagamento pagamento in await pagamentosDao.findAll()) {
      if (pagamento.isPago) {
        total = total + pagamento.valor;
      }
    }

    return total;
  }

  Future<double> getTotalRecebido() async {
    double total = 0;

    RecebimentosDao recebimentosDao = RecebimentosDao();

    for (Recebimento recebimento in await recebimentosDao.findAll()) {
      total = total + recebimento.valor;
    }

    return total;
  }
}
