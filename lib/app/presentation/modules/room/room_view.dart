import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xatin/app/domain/models/message_model.dart';
import 'package:xatin/app/domain/repositories/chats_repository.dart';
import 'package:xatin/app/presentation/global/widgets/error_loading_widget.dart';
import 'package:xatin/app/presentation/global/widgets/loading_widget.dart';
import 'package:xatin/app/presentation/modules/room/widgets/message_widget.dart';

final roomMessagesStreamProvider =
    StreamProvider.family.autoDispose<List<MessageModel>, String>(
  (ref, roomId) => ref.watch(chatsRepositoryProvider).subscribeToRoom(roomId),
);

class RoomView extends ConsumerStatefulWidget {
  const RoomView({
    super.key,
    required this.roomId,
  });

  final String roomId;

  @override
  ConsumerState<RoomView> createState() => _RoomViewState();
}

class _RoomViewState extends ConsumerState<RoomView> {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final roomMessagesStream = ref.watch(
      roomMessagesStreamProvider(widget.roomId),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: const Text(
          'Chat',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: roomMessagesStream.when(
        data: (messages) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: messages.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    if (message.id == 'init') {
                      return Container(
                        margin: const EdgeInsets.all(3),
                        child: Text(
                          message.content,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      );
                    }
                    return MessageWidget(
                      message: message,
                      //TODO: add users
                      isMine: message.user == 'prueba',
                    );
                  },
                ),
              ),
              SizedBox(
                height: kToolbarHeight,
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(
                          controller: _textController,
                          decoration: const InputDecoration(
                            hintText: 'Write message…',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        ref.read(chatsRepositoryProvider).sendMessage(
                              widget.roomId,
                              MessageModel(
                                user: 'antonio',
                                creationDate: DateTime.now(),
                                content: _textController.text,
                                id: '',
                              ),
                            );
                        _textController.text = '';
                      },
                      icon: const Icon(Icons.send),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
        error: (e, __) => ErrorLoadigWidget(
          errorMessage: e.toString(),
        ),
        loading: () => const LoadingWidget(),
      ),
    );
  }
}
