import 'package:online_shopping/models/category_model.dart';
import '../api/category_api.dart';

class CategoryService {
  final CategoryAPI _api = CategoryAPI();

  Future<List<Category>> getAll() => _api.getAll();

  Future<Category?> getByCode(String code) => _api.getByCode(code);

  Future<void> create(Category category) => _api.insert(category);

  Future<void> update(Category category) => _api.update(category);

  Future<void> delete(String code) => _api.delete(code);
}
