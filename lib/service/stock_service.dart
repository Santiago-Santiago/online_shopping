import 'package:online_shopping/api/stock_api.dart';
import 'package:online_shopping/models/stock_model.dart';

class StockService {
  final StockAPI _api = StockAPI();

  Future<List<Stock>> getAllStocks() => _api.getAll();

  Future<Stock?> getStockByProductCode(String code) =>
      _api.getByProductCode(code);

  Future<void> createStock(Stock stock) => _api.insert(stock);

  Future<void> updateStock(Stock stock) => _api.update(stock);

  Future<void> deleteStock(String code) => _api.delete(code);
}
