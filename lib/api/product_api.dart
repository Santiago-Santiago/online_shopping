import 'package:online_shopping/models/product_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductAPI {
  final _client = Supabase.instance.client;
  final String table = 'products';

  Future<List<Product>> getAll() async {
    final response = await _client.from(table).select();
    return (response as List).map((item) => Product.fromMap(item)).toList();
  }

  Future<Product?> getByCode(String code) async {
    final response =
        await _client.from(table).select().eq('product_code', code).single();
    return Product.fromMap(response);
  }

  Future<void> insert(Product product) async {
    await _client.from(table).insert(product.toMap());
  }

  Future<void> update(Product product) async {
    await _client
        .from(table)
        .update(product.toMap())
        .eq('product_code', product.product_code);
  }

  Future<void> delete(String code) async {
    await _client.from(table).delete().eq('product_code', code);
  }
}
