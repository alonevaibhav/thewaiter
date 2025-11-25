import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'dart:async';

import '../../core/constants/assets_constant.dart';
import '../../core/theme/app_theme.dart';
import '../../route/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Navigate after 2.5 seconds
    Timer(const Duration(milliseconds: 2500), () {
      if (mounted) {
        NavigationService.goToLogin();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.background,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [
              AppTheme.darkBackground,
              AppTheme.darkSurface,
              // AppTheme.darkBackground,
            ]
                : [
              AppTheme.background,
              AppTheme.surface,
              AppTheme.background,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Large Lottie Logo
            Lottie.asset(
              AppAssets.splashAnimation,
              width: 800.w,
              height: 300.h,
              fit: BoxFit.contain,
            ),

            SizedBox(height: AppTheme.space24),

            // App Name with Gradient
            ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [
                  AppTheme.primary,
                  AppTheme.secondary,
                ],
              ).createShader(bounds),
              child: Text(
                'THE WAITER',
                style: theme.textTheme.displayLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                  letterSpacing: 4,
                  color: Colors.white,
                ),
              ),
            ),

            SizedBox(height: AppTheme.space12),

            // Tagline
            Text(
              'Your Smart Dining Companion',
              style: theme.textTheme.bodyMedium?.copyWith(
                letterSpacing: 1.5,
                color: isDark
                    ? AppTheme.darkTextSecondary
                    : AppTheme.textSecondary,
              ),
            ),

            SizedBox(height: 100.h),

            // Loading Indicator
            SizedBox(
              width: 24.w,
              height: 24.h,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  isDark
                      ? AppTheme.primaryLight.withOpacity(0.5)
                      : AppTheme.primary.withOpacity(0.5),
                ),
                strokeWidth: 2.5.w,
              ),
            ),
          ],
        ),
      ),
    );
  }
}