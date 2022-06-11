import 'package:product_list/app/modules/products/domain/entities/product.dart';

abstract class ProductsRepository {
  Stream<List<Product>> getProducts();
  Future<void> deleteProduct(String id);
  Future<void> updateProduct(Product product);
}
