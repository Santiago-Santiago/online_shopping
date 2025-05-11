import 'package:online_shopping/models/inventory_movement_models.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class InventoryMovementAPI {
  final _client = Supabase.instance.client;
  final String table = 'inventory_movements';

  Future<List<InventoryMovement>> getAll() async {
    final response = await _client.from(table).select();
    return (response as List).map((e) => InventoryMovement.fromMap(e)).toList();
  }

  Future<InventoryMovement?> getById(int id) async {
    final data =
        await _client.from(table).select().eq('movement_id', id).single();
    return InventoryMovement.fromMap(data);
  }

  Future<void> insert(InventoryMovement movement) async {
    await _client.from(table).insert(movement.toMap());
  }

  Future<void> update(InventoryMovement movement) async {
    await _client
        .from(table)
        .update(movement.toMap())
        .eq('movement_id', movement.movement_id);
  }

  Future<void> delete(int id) async {
    await _client.from(table).delete().eq('movement_id', id);
  }
}
