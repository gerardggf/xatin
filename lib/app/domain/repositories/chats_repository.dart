import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xatin/app/core/providers.dart';
import 'package:xatin/app/data/repositories_impl/chats_repository_impl.dart';

import '../models/message_model.dart';
import '../models/room_model.dart';

final chatsRepositoryProvider = Provider<ChatsRepository>(
  (ref) => ChatsRepositoryImpl(
    ref.watch(firebaseFirestoreProvider),
  ),
);

abstract class ChatsRepository {
  Stream<List<MessageModel>> subscribeToRoom(String roomId);
  Stream<List<RoomModel>> subscribeToRoomsList();
  Future<bool> sendMessage(String roomId, MessageModel message);
  Future<bool> createRoom(String roomName);
  Future<bool> deleteRoom(String roomId);
}
