import 'package:flutter/material.dart';
import 'package:product_list/app/shared/themes/typography_utils.dart';

class AppTitle extends StatelessWidget {
  final String title;
  const AppTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, top: 12.0),
      child: Text(
        title,
        style: context.headlineSmall!.copyWith(
            color: Theme.of(context).colorScheme.tertiary,
            fontWeight: FontWeight.w700),
      ),
    );
  }
}
