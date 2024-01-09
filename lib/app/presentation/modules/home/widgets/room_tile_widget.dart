import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:xatin/app/domain/models/room_model.dart';
import 'package:xatin/app/presentation/routes/routes.dart';

class RoomTileWidget extends StatelessWidget {
  const RoomTileWidget({
    super.key,
    required this.room,
  });

  final RoomModel room;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        print(room.id);
        context.pushNamed(Routes.room, pathParameters: {
          "roomId": room.id ?? '',
        });
      },
      leading: const CircleAvatar(
        backgroundColor: Colors.green,
      ),
      title: Text(
        room.name,
        style: const TextStyle(color: Colors.black),
      ),
      subtitle: Text(
        room.users.length.toString(),
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            DateFormat('HH:mm').format(room.creationDate),
          ),
          Text(
            DateFormat('dd/MM/yyyy').format(room.creationDate),
            style: const TextStyle(
              fontSize: 11,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
