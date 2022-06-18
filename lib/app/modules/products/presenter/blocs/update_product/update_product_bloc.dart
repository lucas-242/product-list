import 'dart:io';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:product_list/app/modules/products/domain/entities/product.dart';
import 'package:product_list/app/modules/products/domain/errors/products_errors.dart';
import 'package:product_list/app/modules/products/domain/usecases/update_product.dart';
import 'package:product_list/app/modules/products/domain/usecases/upload_product_image.dart';
import 'package:product_list/app/modules/products/presenter/blocs/update_product/product_validator_mixin.dart';
import 'package:product_list/app/shared/extensions/extensions.dart';

part 'update_product_event.dart';
part 'update_product_state.dart';

class UpdateProductBloc extends Bloc<UpdateProductEvent, UpdateProductState>
    with ProductValidatorMixin {
  final UpdateProduct _updateProductUsecase;
  final UploadProductImage _uploadProductImageUsecase;
  UpdateProductBloc(
    this._updateProductUsecase,
    this._uploadProductImageUsecase,
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
    on<UpdateProductImageEvent>(_onImageChanged);
    on<UpdateProductSubmittedEvent>(_onSubmitted);
  }

  void _onTitleChanged(
      UpdateProductTitleEvent event, Emitter<UpdateProductState> emit) {
    emit(
        state.copyWith(title: event.title, status: UpdateProductStatus.update));
  }

  void _onDescriptionChanged(
      UpdateProductDescriptionEvent event, Emitter<UpdateProductState> emit) {
    emit(state.copyWith(
        description: event.description, status: UpdateProductStatus.update));
  }

  void _onTypeChanged(
      UpdateProductTypeEvent event, Emitter<UpdateProductState> emit) {
    emit(state.copyWith(type: event.type, status: UpdateProductStatus.update));
  }

  void _onPriceChanged(
      UpdateProductPriceEvent event, Emitter<UpdateProductState> emit) {
    emit(state.copyWith(
        price: double.tryParse(event.price),
        status: UpdateProductStatus.update));
  }

  void _onRatingChanged(
      UpdateProductRatingEvent event, Emitter<UpdateProductState> emit) {
    final value = double.tryParse(event.rating) ?? 0;
    emit(state.copyWith(rating: value, status: UpdateProductStatus.update));
  }

  void _onWidthChanged(
      UpdateProductWidthEvent event, Emitter<UpdateProductState> emit) {
    final value = double.tryParse(event.width) ?? 0;
    emit(state.copyWith(width: value, status: UpdateProductStatus.update));
  }

  void _onHeightChanged(
      UpdateProductHeightEvent event, Emitter<UpdateProductState> emit) {
    final value = double.tryParse(event.height) ?? 0;
    emit(state.copyWith(height: value, status: UpdateProductStatus.update));
  }

  void _onImageChanged(
      UpdateProductImageEvent event, Emitter<UpdateProductState> emit) {
    emit.call(
        state.copyWith(image: event.image, status: UpdateProductStatus.update));
  }

  Future<void> _onSubmitted(UpdateProductSubmittedEvent event,
      Emitter<UpdateProductState> emit) async {
    emit.call(state.copyWith(status: UpdateProductStatus.loading));
    try {
      final uploadedImageName = await _uploadImage();
      final product = _getProductToUpdate(uploadedImageName);
      await _updateProductUsecase(product);
      emit.call(state.copyWith(status: UpdateProductStatus.success));
    } on InvalidProductImageFailure {
      _onError(emit, 'Invalid image');
    } on InvalidProductFailure {
      _onError(emit, 'Invalid product');
    } catch (error) {
      _onError(emit, 'Fail trying to update Product');
    }
  }

  Future<String?> _uploadImage() async {
    if (state.image == null) {
      return null;
    }

    //**
    //* If want to save space should delete the old files
    //* or maybe save the images with the same name and type
    // */
    final toUpload = await _renameFile();
    await _uploadProductImageUsecase(toUpload);
    return toUpload.getFileName();
  }

  Future<File> _renameFile() async {
    final newImageName = DateTime.now().millisecondsSinceEpoch.toString();
    return await state.image!.changeFileName(newImageName);
  }

  Product _getProductToUpdate(String? fileName) {
    return Product(
      id: state.initialProduct!.id,
      createdAt: state.initialProduct!.createdAt,
      title: state.title,
      type: state.type,
      price: state.price,
      rating: state.rating,
      width: state.width,
      height: state.height,
      description: state.description,
      filename: fileName ?? state.initialProduct!.filename,
    );
  }

  void _onError(Emitter<UpdateProductState> emit, String message) {
    emit.call(
        state.copyWith(status: UpdateProductStatus.error, message: message));
    emit.call(state.copyWith(status: UpdateProductStatus.update));
  }
}
