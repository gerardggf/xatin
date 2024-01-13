import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:xatin/app/presentation/global/mixins/num_sizedbox_extension.dart';
import 'package:xatin/app/presentation/global/utils/map_firebase_codes.dart';
import 'package:xatin/app/presentation/global/utils/show_custom_snack_bar.dart';
import 'package:xatin/app/presentation/global/widgets/custom_button.dart';
import 'package:xatin/app/presentation/modules/auth/sign_in/sign_in_controller.dart';

import '../../../../core/const/colors.dart';
import '../../../routes/routes.dart';

class SignInView extends ConsumerStatefulWidget {
  const SignInView({super.key});

  @override
  ConsumerState<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends ConsumerState<SignInView> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(signInControllerProvider);
    final notifier = ref.read(signInControllerProvider.notifier);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'xatin',
          style: TextStyle(
            color: AppColors.primary,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Text(
                'Sign in',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.secondary,
                ),
                textAlign: TextAlign.center,
              ),
              20.h,
              TextFormField(
                onChanged: (value) {
                  notifier.updateEmail(value);
                },
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              10.h,
              TextFormField(
                onChanged: (value) {
                  notifier.updatePassword(value);
                },
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              30.h,
              CustomButton(
                fetching: state.fetching,
                onPressed: () async {
                  final result = await notifier.submit();
                  result.when(
                    left: (error) {
                      showCustomSnackBar(
                        context,
                        mapFirebaseCode(error.code),
                        color: Colors.red,
                      );
                    },
                    right: (data) {
                      showCustomSnackBar(
                        context,
                        'User logged in',
                      );
                    },
                  );
                },
                child: const Text('Sign in'),
              ),
              10.h,
              TextButton(
                onPressed: () {
                  context.pushNamed(Routes.changePassword);
                },
                child: const Text(
                  'Forgot password',
                  style: TextStyle(
                    color: AppColors.secondary,
                    fontSize: 12,
                  ),
                ),
              ),
              10.h,
              TextButton(
                onPressed: () {
                  context.pushReplacementNamed(Routes.register);
                },
                child: const Text(
                  'Register',
                  style: TextStyle(
                    color: AppColors.secondary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
