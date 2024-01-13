import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:xatin/app/domain/repositories/chats_repository.dart';
import 'package:xatin/app/presentation/global/utils/show_custom_snack_bar.dart';
import 'package:xatin/app/presentation/global/widgets/error_loading_widget.dart';
import 'package:xatin/app/presentation/global/widgets/loading_widget.dart';
import 'package:xatin/app/presentation/global/widgets/no_rooms_widget.dart';
import 'package:xatin/app/presentation/modules/home/home_controller.dart';
import 'package:xatin/app/presentation/modules/home/widgets/room_tile_widget.dart';

import '../../../core/const/colors.dart';

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
    final notifier = ref.read(homeControllerProvider.notifier);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'xatin',
          style: TextStyle(
            color: AppColors.primary,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: const Text('Sign out'),
                  onTap: () async {
                    await notifier.signOut();
                    if (!mounted) return;
                    showCustomSnackBar(
                      context,
                      'User signed out',
                    );
                  },
                ),
              ];
            },
            icon: const Icon(
              Icons.more_horiz,
              color: AppColors.primary,
            ),
          ),
          IconButton(
            onPressed: () async {
              await _buildCreateRoomDialog();
            },
            icon: const Icon(
              Icons.add,
              color: AppColors.primary,
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
        error: (e, __) => ErrorLoadingWidget(
          errorMessage: e.toString(),
        ),
        loading: () => const LoadingWidget(),
      ),
    );
  }

  _buildCreateRoomDialog() {
    return showDialog(
      context: context,
      builder: (context) {
        String text = '';
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text('Create room'),
          content: TextField(
            decoration: const InputDecoration(
              hintText: "Room's name",
            ),
            onChanged: (value) {
              text = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                ref.read(chatsRepositoryProvider).createRoom(text);
                context.pop();
              },
              child: const Text('Confirmar'),
            ),
            TextButton(
              onPressed: () {
                context.pop();
              },
              child: const Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }
}
