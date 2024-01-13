import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:xatin/app/core/either/either.dart';

import '../../domain/repositories/authentiation_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  AuthenticationRepositoryImpl(this.auth);

  final FirebaseAuth auth;

  @override
  User? get user => auth.currentUser;

  @override
  Stream<User?> get authStateChanges => auth.authStateChanges();

  @override
  Future<Either<FirebaseException, User?>> signIn(
      String email, String password) async {
    try {
      final credentials = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Either.right(credentials.user);
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print(e.code);
      }
      return Either.left(e);
    }
  }

  @override
  Future<Either<FirebaseException, User?>> register(
      String email, String password) async {
    try {
      final credentials = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      changeDisplayName(email.split('@').first);
      return Either.right(credentials.user);
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print(e.code);
      }
      return Either.left(e);
    }
  }

  @override
  Future<Either<FirebaseException, bool>> changePassword(String email) async {
    try {
      await auth.sendPasswordResetEmail(
        email: email,
      );
      return Either.right(true);
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print(e.code);
      }
      return Either.left(e);
    }
  }

  Future<void> changeDisplayName(String displayName) async {
    if (auth.currentUser == null) return;
    await auth.currentUser!.updateDisplayName(displayName);
  }

  @override
  Future<void> signOut() async {
    return await auth.signOut();
  }
}
