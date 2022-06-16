import 'package:flutter/material.dart';

class CustomModalBottomSheet extends StatelessWidget {
  final VoidCallback onGalleryTap;
  final VoidCallback onCameraTap;
  const CustomModalBottomSheet(
      {Key? key, required this.onGalleryTap, required this.onCameraTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Wrap(
        children: [
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: const Text('Gallery'),
            onTap: onGalleryTap,
          ),
          ListTile(
            leading: const Icon(Icons.photo_camera),
            title: const Text('Camera'),
            onTap: onCameraTap,
          ),
        ],
      ),
    );
  }
}
