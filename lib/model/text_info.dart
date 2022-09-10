import 'package:flutter/material.dart';

class TextInfo {
  String text;
  double left;
  double top;
  Color color;
  FontWeight fontWeight;
  FontStyle fontStyle;
  double fontSize;
  TextAlign textAlign;

  TextInfo(
      {Key? key,
      required this.text,
      required this.left,
      required this.textAlign,
      required this.top,
      required this.color,
      required this.fontWeight,
      required this.fontSize,
      required this.fontStyle});
}
