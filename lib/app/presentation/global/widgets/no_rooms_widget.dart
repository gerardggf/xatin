import 'package:flutter/material.dart';

class NoRoomsWidget extends StatelessWidget {
  const NoRoomsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Text(
          'Currently there are no rooms',
          style: TextStyle(fontSize: 24),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
