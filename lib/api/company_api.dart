import 'package:online_shopping/models/company_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CompanyAPI {
  final _client = Supabase.instance.client;
  final String table = 'companies';

  Future<List<Company>> getAll() async {
    final response = await _client.from(table).select();
    return (response as List).map((e) => Company.fromMap(e)).toList();
  }

  Future<Company?> getById(int id) async {
    final data =
        await _client.from(table).select().eq('company_id', id).single();
    return Company.fromMap(data);
  }

  Future<void> insert(Company company) async {
    await _client.from(table).insert(company.toMap());
  }

  Future<void> update(Company company) async {
    await _client
        .from(table)
        .update(company.toMap())
        .eq('company_id', company.company_id);
  }

  Future<void> delete(int id) async {
    await _client.from(table).delete().eq('company_id', id);
  }
}
