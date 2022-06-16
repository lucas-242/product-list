import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:product_list/app/modules/products/domain/entities/product.dart';
import 'package:product_list/app/modules/products/presenter/blocs/update_product/update_product_bloc.dart';
import 'package:product_list/app/modules/products/presenter/widgets/custom_modal_bottom_sheet.dart';
import 'package:product_list/app/modules/products/presenter/widgets/custom_text_form_field.dart';
import 'package:product_list/app/modules/products/presenter/widgets/firebase_image_selector.dart';
import 'package:product_list/app/shared/themes/app_snackbar.dart';
import 'package:product_list/app/shared/widgets/elevated_button/app_elevated_button.dart';
import 'package:product_list/app/shared/widgets/title/app_title.dart';

class ProductUpdatePage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ProductUpdatePage({Key? key}) : super(key: key);

  static Route<void> route({Product? initialProduct}) {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => BlocProvider(
        create: (context) => UpdateProductBloc(
          GetIt.instance(),
          GetIt.instance(),
          initialProduct,
        ),
        child: ProductUpdatePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<UpdateProductBloc>();

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppTitle(title: 'Edit ${bloc.state.initialProduct?.title}'),
                  BlocListener<UpdateProductBloc, UpdateProductState>(
                    listener: (context, state) {
                      if (state.status == UpdateProductStatus.error) {
                        getAppSnackBar(
                          context: context,
                          message: state.message!,
                          type: SnackBarType.error,
                        );
                      } else if (state.status == UpdateProductStatus.success) {
                        getAppSnackBar(
                          context: context,
                          message: 'Product updated successfully',
                          type: SnackBarType.success,
                        );
                        Navigator.of(context).pop();
                      }
                    },
                    child: Expanded(
                      child: BlocBuilder<UpdateProductBloc, UpdateProductState>(
                          builder: (bloc, state) {
                        return state.when(
                          onState: (state) => _Form(formKey: _formKey),
                          onLoading: () =>
                              const Center(child: CircularProgressIndicator()),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Form extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  const _Form({required this.formKey});

  void validateForm(BuildContext context) {
    final form = formKey.currentState!;
    if (form.validate()) {
      final bloc = context.read<UpdateProductBloc>();
      bloc.add(UpdateProductSubmittedEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
        child: Column(
          children: [
            _ImagePicker(),
            const _TitleField(),
            const _TypeField(),
            const _DescriptionField(),
            const _PriceField(),
            const _RatingField(),
            const _WidthField(),
            const _HeightField(),
            AppElevatedButton(
              text: 'Update',
              onTap: () => validateForm(context),
            ),
          ],
        ),
      ),
    );
  }
}

class _ImagePicker extends StatelessWidget {
  final ImagePicker _picker = ImagePicker();
  _ImagePicker();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<UpdateProductBloc>();

    Future<void> _onBottomSheetTap(
        BuildContext context, ImageSource imageSource) async {
      Navigator.of(context).pop();
      final pickedFile = await _picker.pickImage(
        source: imageSource,
        imageQuality: 50,
      );
      if (pickedFile != null) {
        final file = File(pickedFile.path);
        bloc.add(UpdateProductImageEvent(file));
      }
    }

    void _showImagePicker(BuildContext context) {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return CustomModalBottomSheet(
            onGalleryTap: () => _onBottomSheetTap(context, ImageSource.gallery),
            onCameraTap: () => _onBottomSheetTap(context, ImageSource.camera),
          );
        },
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: InkWell(
        onTap: () => _showImagePicker(context),
        child: BlocBuilder<UpdateProductBloc, UpdateProductState>(
            builder: (bloc, state) {
          return FirebaseImageSelector(
            image: state.initialProduct?.filename,
            file: state.image,
            height: 140,
            width: 140,
            borderRadius: BorderRadius.circular(8.0),
          );
        }),
      ),
    );
  }
}

class _TitleField extends StatelessWidget {
  const _TitleField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<UpdateProductBloc>();
    const label = 'Title';

    return CustomTextFormField(
      key: const Key('title_formField'),
      labelText: label,
      hintText: 'Amazing Product',
      initialValue: bloc.state.title,
      onChanged: (value) => bloc.add(UpdateProductTitleEvent(value)),
      validator: (value) => bloc.validateFieldIsEmpty(value, fieldName: label),
    );
  }
}

class _TypeField extends StatelessWidget {
  const _TypeField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<UpdateProductBloc>();
    const label = 'Type';

    return CustomTextFormField(
      key: const Key('type_formField'),
      labelText: label,
      hintText: 'Amazing Product Type',
      initialValue: bloc.state.type,
      onChanged: (value) => bloc.add(UpdateProductTypeEvent(value)),
      validator: (value) => bloc.validateFieldIsEmpty(value, fieldName: label),
    );
  }
}

class _DescriptionField extends StatelessWidget {
  const _DescriptionField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<UpdateProductBloc>();
    const label = 'Description';

    return CustomTextFormField(
      key: const Key('description_formField'),
      labelText: label,
      hintText: 'Amazing Product Description',
      initialValue: bloc.state.description,
      onChanged: (value) => context
          .read<UpdateProductBloc>()
          .add(UpdateProductDescriptionEvent(value)),
    );
  }
}

class _PriceField extends StatelessWidget {
  const _PriceField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<UpdateProductBloc>();
    const label = 'Price';

    return CustomTextFormField(
      key: const Key('price_formField'),
      labelText: label,
      hintText: 'R\$0.00',
      initialValue: bloc.state.price.toString(),
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
      onChanged: (value) => bloc.add(UpdateProductPriceEvent(value)),
      validator: (value) => bloc.validatePriceField(value, fieldName: label),
    );
  }
}

class _RatingField extends StatelessWidget {
  const _RatingField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<UpdateProductBloc>();
    const label = 'Rating';

    return CustomTextFormField(
      key: const Key('rating_formField'),
      labelText: label,
      hintText: '0.0',
      initialValue: bloc.state.rating.toString(),
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
      onChanged: (value) => context
          .read<UpdateProductBloc>()
          .add(UpdateProductRatingEvent(value)),
      validator: (value) => bloc.validateNumberField(value, fieldName: label),
    );
  }
}

class _WidthField extends StatelessWidget {
  const _WidthField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<UpdateProductBloc>();
    const label = 'Width';

    return CustomTextFormField(
      key: const Key('width_formField'),
      labelText: label,
      hintText: '0.0',
      initialValue: bloc.state.width.toString(),
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
      onChanged: (value) => bloc.add(UpdateProductWidthEvent(value)),
      validator: (value) => bloc.validateNumberField(value, fieldName: label),
    );
  }
}

class _HeightField extends StatelessWidget {
  const _HeightField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<UpdateProductBloc>();
    const label = 'Height';

    return CustomTextFormField(
      key: const Key('height_formField'),
      labelText: label,
      hintText: '0.0',
      initialValue: bloc.state.height.toString(),
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.done,
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
      onChanged: (value) => bloc.add(UpdateProductHeightEvent(value)),
      validator: (value) => bloc.validateNumberField(value, fieldName: label),
    );
  }
}
