import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:product_list/app/modules/products/domain/entities/product.dart';
import 'package:product_list/app/modules/products/domain/repositories/products_repository.dart';
import 'package:product_list/app/modules/products/infra/datasources/products_datasource.dart';
import 'package:product_list/app/modules/products/infra/models/product_model.dart';

class ProductsRepositoryTest extends Mock implements ProductsRepository {}

class ProductsDatasourceTest extends Mock implements ProductsDatasource {}

class StreamProductsTest extends Mock implements Stream<List<ProductModel>> {}

Product get product => Product(
      id: 'test',
      title: 'test',
      type: 'test',
      filename: 'test.png',
      price: 25.12,
    );

Product get invalidProduct => Product(
      id: 'test',
      title: 'test',
      type: 'test',
      filename: 'test.png',
      price: 0,
    );

ProductModel get productModel => ProductModel(
      id: 'test',
      title: 'test',
      type: 'test',
      filename: 'test.png',
      price: 25.12,
    );

List<ProductModel> get productList =>
    List<ProductModel>.generate(10, (index) => productModel);

@GenerateMocks([
  ProductsRepositoryTest,
  StreamProductsTest,
  ProductsDatasourceTest,
])
void main() {}
