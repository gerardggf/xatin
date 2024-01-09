import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:xatin/app/domain/models/message_model.dart';
import 'package:xatin/app/presentation/global/mixins/num_sizedbox_extension.dart';
import 'package:xatin/app/presentation/global/utils/map_datetimes.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget({
    super.key,
    required this.message,
    required this.isMine,
  });

  final MessageModel message;
  final bool isMine;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
          margin: isMine
              ? const EdgeInsets.only(right: 12, top: 5)
                  .copyWith(left: 30, bottom: 2)
              : const EdgeInsets.only(left: 12, top: 5)
                  .copyWith(right: 30, bottom: 2),
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            color:
                isMine ? Colors.black : const Color.fromARGB(255, 46, 121, 49),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment:
                isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                message.user,
                textAlign: isMine ? TextAlign.end : TextAlign.start,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                message.content,
                textAlign: isMine ? TextAlign.end : TextAlign.start,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            '${mapDay(message.creationDate)} ${DateFormat('HH:mm').format(message.creationDate)}',
            style: const TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 11,
            ),
          ),
        ),
        5.h,
      ],
    );
  }
}
