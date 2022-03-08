import 'package:go_router/go_router.dart';

import '../screens/init_page.dart';
import '../screens/login_page.dart';

class MyRouter {
  GoRouter get value => _goRouter;

  final _goRouter = GoRouter(routes: [
    GoRoute(path: '/', builder: (context, state) => const LoginPage()),
    GoRoute(path: '/init', builder: (context, state) => const InitPage()),
    /*GoRoute(
        path: '/google_login',
        builder: (context, state) => const GoogleLoginPage()),*/
  ]);
}
