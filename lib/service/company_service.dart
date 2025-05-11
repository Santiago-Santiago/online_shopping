import 'package:online_shopping/models/company_model.dart';

import '../api/company_api.dart';

class CompanyService {
  final CompanyAPI _api = CompanyAPI();

  Future<List<Company>> getAll() => _api.getAll();

  Future<Company?> getById(int id) => _api.getById(id);

  Future<void> create(Company company) => _api.insert(company);

  Future<void> update(Company company) => _api.update(company);

  Future<void> delete(int id) => _api.delete(id);
}
