import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xatin/app/domain/repositories/authentiation_repository.dart';

import '../../../../core/either/either.dart';
import 'state/change_password_state.dart';

final changePasswordControllerProvider =
    StateNotifierProvider<ChangePasswordController, ChangePasswordState>(
  (ref) => ChangePasswordController(
    ChangePasswordState(),
    ref.watch(authenticationRepositoryProvider),
  ),
);

class ChangePasswordController extends StateNotifier<ChangePasswordState> {
  ChangePasswordController(
    super.state,
    this.authenticationRepository,
  );

  final AuthenticationRepository authenticationRepository;

  void updateFetching(bool value) {
    state = state.copyWith(fetching: value);
  }

  void updateEmail(String value) {
    state = state.copyWith(email: value);
  }

  Future<Either<FirebaseException, bool>> submit() async {
    updateFetching(true);
    final result = await authenticationRepository.changePassword(
      state.email,
    );
    updateFetching(false);
    return result;
  }
}
