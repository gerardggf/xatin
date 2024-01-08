import 'package:flutter/material.dart';

class ErrorLoadigWidget extends StatelessWidget {
  const ErrorLoadigWidget({
    super.key,
    required this.errorMessage,
  });

  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'An error has occurred\n$errorMessage',
        textAlign: TextAlign.center,
      ),
    );
  }
}
