import 'package:flutter/material.dart';
import 'package:xatin/app/core/const/colors.dart';

SnackBar showCustomSnackBar(
  BuildContext context,
  String text, {
  Color color = AppColors.primary,
  int milliseconds = 2000,
}) {
  final snackBar = SnackBar(
    content: Text(text),
    duration: Duration(milliseconds: milliseconds),
    backgroundColor: color,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
  return snackBar;
}
