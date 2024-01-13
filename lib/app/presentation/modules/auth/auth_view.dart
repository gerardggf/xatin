import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xatin/app/domain/repositories/authentiation_repository.dart';
import 'package:xatin/app/presentation/global/widgets/error_loading_widget.dart';
import 'package:xatin/app/presentation/modules/auth/sign_in/sign_in_view.dart';
import 'package:xatin/app/presentation/modules/home/home_view.dart';

import '../../global/widgets/loading_widget.dart';

final authStateChangesStreamProvider = StreamProvider<User?>(
  (ref) => ref.watch(authenticationRepositoryProvider).authStateChanges,
);

class AuthView extends ConsumerWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authStateChangesStream = ref.watch(authStateChangesStreamProvider);
    return authStateChangesStream.when(
      data: (user) {
        if (user == null) {
          return const SignInView();
        }
        return const HomeView();
      },
      error: (e, __) => ErrorLoadingWidget(
        errorMessage: e.toString(),
      ),
      loading: () => const LoadingWidget(),
    );
  }
}
