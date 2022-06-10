import 'package:product_list/app/modules/products/domain/entities/product.dart';
import 'package:product_list/app/modules/products/infra/models/product_model.dart';

abstract class ProductDataSource {
  Stream<List<ProductModel>> getProducts();
  Future<void> deleteProduct(String id);
  Future<void> updateProduct(Product product);
}
