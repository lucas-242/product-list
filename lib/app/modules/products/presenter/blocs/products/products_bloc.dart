// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:product_list/app/modules/products/domain/entities/product.dart';
import 'package:product_list/app/modules/products/domain/usecases/create_products.dart';
import 'package:product_list/app/modules/products/domain/usecases/delete_product.dart';
import 'package:product_list/app/modules/products/domain/usecases/get_products.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final GetProducts _getProductsUsecase;
  final DeleteProduct _deleteProductUsecase;
  final CreateProducts _createProductUsecase;

  ProductsBloc(
    this._getProductsUsecase,
    this._deleteProductUsecase,
    this._createProductUsecase,
  ) : super(const ListedState(products: [])) {
    on<GetProductsEvent>(_onInit);
    on<DeleteProductEvent>(_onDelete);
    on<CreateProductsEvent>(_onCreate);
  }

  void _onInit(GetProductsEvent event, Emitter<ProductsState> emit) async {
    emit.call(LoadingState(products: state.products));
    await _getProducts(emit);
  }

  Future<void> _getProducts(Emitter<ProductsState> emit) async {
    var stream = _getProductsUsecase();
    await emit.forEach(stream, onData: (List<Product> data) {
      if (data.isEmpty) {
        return NoDataState();
      } else if (state.products.length > data.length) {
        return SuccessState(
            products: data, message: 'Product deleted successfully');
      }
      return ListedState(products: data);
    });
  }

  void _onDelete(DeleteProductEvent event, Emitter<ProductsState> emit) async {
    emit.call(LoadingState(products: state.products));
    await _deleteProduct(event, emit);
  }

  Future<void> _deleteProduct(
      DeleteProductEvent event, Emitter<ProductsState> emit) async {
    await _deleteProductUsecase(event.id).catchError(
      (error) => emit
          .call(ErrorState(products: state.products, message: error.message)),
    );
  }

  void _onCreate(CreateProductsEvent event, Emitter<ProductsState> emit) async {
    emit.call(LoadingState(products: state.products));
    await _createProducts(event, emit);
  }

  Future<void> _createProducts(
      CreateProductsEvent event, Emitter<ProductsState> emit) async {
    await _createProductUsecase().catchError((error) {
      emit.call(NoDataState());
    });
  }
}
