import 'dart:async';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:product_list/app/modules/products/domain/entities/product.dart';
import 'package:product_list/app/modules/products/domain/usecases/update_product.dart';

part 'update_product_event.dart';
part 'update_product_state.dart';

class UpdateProductBloc extends Bloc<UpdateProductEvent, UpdateProductState> {
  final UpdateProduct _updateProductUsecase;
  UpdateProductBloc(
    this._updateProductUsecase,
    Product initialProduct,
  ) : super(UpdateProductState(initialProduct: initialProduct)) {
    on<UpdateProductTitleEvent>(_onTitleChanged);
    on<UpdateProductDescriptionEvent>(_onDescriptionChanged);
    on<UpdateProductTypeEvent>(_onTypeChanged);
    on<UpdateProductPriceEvent>(_onPriceChanged);
    on<UpdateProductRatingEvent>(_onRatingChanged);
    on<UpdateProductWidthEvent>(_onWidthChanged);
    on<UpdateProductHeightEvent>(_onHeightChanged);
    on<UpdateProductSubmittedEvent>(_onSubmitted);
  }

  void _onTitleChanged(
      UpdateProductTitleEvent event, Emitter<UpdateProductState> emit) {
    emit(state.copyWith(title: event.title));
  }

  void _onDescriptionChanged(
      UpdateProductDescriptionEvent event, Emitter<UpdateProductState> emit) {
    emit(state.copyWith(description: event.description));
  }

  void _onTypeChanged(
      UpdateProductTypeEvent event, Emitter<UpdateProductState> emit) {
    emit(state.copyWith(description: event.type));
  }

  void _onPriceChanged(
      UpdateProductPriceEvent event, Emitter<UpdateProductState> emit) {
    emit(state.copyWith(description: event.price));
  }

  void _onRatingChanged(
      UpdateProductRatingEvent event, Emitter<UpdateProductState> emit) {
    emit(state.copyWith(description: event.rating));
  }

  void _onWidthChanged(
      UpdateProductWidthEvent event, Emitter<UpdateProductState> emit) {
    emit(state.copyWith(description: event.width));
  }

  void _onHeightChanged(
      UpdateProductHeightEvent event, Emitter<UpdateProductState> emit) {
    emit(state.copyWith(description: event.height));
  }

  Future<void> _onSubmitted(UpdateProductSubmittedEvent event,
      Emitter<UpdateProductState> emit) async {
    final product = Product(
      title: state.title,
      type: state.type,
      filename: '',
      price: state.price,
      rating: state.rating,
      width: state.width,
      height: state.height,
    );
    return await _updateProductUsecase(product);
  }
}
