import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:xatin/app/xatin_app.dart';
import '../modules/home/home_view.dart';
import '../modules/offline/offline_view.dart';
import 'routes.dart';

Future<String> getInitialRouteName(BuildContext context) async {
  //TODO: adapt to my architecture
  return Routes.home;
  // final SessionController sessionController = context.read();
  // final FavoritesController favoritesController = context.read();

  // final hasInternet = Repositories.connectivity.hasInternet;

  // if (!hasInternet) {
  //   return Routes.offline;
  // }

  // final isSignedIn = await Repositories.authentication.isSignedIn;

  // if (!isSignedIn) {
  //   return Routes.signIn;
  // }

  // final user = await Repositories.account.getUserData();

  // if (user != null) {
  //   sessionController.setUser(user);
  //   favoritesController.init();
  //   return Routes.home;
  // }

  // return Routes.signIn;
}

mixin RouterMixin on State<XatinApp> {
  GoRouter? _router;
  late String _initialRouteName;

  bool _loading = true;
  bool get loading => _loading;

  GoRouter get router {
    if (_router != null) {
      return _router!;
    }

    final routes = [
      GoRoute(
        name: Routes.home,
        path: '/',
        builder: (_, __) => const HomeView(),
      ),
      GoRoute(
        name: Routes.offline,
        path: '/offline',
        builder: (_, __) => const OfflineView(),
      ),
    ];

    final overrideRoutes = widget.overrideRoutes;
    if (overrideRoutes?.isNotEmpty ?? false) {
      final names = overrideRoutes!.map(
        (e) => e.name,
      );
      routes.removeWhere(
        (element) {
          final name = element.name;
          if (name != null) {
            return names.contains(name);
          }
          return false;
        },
      );
      routes.addAll(overrideRoutes);
    }

    final initialLocation = routes
        .firstWhere(
          (element) => element.name == _initialRouteName,
          orElse: () => routes.first,
        )
        .path;

    _router = GoRouter(
      initialLocation: initialLocation,
      routes: routes,
    );
    return _router!;
  }

  @override
  void initState() {
    super.initState();
    if (widget.initialRoute != null) {
      _initialRouteName = widget.initialRoute!;
      _loading = false;
    } else {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => _init(),
      );
    }
  }

  Future<void> _init() async {
    _initialRouteName = await getInitialRouteName(context);
    setState(() {
      _loading = false;
    });
  }
}
