import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';
import 'package:product_list/app/modules/products/external/firebase/constants/firebase_constants.dart';
import 'package:product_list/app/shared/themes/app_images.dart';

class FirebaseImageSelector extends StatelessWidget {
  final String? image;
  final double? height;
  final double? width;
  final BorderRadius? borderRadius;
  const FirebaseImageSelector({
    Key? key,
    required this.image,
    this.width,
    this.height,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: image != null && image != ''
          ? Image(
              image: FirebaseImage(
                FirebaseConstants.productImagesBucket + image!,
              ),
              width: width,
              height: height,
              fit: BoxFit.fill,
            )
          : Image.asset(
              AppImages.noImage,
              fit: BoxFit.fitHeight,
              width: width,
              height: height,
            ),
    );
  }
}
