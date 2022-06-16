import 'dart:async';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:product_list/app/modules/products/domain/entities/product.dart';
import 'package:product_list/app/modules/products/domain/usecases/update_product.dart';
import 'package:product_list/app/modules/products/presenter/blocs/update_product/product_validator_mixin.dart';

part 'update_product_event.dart';
part 'update_product_state.dart';

class UpdateProductBloc extends Bloc<UpdateProductEvent, UpdateProductState>
    with ProductValidatorMixin {
  final UpdateProduct _updateProductUsecase;
  UpdateProductBloc(
    this._updateProductUsecase,
    Product? initialProduct,
  ) : super(UpdateProductState(
          initialProduct: initialProduct,
          title: initialProduct?.title ?? '',
          description: initialProduct?.description ?? '',
          type: initialProduct?.type ?? '',
          rating: initialProduct?.rating ?? 0,
          price: initialProduct?.price ?? 0,
          width: initialProduct?.width ?? 0,
          height: initialProduct?.height ?? 0,
        )) {
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
    emit(state.copyWith(type: event.type));
  }

  void _onPriceChanged(
      UpdateProductPriceEvent event, Emitter<UpdateProductState> emit) {
    emit(state.copyWith(price: double.tryParse(event.price)));
  }

  void _onRatingChanged(
      UpdateProductRatingEvent event, Emitter<UpdateProductState> emit) {
    final value = double.tryParse(event.rating) ?? 0;
    emit(state.copyWith(rating: value));
  }

  void _onWidthChanged(
      UpdateProductWidthEvent event, Emitter<UpdateProductState> emit) {
    final value = double.tryParse(event.width) ?? 0;
    emit(state.copyWith(width: value));
  }

  void _onHeightChanged(
      UpdateProductHeightEvent event, Emitter<UpdateProductState> emit) {
    final value = double.tryParse(event.height) ?? 0;
    emit(state.copyWith(height: value));
  }

  Future<void> _onSubmitted(UpdateProductSubmittedEvent event,
      Emitter<UpdateProductState> emit) async {
    final product = Product(
      id: state.initialProduct!.id,
      filename: state.initialProduct!.filename,
      createdAt: state.initialProduct!.createdAt,
      title: state.title,
      type: state.type,
      price: state.price,
      rating: state.rating,
      width: state.width,
      height: state.height,
      description: state.description,
    );

    try {
      await _updateProductUsecase(product);
      emit.call(state.copyWith(status: UpdateProductStatus.success));
    } catch (error) {
      emit.call(state.copyWith(status: UpdateProductStatus.error));
      emit.call(state.copyWith(status: UpdateProductStatus.update));
    }
  }
}
