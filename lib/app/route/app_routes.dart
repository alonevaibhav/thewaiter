import 'package:go_router/go_router.dart';
import '../modules/auth/login_view.dart';
import '../modules/chef_panel/chef_panel.dart';
import '../modules/splash/splash_screen.dart';
import '../modules/waiter_panel/waiter_panel.dart';
import 'app_bindings.dart';

class AppRoutes {
  // Route names
  static const splash = '/';
  static const login = '/login';
  static const waiterDashboard = '/waiter-dashboard';
  static const chefDashboard = '/chef-dashboard';

  // Initialize bindings once at app start
  static void initializeBindings() {
    AppBindings().dependencies();
  }

  // Go Router configuration
  static final GoRouter router = GoRouter(
    initialLocation: splash,
    routes: [
      // Splash Screen
      GoRoute(
        path: splash,
        builder: (context, state) => const SplashScreen(),
      ),

      // Login Screen
      GoRoute(
        path: login,
        builder: (context, state) => LoginPage(),
      ),

      // Waiter Dashboard
      GoRoute(
        path: waiterDashboard,
        builder: (context, state) =>  WaiterPanel(),
      ),

      // Chef Dashboard
      GoRoute(
        path: chefDashboard,
        builder: (context, state) =>  ChefPanel(),
      ),
    ],
  );
}

// Navigation Service
class NavigationService {
  static final GoRouter _router = AppRoutes.router;

  static void goToSplash() => _router.go(AppRoutes.splash);
  static void goToLogin() => _router.go(AppRoutes.login);
  static void goToWaiterDashboard() => _router.go(AppRoutes.waiterDashboard);
  static void goToChefDashboard() => _router.go(AppRoutes.chefDashboard);

  static bool canGoBack() => _router.canPop();

  static void goBack() {
    if (_router.canPop()) {
      _router.pop();
    }
  }
}