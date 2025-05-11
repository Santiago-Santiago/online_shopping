import 'package:online_shopping/models/client_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ClientAPI {
  final _client = Supabase.instance.client;
  final String table = 'clients';

  Future<List<Client>> getAll() async {
    final response = await _client.from(table).select();
    return (response as List).map((e) => Client.fromMap(e)).toList();
  }

  Future<Client?> getById(int id) async {
    final data =
        await _client.from(table).select().eq('client_id', id).single();
    return Client.fromMap(data);
  }

  Future<void> insert(Client client) async {
    await _client.from(table).insert(client.toMap());
  }

  Future<void> update(Client client) async {
    await _client
        .from(table)
        .update(client.toMap())
        .eq('client_id', client.client_id);
  }

  Future<void> delete(int id) async {
    await _client.from(table).delete().eq('client_id', id);
  }
}
