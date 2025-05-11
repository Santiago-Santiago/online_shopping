import 'package:online_shopping/models/stock_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StockAPI {
  final _client = Supabase.instance.client;
  final String table = 'stocks';

  Future<List<Stock>> getAll() async {
    final response = await _client.from(table).select();
    return (response as List).map((item) => Stock.fromMap(item)).toList();
  }

  Future<Stock?> getByProductCode(String code) async {
    final response =
        await _client.from(table).select().eq('product_code', code).single();
    return Stock.fromMap(response);
  }

  Future<void> insert(Stock stock) async {
    await _client.from(table).insert(stock.toMap());
  }

  Future<void> update(Stock stock) async {
    await _client
        .from(table)
        .update(stock.toMap())
        .eq('product_code', stock.product_code);
  }

  Future<void> delete(String code) async {
    await _client.from(table).delete().eq('product_code', code);
  }
}
