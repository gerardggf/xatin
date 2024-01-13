import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:xatin/app/core/const/firestore_collections.dart';
import 'package:xatin/app/core/either/either.dart';
import 'package:xatin/app/domain/models/user_model.dart';

import '../../domain/repositories/account_repository.dart';

class AccountRepositoryImpl implements AccountRepository {
  AccountRepositoryImpl(this.firestore);

  final FirebaseFirestore firestore;

  @override
  UserModel? get user => _user;

  UserModel? _user;

  @override
  Future<Either<FirebaseException, UserModel>> createUser(User user) async {
    try {
      final currentUser = UserModel(
        id: user.uid,
        creationDate: DateTime.now().toIso8601String(),
        username: user.email?.split('@').first ?? '',
        email: user.email ?? '',
        fcmToken: '',
        photoUrl: '',
      );
      firestore.collection(FirestoreCollections.users).doc(user.uid).set(
            currentUser.toJson(),
          );
      setUser(currentUser);
      return Either.right(currentUser);
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print(e.code);
      }
      return Either.left(e);
    }
  }

  @override
  Future<Either<FirebaseException, UserModel?>> getUser(User? user) async {
    try {
      final result = await firestore
          .collection(FirestoreCollections.users)
          .doc(user!.uid)
          .get();
      if (result.data() == null) return Either.right(null);
      final currentUser = UserModel.fromJson(
        result.data()!,
      );
      setUser(currentUser);
      return Either.right(currentUser);
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print(e.code);
      }
      return Either.left(e);
    }
  }

  @override
  void setUser(UserModel? user) {
    _user = user;
  }

  @override
  Future<Map<String, String?>> getUsername(List<String> userIds) async {
    try {
      final usernames = <String, String?>{};
      for (String userId in userIds) {
        final result = await firestore
            .collection(FirestoreCollections.users)
            .doc(userId)
            .get();
        usernames.addAll(
          {
            userId: result["username"],
          },
        );
      }

      return usernames;
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print(e.code);
      }
      return {};
    }
  }
}
