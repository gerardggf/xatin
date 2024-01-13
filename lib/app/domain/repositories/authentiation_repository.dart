import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xatin/app/core/providers.dart';
import 'package:xatin/app/data/repositories_impl/authentication_repository_impl.dart';

import '../../core/either/either.dart';

final authenticationRepositoryProvider = Provider<AuthenticationRepository>(
  (ref) => AuthenticationRepositoryImpl(
    ref.watch(firebaseAuthProvider),
  ),
);

abstract class AuthenticationRepository {
  User? get user;
  Stream<User?> get authStateChanges;
  Future<Either<FirebaseException, User?>> signIn(
      String email, String password);
  Future<Either<FirebaseException, User?>> register(
      String email, String password);
  Future<Either<FirebaseException, bool>> changePassword(String email);
  Future<void> signOut();
}
