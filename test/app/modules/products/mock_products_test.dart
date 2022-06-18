import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:product_list/app/modules/products/domain/entities/product.dart';
import 'package:product_list/app/modules/products/domain/repositories/products_repository.dart';
import 'package:product_list/app/modules/products/infra/datasources/products_datasource.dart';
import 'package:product_list/app/modules/products/infra/models/product_model.dart';
import 'package:product_list/app/modules/products/presenter/blocs/products/products_bloc.dart';

class FirebaseStorageTest extends Mock implements FirebaseStorage {}

class ProductsRepositoryTest extends Mock implements ProductsRepository {}

class ProductsDatasourceTest extends Mock implements ProductsDatasource {}

class StreamProductsTest extends Mock implements Stream<List<ProductModel>> {}

class MockProductsBloc extends MockBloc<ProductsEvent, ProductsState>
    implements ProductsBloc {}

Product get product => Product(
      id: 'test',
      title: 'Avocado',
      type: 'fruit',
      filename: '',
      price: 8.7,
      description: 'Test description',
      height: 50,
      width: 30,
      rating: 4.7,
    );

Product get invalidProduct => Product(
      id: 'test',
      title: 'test',
      type: 'test',
      filename: '',
      price: 0,
    );

ProductModel get productModel => ProductModel(
      id: 'test',
      title: 'Avocado',
      type: 'fruit',
      filename: '',
      price: 8.7,
      description: 'Test description',
      height: 50,
      width: 30,
      rating: 4.7,
    );

List<ProductModel> get productList => List<ProductModel>.generate(
    10, (index) => productModel.copyWith(id: index.toString()));

@GenerateMocks([
  ProductsRepositoryTest,
  StreamProductsTest,
  ProductsDatasourceTest,
])
void main() {}
