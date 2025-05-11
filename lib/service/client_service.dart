import 'package:online_shopping/models/client_model.dart';
import '../api/client_api.dart';

class ClientService {
  final ClientAPI _api = ClientAPI();

  Future<List<Client>> getAll() => _api.getAll();

  Future<Client?> getById(int id) => _api.getById(id);

  Future<void> create(Client client) => _api.insert(client);

  Future<void> update(Client client) => _api.update(client);

  Future<void> delete(int id) => _api.delete(id);
}
