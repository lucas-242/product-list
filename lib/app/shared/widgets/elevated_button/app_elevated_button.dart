import 'package:flutter/material.dart';

class AppElevatedButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const AppElevatedButton(
      {Key? key,
      required this.onTap,
      required this.text,
      this.backgroundColor,
      this.foregroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: key,
      onPressed: onTap,
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all<Size>(const Size(100, 45)),
        backgroundColor: backgroundColor != null
            ? MaterialStateProperty.all<Color>(backgroundColor!)
            : null,
        foregroundColor: foregroundColor != null
            ? MaterialStateProperty.all<Color>(foregroundColor!)
            : null,
      ),
      child: Text(text),
    );
  }
}
