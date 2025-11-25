import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../apputils/Utils/common_utils.dart';
import '../../core/Theme/app_theme.dart';
import '../../core/services/theme_service.dart';
import 'login_view_controller.dart';

class LoginPage extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());
  final ThemeController themeController = Get.put(ThemeController());


  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          color: colors.surface,
          child: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(AppTheme.space24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /// ---------- THEME TOGGLE ----------
                    Align(
                      alignment: Alignment.topRight,
                      child: Obx(() => IconButton(
                        icon: Icon(
                          themeController.isDarkMode
                              ? Icons.light_mode
                              : Icons.dark_mode,
                          color: colors.onBackground,
                          size: 28.sp,
                        ),
                        onPressed: themeController.toggleTheme,
                      )),
                    ),

                    SizedBox(height: AppTheme.space12),

                    /// ---------- TITLE WITH GRADIENT ----------
                    ShaderMask(
                      shaderCallback: (bounds) => LinearGradient(
                        colors: [
                          colors.primary,
                          colors.secondary,
                        ],
                      ).createShader(bounds),
                      child: Text(
                        "The Waiter",
                        style: textTheme.displayMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),

                    SizedBox(height: 8.h),

                    /// ---------- SUBTITLE WITH ICON ----------
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        PhosphorIcon(
                          PhosphorIconsLight.sparkle,
                          size: 10.sp,
                          color: colors.primary,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          "Your Digital Restaurant Assistant",
                          style: textTheme.bodySmall?.copyWith(
                            fontStyle: FontStyle.italic,
                            color: colors.onSurfaceVariant,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        PhosphorIcon(
                          PhosphorIconsLight.sparkle,
                          size: 16.sp,
                          color: colors.primary,
                        ),
                      ],
                    ),

                    SizedBox(height: AppTheme.space32),

                    /// ---------- LOGIN CARD ----------
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(AppTheme.space24),
                      decoration: BoxDecoration(
                        color: colors.surface,
                        borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                        boxShadow: theme.brightness == Brightness.dark
                            ? AppTheme.darkShadowLarge
                            : AppTheme.shadowLarge,
                        border: Border.all(
                          color: colors.outline,
                          width: 1.w,
                        ),
                      ),
                      child: Column(
                        children: [
                          /// ---------- WELCOME HEADER ----------
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              PhosphorIcon(
                                PhosphorIconsFill.handWaving,
                                size: 24.sp,
                                color: colors.primary,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                "Welcome Back!",
                                style: textTheme.headlineMedium?.copyWith(
                                  color: colors.onSurface,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 6.h),

                          Text(
                            "Sign in to continue your service",
                            style: textTheme.bodyMedium?.copyWith(
                              color: colors.onSurfaceVariant,
                            ),
                          ),

                          SizedBox(height: AppTheme.space32),

                          /// ---------- EMAIL FIELD ----------
                          CommonUiUtils.buildTextFormField(
                            controller: controller.emailController,
                            label: "Email",
                            hint: "Enter your email",
                            icon: Icons.email_outlined,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Email is required";
                              }
                              return null;
                            },
                            context: context,
                          ),

                          SizedBox(height: AppTheme.space20),

                          /// ---------- PASSWORD FIELD ----------
                          Obx(() => CommonUiUtils.buildTextFormField(
                            controller: controller.passwordController,
                            label: "Password",
                            hint: "Enter your password",
                            icon: Icons.lock_outline,
                            obscureText: !controller.isPasswordVisible.value,
                            suffixIcon: IconButton(
                              icon: PhosphorIcon(
                                controller.isPasswordVisible.value
                                    ? PhosphorIconsLight.eyeSlash
                                    : PhosphorIconsLight.eye,
                                size: 18.sp,
                                color: colors.onBackground,
                              ),
                              onPressed: controller.togglePasswordVisibility,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Password is required";
                              }
                              return null;
                            },
                            context: context,
                          )),

                          SizedBox(height: AppTheme.space12),

                          /// ---------- FORGOT PASSWORD ----------
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                "Forgot Password?",
                                style: textTheme.bodyMedium?.copyWith(
                                  color: colors.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: AppTheme.space20),

                          /// ---------- LOGIN BUTTON ----------
                          Obx(() => controller.isLoading.value
                              ? const CircularProgressIndicator()
                              : SizedBox(
                            width: double.infinity,
                            height: 50.h,
                            child: ElevatedButton(
                              onPressed: () => controller.login(context),
                              child: Text(
                                "Login",
                                style: textTheme.titleMedium?.copyWith(
                                  color: colors.onPrimary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )),

                          SizedBox(height: AppTheme.space20),

                          /// ---------- DIVIDER ----------
                          Row(
                            children: [
                              Expanded(child: Divider(color: colors.outline)),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12.w),
                                child: Text(
                                  "OR",
                                  style: textTheme.bodySmall?.copyWith(
                                    color: colors.onSurfaceVariant,
                                  ),
                                ),
                              ),
                              Expanded(child: Divider(color: colors.outline)),
                            ],
                          ),

                          SizedBox(height: AppTheme.space20),

                          /// ---------- SIGN UP ----------
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account? ",
                                style: textTheme.bodyMedium?.copyWith(
                                  color: colors.onSurfaceVariant,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Text(
                                  "Sign Up",
                                  style: textTheme.bodyMedium?.copyWith(
                                    color: colors.primary,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: AppTheme.space24),

                    /// ---------- FOOTER ----------
                    Text(
                      "© 2024 The Waiter. All rights reserved.",
                      style: textTheme.bodySmall?.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}