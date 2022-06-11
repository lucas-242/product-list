import 'package:flutter/material.dart';
import 'package:product_list/app/shared/themes/app_images.dart';

class ImageSelector extends StatelessWidget {
  final String? image;
  final double? height;
  final double? width;
  final BorderRadius? borderRadius;
  final bool isNetworkImage;
  const ImageSelector({
    Key? key,
    required this.image,
    this.width,
    this.height,
    this.borderRadius,
    this.isNetworkImage = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: image != null && image != ''
          ? isNetworkImage
              ? Image.network(
                  image!,
                  width: width,
                  height: height,
                )
              : Image.asset(
                  image!,
                  fit: BoxFit.cover,
                  width: width,
                  height: height,
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
