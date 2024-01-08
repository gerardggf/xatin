import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xatin/app/data/repositories_impl/chats_repository_impl.dart';

import '../models/message_model.dart';

final chatsRepositoryProvider = Provider<ChatsRepository>(
  (ref) => ChatsRepositoryImpl(),
);

abstract class ChatsRepository {
  Stream<List<MessageModel>> subscribeToRoom();
  Future<MessageModel> sendMessage(String roomId);
}
