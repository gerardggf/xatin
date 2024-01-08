import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xatin/app/core/providers.dart';
import 'package:xatin/app/data/repositories_impl/connectivity_repository_impl.dart';
import 'package:xatin/app/data/services/remote/internet_checker.dart';

final connectivityRepositoryProvider = Provider<ConnectivityRepository>(
  (ref) => ConnectivityRepositoryImpl(
    ref.read(connectivityProvider),
    ref.read(internetCheckerProvider),
  ),
);

abstract class ConnectivityRepository {
  Future<void> initialize();
  bool get hasInternet;
  Stream<bool> get onInternetChanged;
}
