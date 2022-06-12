import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:product_list/app/modules/products/domain/entities/product.dart';
import 'package:product_list/app/modules/products/presenter/models/products_options.dart';
import 'package:product_list/app/modules/products/presenter/widgets/image_selector.dart';
import 'package:product_list/app/modules/products/presenter/widgets/stars_rating.dart';
import 'package:product_list/app/shared/extensions/extensions.dart';
import 'package:product_list/app/shared/themes/typography_utils.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final double height;
  final void Function(ProductsOptions?) onChanged;
  ProductCard({
    Key? key,
    required this.product,
    this.height = 110,
    required this.onChanged,
  }) : super(key: key);

  final List<ProductsOptions> items = [
    ProductsOptions.update,
    ProductsOptions.delete
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            ImageSelector(
              image: null,
              height: height,
              width: 120,
              borderRadius: BorderRadius.circular(8.0),
            ),
            Expanded(
              child: SizedBox(
                height: height,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    product.title,
                                    style: context.titleSmall!.copyWith(
                                        overflow: TextOverflow.ellipsis),
                                    maxLines: 2,
                                    softWrap: true,
                                  ),
                                ),
                                SizedBox(
                                  width: 60,
                                  child: DropdownButton<ProductsOptions>(
                                    alignment: AlignmentDirectional.center,
                                    icon: const Icon(Icons.more_horiz_rounded),
                                    isDense: true,
                                    isExpanded: true,
                                    underline: const SizedBox(),
                                    items: items.map((ProductsOptions item) {
                                      return DropdownMenuItem(
                                        value: item,
                                        child: Text(
                                            item.toShortString().capitalize()),
                                      );
                                    }).toList(),
                                    onChanged: onChanged,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              product.type.capitalize(),
                              style: context.labelMedium,
                            ),
                            Text(
                              DateFormat.yMd()
                                  .add_Hm()
                                  .format(product.createdAt),
                              style: context.labelMedium,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          StarsRating(
                            rating: product.rating,
                            color: colorScheme.secondary,
                          ),
                          Text(
                            NumberFormat.currency(
                              symbol: 'R\$',
                              decimalDigits: 2,
                            ).format(product.price),
                            style: context.titleSmall,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
