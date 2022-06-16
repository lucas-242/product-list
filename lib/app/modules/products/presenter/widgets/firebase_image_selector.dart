import 'dart:io';

import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';
import 'package:product_list/app/modules/products/external/firebase/constants/firebase_constants.dart';
import 'package:product_list/app/shared/themes/app_images.dart';

class FirebaseImageSelector extends StatelessWidget {
  final String? image;
  final double? height;
  final double? width;
  final BorderRadius? borderRadius;
  final File? file;
  const FirebaseImageSelector({
    Key? key,
    required this.image,
    this.width,
    this.height,
    this.borderRadius,
    this.file,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: image != null || file != null
          ? file == null
              ? Image(
                  image: FirebaseImage(
                    FirebaseConstants.productImagesBucket + image!,
                  ),
                  width: width,
                  height: height,
                  fit: BoxFit.fill,
                )
              : FutureBuilder(
                  future: _getImage(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) =>
                      snapshot.data,
                  initialData: const Center(child: CircularProgressIndicator()),
                )
          : Image.asset(
              AppImages.noImage,
              fit: BoxFit.fitHeight,
              width: width,
              height: height,
            ),
    );
  }

  Future<Widget> _getImage() async {
    final exists = await file!.exists();
    if (!exists) {
      return const Text('Can\'t load image');
    }

    return Image.memory(
      file!.readAsBytesSync(),
      key: UniqueKey(),
      fit: BoxFit.cover,
      width: width,
      height: height,
    );
  }
}
