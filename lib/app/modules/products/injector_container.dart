import 'package:get_it/get_it.dart';
import 'package:product_list/app/modules/products/domain/repositories/products_repository.dart';
import 'package:product_list/app/modules/products/domain/usecases/create_products.dart';
import 'package:product_list/app/modules/products/domain/usecases/delete_product.dart';
import 'package:product_list/app/modules/products/domain/usecases/get_products.dart';
import 'package:product_list/app/modules/products/domain/usecases/update_product.dart';
import 'package:product_list/app/modules/products/external/firebase/firebase_products_datasource_impl.dart';
import 'package:product_list/app/modules/products/infra/datasources/products_datasource.dart';
import 'package:product_list/app/modules/products/infra/repositories/products_repository_impl.dart';
import 'package:product_list/app/modules/products/presenter/blocs/products/products_bloc.dart';

final instance = GetIt.instance;

Future<void> init() async {
  _initDatasources();
  _initRepositories();
  _initUsecases();
  _initBlocs();
}

void _initDatasources() {
  instance.registerFactory<ProductsDatasource>(
      () => FirebaseProductsDatasource(instance(), instance()));
}

void _initRepositories() {
  instance.registerFactory<ProductsRepository>(
      () => ProductsRepositoryImpl(instance()));
}

void _initUsecases() {
  instance.registerFactory<GetProducts>(() => GetProductsImpl(instance()));
  instance
      .registerFactory<CreateProducts>(() => CreateProductsImpl(instance()));
  instance.registerFactory<UpdateProduct>(() => UpdateProductImpl(instance()));
  instance.registerFactory<DeleteProduct>(() => DeleteProductImpl(instance()));
}

void _initBlocs() {
  instance.registerFactory(() => ProductsBloc(
        instance(),
        instance(),
        instance(),
      ));
}
