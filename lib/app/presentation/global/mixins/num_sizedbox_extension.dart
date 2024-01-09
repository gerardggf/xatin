import 'package:flutter/material.dart';

extension IntSizedBoxExtension on int {
  SizedBox get w => SizedBox(
        width: toDouble(),
      );
  SizedBox get h => SizedBox(
        height: toDouble(),
      );
}

extension DoubleSizedBoxExtension on double {
  SizedBox get w => SizedBox(
        width: this,
      );
  SizedBox get h => SizedBox(
        height: this,
      );
}
