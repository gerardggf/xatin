import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:xatin/app/presentation/routes/router.dart';
import 'core/generated/translations.g.dart';
import 'presentation/splash_view.dart';

class XatinApp extends ConsumerStatefulWidget {
  const XatinApp({
    super.key,
    this.initialRoute,
    this.overrideRoutes,
  });

  final String? initialRoute;
  final List<GoRoute>? overrideRoutes;

  @override
  ConsumerState<XatinApp> createState() => _XatinAppState();
}

class _XatinAppState extends ConsumerState<XatinApp>
    with RouterMixin, WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeLocales(List<Locale>? locales) {
    //TODO: adapt to my architecture
    // if (locales?.isNotEmpty ?? false) {
    //   final locale = locales!.first;
    //   Repositories.language.setLanguageCode(
    //     locale.languageCode,
    //   );
    //   Intl.defaultLocale = locale.toLanguageTag();
    //   LocaleSettings.setLocaleRaw(
    //     locale.languageCode,
    //   );
    // }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const SplashView();
    }
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MaterialApp.router(
        routerConfig: router,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: AppLocaleUtils.supportedLocales,
        locale: TranslationProvider.of(context).flutterLocale,
      ),
    );
  }
}
