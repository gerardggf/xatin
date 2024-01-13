import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xatin/app/presentation/global/mixins/num_sizedbox_extension.dart';
import 'package:xatin/app/presentation/modules/auth/change_password/change_password_controller.dart';

import '../../../../core/const/colors.dart';
import '../../../global/utils/map_firebase_codes.dart';
import '../../../global/utils/show_custom_snack_bar.dart';
import '../../../global/widgets/custom_button.dart';

class ChangePasswordView extends ConsumerStatefulWidget {
  const ChangePasswordView({super.key});

  @override
  ConsumerState<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends ConsumerState<ChangePasswordView> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(changePasswordControllerProvider);
    final notifier = ref.read(changePasswordControllerProvider.notifier);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const BackButton(color: AppColors.primary),
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
                'Change password',
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
                          context, 'Password recovery mail sent');
                    },
                  );
                },
                child: const Text('Change password'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
