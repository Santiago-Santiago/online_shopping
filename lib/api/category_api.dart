import 'package:online_shopping/models/category_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CategoryAPI {
  final _client = Supabase.instance.client;
  final String table = 'categories';

  Future<List<Category>> getAll() async {
    final response = await _client.from(table).select();
    return (response as List).map((e) => Category.fromMap(e)).toList();
  }

  Future<Category?> getByCode(String code) async {
    final data = await _client.from(table).select().eq('code', code).single();
    return Category.fromMap(data);
  }

  Future<void> insert(Category category) async {
    await _client.from(table).insert(category.toMap());
  }

  Future<void> update(Category category) async {
    await _client
        .from(table)
        .update(category.toMap())
        .eq('code', category.code);
  }

  Future<void> delete(String code) async {
    await _client.from(table).delete().eq('code', code);
  }
}
