import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:xatin/app/domain/repositories/connectivity_repository.dart';
import 'package:xatin/app/presentation/modules/auth/auth_view.dart';
import 'package:xatin/app/presentation/modules/auth/change_password/change_password_view.dart';
import 'package:xatin/app/presentation/modules/auth/sign_in/sign_in_view.dart';
import 'package:xatin/app/presentation/modules/room/room_view.dart';
import 'package:xatin/app/xatin_app.dart';
import '../modules/auth/register/register_view.dart';
import '../modules/home/home_view.dart';
import '../modules/offline/offline_view.dart';
import 'routes.dart';

Future<String> getInitialRouteName(BuildContext context, WidgetRef ref) async {
  final connectivityRepository = ref.read(connectivityRepositoryProvider);

  await connectivityRepository.initialize();
  final hasInternet = connectivityRepository.hasInternet;

  if (!hasInternet) {
    return Routes.offline;
  }
  return Routes.auth;
}

mixin RouterMixin on ConsumerState<XatinApp> {
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
        name: Routes.room,
        path: '/room/:roomId',
        builder: (_, state) {
          final roomId = state.pathParameters['roomId'] ?? '';
          return RoomView(roomId: roomId);
        },
      ),
      GoRoute(
        name: Routes.offline,
        path: '/offline',
        builder: (_, __) => const OfflineView(),
      ),
      GoRoute(
        name: Routes.signIn,
        path: '/sign-in',
        builder: (_, __) => const SignInView(),
      ),
      GoRoute(
        name: Routes.register,
        path: '/register',
        builder: (_, __) => const RegisterView(),
      ),
      GoRoute(
        name: Routes.changePassword,
        path: '/change-password',
        builder: (_, __) => const ChangePasswordView(),
      ),
      GoRoute(
        name: Routes.auth,
        path: '/auth',
        builder: (_, __) => const AuthView(),
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
    _initialRouteName = await getInitialRouteName(context, ref);
    setState(() {
      _loading = false;
    });
  }
}
