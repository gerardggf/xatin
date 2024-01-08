import 'package:flutter/material.dart';
import 'package:xatin/app/domain/models/message_model.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget({
    super.key,
    required this.message,
  });

  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    return Text(message.content);
  }
}
