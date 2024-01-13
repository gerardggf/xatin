import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xatin/app/core/providers.dart';
import 'package:xatin/app/data/repositories_impl/authentication_repository_impl.dart';
import 'package:xatin/app/domain/models/user_model.dart';
import 'package:xatin/app/domain/repositories/account_repository.dart';

import '../../core/either/either.dart';

final authenticationRepositoryProvider = Provider<AuthenticationRepository>(
  (ref) => AuthenticationRepositoryImpl(
    ref.watch(firebaseAuthProvider),
    ref.watch(accountRepositoryProvider),
  ),
);

abstract class AuthenticationRepository {
  User? get firebaseUser;
  UserModel? get user;
  Stream<User?> get authStateChanges;
  Future<Either<FirebaseException, UserModel?>> signIn(
      String email, String password);
  Future<Either<FirebaseException, UserModel?>> register(
      String email, String password);
  Future<Either<FirebaseException, bool>> changePassword(String email);
  Future<void> signOut();
}
