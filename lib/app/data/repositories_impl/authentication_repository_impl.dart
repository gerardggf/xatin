import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:xatin/app/core/either/either.dart';
import 'package:xatin/app/domain/models/user_model.dart';
import 'package:xatin/app/domain/repositories/account_repository.dart';

import '../../domain/repositories/authentiation_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  AuthenticationRepositoryImpl(
    this.auth,
    this.accountRepository,
  );

  final FirebaseAuth auth;
  final AccountRepository accountRepository;

  @override
  User? get firebaseUser => auth.currentUser;

  @override
  UserModel? get user => accountRepository.user;

  @override
  Stream<User?> get authStateChanges => auth.authStateChanges();

  @override
  Future<Either<FirebaseException, UserModel?>> signIn(
      String email, String password) async {
    try {
      final credentials = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final result = await accountRepository.getUser(credentials.user);
      return result.when(
        left: (failure) {
          return Either.left(failure);
        },
        right: (user) {
          return Either.right(user);
        },
      );
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print(e.code);
      }
      return Either.left(e);
    }
  }

  @override
  Future<Either<FirebaseException, UserModel?>> register(
      String email, String password) async {
    try {
      final credentials = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credentials.user == null) return Either.right(null);
      final result = await accountRepository.createUser(credentials.user!);
      return result.when(
        left: (failure) {
          return Either.left(failure);
        },
        right: (user) {
          return Either.right(user);
        },
      );
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

  @override
  Future<void> signOut() async {
    accountRepository.setUser(null);
    return await auth.signOut();
  }
}
