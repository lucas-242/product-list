import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:product_list/app/modules/products/domain/entities/product.dart';
import 'package:product_list/app/modules/products/presenter/widgets/image_selector.dart';
import 'package:product_list/app/modules/products/presenter/widgets/stars_rating.dart';
import 'package:product_list/app/shared/extensions/extensions.dart';
import 'package:product_list/app/shared/themes/typography_utils.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final double height;
  const ProductCard({Key? key, required this.product, this.height = 100})
      : super(key: key);

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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                product.title,
                                style: context.titleSmall,
                              ),
                              const IconButton(
                                onPressed: null,
                                icon: Icon(Icons.more_horiz_rounded),
                              )
                            ],
                          ),
                          Text(
                            product.type.capitalize(),
                            style: context.labelMedium,
                          ),
                        ],
                      ),
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
