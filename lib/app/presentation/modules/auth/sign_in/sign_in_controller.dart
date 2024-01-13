import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xatin/app/domain/models/user_model.dart';
import 'package:xatin/app/domain/repositories/authentiation_repository.dart';

import '../../../../core/either/either.dart';
import 'state/sign_in_state.dart';

final signInControllerProvider =
    StateNotifierProvider<SignInController, SignInState>(
  (ref) => SignInController(
    SignInState(),
    ref.watch(authenticationRepositoryProvider),
  ),
);

class SignInController extends StateNotifier<SignInState> {
  SignInController(
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

  void updatePassword(String value) {
    state = state.copyWith(password: value);
  }

  Future<Either<FirebaseException, UserModel?>> submit() async {
    updateFetching(true);
    final result = await authenticationRepository.signIn(
      state.email,
      state.password,
    );
    updateFetching(false);
    return result;
  }
}
