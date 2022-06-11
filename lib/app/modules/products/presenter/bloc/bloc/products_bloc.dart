// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:product_list/app/modules/products/domain/entities/product.dart';
import 'package:product_list/app/modules/products/domain/usecases/get_products.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final GetProducts _getProductsUsecase;

  ProductsBloc(this._getProductsUsecase)
      : super(const ListedState(products: [])) {
    on<GetProductsEvent>(_onInit);
  }

  void _onInit(GetProductsEvent event, Emitter<ProductsState> emit) async {
    emit.call(LoadingState());
    await _getProducts(emit);
  }

  Future<void> _getProducts(Emitter<ProductsState> emit) async {
    var stream = _getProductsUsecase();
    await emit.forEach(stream, onData: (List<Product> data) {
      if (data.isEmpty) {
        return const ErrorState('There is no data');
      }
      return ListedState(products: data);
    });
  }
}
