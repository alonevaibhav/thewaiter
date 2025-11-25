import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'app/core/services/app_initializer.dart';
import 'app/core/services/theme_service.dart';
import 'app/core/theme/app_theme.dart';
import 'app/route/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

// Initialize all services
  await AppInitializer.initialize();

  runApp(const SolarApp());
}

class SolarApp extends StatelessWidget {
  const SolarApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return ValueListenableBuilder<ThemeMode>(
          valueListenable: themeController.themeModeNotifier,
          builder: (context, themeMode, child) {
            return MaterialApp.router(
              title: 'The Waiter ',
              debugShowCheckedModeBanner: false,
              routerConfig: AppRoutes.router,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: themeMode,
            );
          },
        );
      },
    );
  }
}
