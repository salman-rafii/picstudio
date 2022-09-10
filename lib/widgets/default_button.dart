import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final Color bgColor;
  final Color textColor;
  const DefaultButton(
      {super.key,
      required this.onPressed,
      required this.child,
      required this.bgColor,
      required this.textColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(bgColor),
        textStyle: MaterialStateProperty.all<TextStyle>(
          TextStyle(
            color: textColor,
          ),
        ),
      ),
      child: child,
    );
  }
}
