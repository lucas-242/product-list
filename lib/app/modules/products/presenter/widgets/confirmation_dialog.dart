import 'package:flutter/material.dart';
import 'package:product_list/app/modules/products/domain/entities/product.dart';
import 'package:product_list/app/shared/widgets/elevated_button/app_elevated_button.dart';

class ConfirmationDialog extends StatelessWidget {
  final VoidCallback onCancel;
  final VoidCallback onConfirm;
  final Product product;

  const ConfirmationDialog({
    Key? key,
    required this.onConfirm,
    required this.product,
    required this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var colors = Theme.of(context).colorScheme;
    return AlertDialog(
      title: Text("Delete ${product.title}"),
      content: const Text("Would you like to delete this product?"),
      actions: [
        AppElevatedButton(
          onTap: onCancel,
          text: 'Cancel',
          backgroundColor: colors.background,
          foregroundColor: colors.onSurface,
        ),
        AppElevatedButton(
          onTap: onConfirm,
          text: 'Delete',
          backgroundColor: colors.errorContainer,
          foregroundColor: colors.error,
        ),
      ],
    );
  }
}
