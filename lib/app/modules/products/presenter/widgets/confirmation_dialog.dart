import 'package:flutter/material.dart';
import 'package:product_list/app/modules/products/domain/entities/product.dart';

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
        ElevatedButton(
          onPressed: onCancel,
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all<Size>(const Size(100, 45)),
            backgroundColor:
                MaterialStateProperty.all<Color>(colors.background),
            foregroundColor: MaterialStateProperty.all<Color>(colors.onSurface),
          ),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: onConfirm,
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all<Size>(const Size(100, 45)),
            backgroundColor:
                MaterialStateProperty.all<Color>(colors.errorContainer),
            foregroundColor: MaterialStateProperty.all<Color>(colors.error),
          ),
          child: const Text('Delete'),
        ),
      ],
    );
  }
}
