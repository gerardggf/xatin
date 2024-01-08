import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xatin/app/domain/repositories/chats_repository.dart';
import 'package:xatin/app/presentation/global/widgets/error_loading_widget.dart';
import 'package:xatin/app/presentation/global/widgets/loading_widget.dart';
import 'package:xatin/app/presentation/global/widgets/no_rooms_widget.dart';
import 'package:xatin/app/presentation/modules/home/widgets/room_tile_widget.dart';

final roomsListStreamProvider = StreamProvider(
  (ref) => ref.watch(chatsRepositoryProvider).subscribeToRoomsList(),
);

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  Widget build(BuildContext context) {
    final roomsListStream = ref.watch(roomsListStreamProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'xatin',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              ref.read(chatsRepositoryProvider).createRoom('prueba');
            },
            icon: const Icon(
              Icons.add,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: roomsListStream.when(
        data: (rooms) {
          if (rooms.isEmpty) return const NoRoomsWidget();
          return ListView.builder(
            itemCount: rooms.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final room = rooms[index];
              return RoomTileWidget(room: room);
            },
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
