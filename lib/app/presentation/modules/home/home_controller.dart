import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xatin/app/domain/repositories/authentiation_repository.dart';

import 'state/home_state.dart';

final homeControllerProvider = StateNotifierProvider<HomeController, HomeState>(
  (ref) => HomeController(
    HomeState(),
    ref.watch(authenticationRepositoryProvider),
  ),
);

class HomeController extends StateNotifier<HomeState> {
  HomeController(
    super.state,
    this.authenticationRepository,
  );

  final AuthenticationRepository authenticationRepository;

  void updateFetching(bool value) {
    state = state.copyWith(fetching: value);
  }

  Future<void> signOut() async {
    return await authenticationRepository.signOut();
  }
}
