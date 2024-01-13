import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:xatin/app/presentation/global/mixins/num_sizedbox_extension.dart';
import 'package:xatin/app/presentation/global/utils/map_firebase_codes.dart';
import 'package:xatin/app/presentation/modules/auth/register/register_controller.dart';
import 'package:xatin/app/presentation/routes/routes.dart';

import '../../../../core/const/colors.dart';
import '../../../global/utils/show_custom_snack_bar.dart';
import '../../../global/widgets/custom_button.dart';

class RegisterView extends ConsumerStatefulWidget {
  const RegisterView({super.key});

  @override
  ConsumerState<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends ConsumerState<RegisterView> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(registerControllerProvider);
    final notifier = ref.read(registerControllerProvider.notifier);
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
                'Register',
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
                      context.pushReplacementNamed(Routes.auth);
                      showCustomSnackBar(
                        context,
                        'User successfully registered',
                      );
                    },
                  );
                },
                child: const Text('Register'),
              ),
              20.h,
              TextButton(
                onPressed: () {
                  context.pushReplacementNamed(Routes.auth);
                },
                child: const Text(
                  'Sign in',
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
