import 'package:online_shopping/api/product_api.dart';
import 'package:online_shopping/models/product_model.dart';

class ProductService {
  final ProductAPI _api = ProductAPI();

  Future<List<Product>> getAllProducts() => _api.getAll();

  Future<Product?> getProductByCode(String code) => _api.getByCode(code);

  Future<void> createProduct(Product product) => _api.insert(product);

  Future<void> updateProduct(Product product) => _api.update(product);

  Future<void> deleteProduct(String code) => _api.delete(code);
}
