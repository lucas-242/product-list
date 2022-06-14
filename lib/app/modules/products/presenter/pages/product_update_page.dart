import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:product_list/app/modules/products/domain/entities/product.dart';
import 'package:product_list/app/modules/products/presenter/blocs/update_product/update_product_bloc.dart';
import 'package:product_list/app/modules/products/presenter/widgets/custom_text_form_field.dart';
import 'package:product_list/app/modules/products/presenter/widgets/image_selector.dart';
import 'package:product_list/app/shared/widgets/elevated_button/app_elevated_button.dart';
import 'package:product_list/app/shared/widgets/title/app_title.dart';

class ProductUpdatePage extends StatelessWidget {
  const ProductUpdatePage({Key? key}) : super(key: key);

  static Route<void> route({required Product initialProduct}) {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => BlocProvider(
        create: (context) => UpdateProductBloc(
          GetIt.instance(),
          initialProduct,
        ),
        child: const ProductUpdatePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<UpdateProductBloc>();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppTitle(title: 'Edit ${bloc.state.initialProduct?.title}'),
              BlocListener<UpdateProductBloc, UpdateProductState>(
                listenWhen: (previous, current) =>
                    previous != current && current is SucessUpdateProductState,
                listener: (context, state) => Navigator.of(context).pop(),
                child: _Form(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Form extends StatelessWidget {
  final priceController = TextEditingController();
  final ratingController = TextEditingController();
  final heightController = TextEditingController();
  final widthController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: ImageSelector(
                image: null,
                height: 140,
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            const _TitleField(),
            const _TypeField(),
            const _DescriptionField(),
            const _PriceField(),
            const _RatingField(),
            const _WidthField(),
            const _HeightField(),
            AppElevatedButton(
              text: 'Submit',
              onTap: () => null,
            ),
          ],
        ),
      ),
    );
  }
}

class _TitleField extends StatelessWidget {
  const _TitleField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<UpdateProductBloc>();

    return CustomTextFormField(
      key: const Key('title_formField'),
      labelText: 'Title',
      hintText: 'Amazing Product',
      initialValue: bloc.state.initialProduct?.title,
      onChanged: (value) => bloc.add(UpdateProductTitleEvent(value)),
    );
  }
}

class _TypeField extends StatelessWidget {
  const _TypeField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<UpdateProductBloc>();

    return CustomTextFormField(
      key: const Key('type_formField'),
      labelText: 'Type',
      hintText: 'Amazing Product Type',
      initialValue: bloc.state.initialProduct?.type,
      onChanged: (value) => bloc.add(UpdateProductTypeEvent(value)),
    );
  }
}

class _DescriptionField extends StatelessWidget {
  const _DescriptionField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<UpdateProductBloc>();

    return CustomTextFormField(
      key: const Key('description_formField'),
      labelText: 'Description',
      hintText: 'Amazing Product Description',
      initialValue: bloc.state.initialProduct?.description,
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

    return CustomTextFormField(
      key: const Key('price_formField'),
      labelText: 'Price',
      hintText: 'R\$0.00',
      initialValue: bloc.state.initialProduct?.price.toString(),
      keyboardType: TextInputType.number,
      onChanged: (value) => bloc.add(UpdateProductPriceEvent(value)),
    );
  }
}

class _RatingField extends StatelessWidget {
  const _RatingField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<UpdateProductBloc>();

    return CustomTextFormField(
      key: const Key('rating_formField'),
      labelText: 'Rating',
      hintText: '0.0',
      initialValue: bloc.state.initialProduct?.rating.toString(),
      keyboardType: TextInputType.number,
      onChanged: (value) => context
          .read<UpdateProductBloc>()
          .add(UpdateProductRatingEvent(value)),
    );
  }
}

class _WidthField extends StatelessWidget {
  const _WidthField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<UpdateProductBloc>();

    return CustomTextFormField(
      key: const Key('width_formField'),
      labelText: 'Width',
      hintText: '0.0',
      initialValue: bloc.state.initialProduct?.width.toString(),
      keyboardType: TextInputType.number,
      onChanged: (value) => bloc.add(UpdateProductWidthEvent(value)),
    );
  }
}

class _HeightField extends StatelessWidget {
  const _HeightField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<UpdateProductBloc>();

    return CustomTextFormField(
      key: const Key('height_formField'),
      labelText: 'Height',
      hintText: '0.0',
      initialValue: bloc.state.initialProduct?.height.toString(),
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.done,
      onChanged: (value) => bloc.add(UpdateProductHeightEvent(value)),
    );
  }
}
