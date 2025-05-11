import 'package:online_shopping/models/inventory_movement_models.dart';

import '../api/inventory_movement_api.dart';

class InventoryMovementService {
  final InventoryMovementAPI _api = InventoryMovementAPI();

  Future<List<InventoryMovement>> getAll() => _api.getAll();

  Future<InventoryMovement?> getById(int id) => _api.getById(id);

  Future<void> create(InventoryMovement movement) => _api.insert(movement);

  Future<void> update(InventoryMovement movement) => _api.update(movement);

  Future<void> delete(int id) => _api.delete(id);
}
