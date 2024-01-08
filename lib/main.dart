import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xatin/app/xatin_app.dart';
import 'app/core/generated/translations.g.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  LocaleSettings.useDeviceLocale();

  runApp(
    const Root(),
  );
}

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: const [],
      child: TranslationProvider(
        child: const XatinApp(),
      ),
    );
  }
}
