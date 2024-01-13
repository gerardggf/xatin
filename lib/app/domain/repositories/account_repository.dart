import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xatin/app/core/providers.dart';
import 'package:xatin/app/domain/models/user_model.dart';

import '../../core/either/either.dart';
import '../../data/repositories_impl/account_repository_impl.dart';

final accountRepositoryProvider = Provider<AccountRepository>(
  (ref) => AccountRepositoryImpl(
    ref.watch(firebaseFirestoreProvider),
  ),
);

abstract class AccountRepository {
  UserModel? get user;
  Future<Either<FirebaseException, UserModel?>> getUser(User? user);
  Future<Map<String, String?>> getUsername(List<String> userIds);
  Future<Either<FirebaseException, UserModel?>> createUser(User user);
  void setUser(UserModel? user);
}
