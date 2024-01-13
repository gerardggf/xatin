import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xatin/app/domain/repositories/account_repository.dart';

final roomControllerProvider = StateNotifierProvider<RoomController, String>(
  (ref) => RoomController(
    '',
    ref.watch(accountRepositoryProvider),
  ),
);

class RoomController extends StateNotifier<String> {
  RoomController(
    super.state,
    this.accountRepository,
  );

  final AccountRepository accountRepository;
}
