import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../core/utils/snakbar.dart';
import '../../route/app_routes.dart';

enum UserRole { waiter, chef }

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var isLoading = false.obs;
  var isPasswordVisible = false.obs;

  // Dummy credentials
  final Map<String, Map<String, dynamic>> _credentials = {
    'waiter@thewaiter.com': {
      'password': 'waiter123',
      'role': UserRole.waiter,
      'name': 'John Waiter'
    },
    'chef@thewaiter.com': {
      'password': 'chef123',
      'role': UserRole.chef,
      'name': 'Chef Gordon'
    },
  };

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void login(BuildContext context) {
    String email = emailController.text.trim();
    String pass = passwordController.text.trim();

    // Validation
    if (email.isEmpty || pass.isEmpty) {
      CustomSnackBar.showError(
        context,
        message: "Email & Password required",
      );
      return;
    }

    if (!GetUtils.isEmail(email)) {
      CustomSnackBar.showError(
        context,
        message: "Please enter a valid email",
      );
      return;
    }

    isLoading.value = true;

    // Simulate API call delay
    Future.delayed(Duration(seconds: 2), () {
      isLoading.value = false;

      // Check credentials
      if (_credentials.containsKey(email)) {
        final userCreds = _credentials[email]!;

        if (userCreds['password'] == pass) {
          // Successful login
          final UserRole role = userCreds['role'];
          final String name = userCreds['name'];

          CustomSnackBar.showSuccess(
            context,
            message: "Welcome back, $name!",
          );

          // Navigate based on role
          _navigateByRole(role);
        } else {
          // Wrong password
          CustomSnackBar.showError(
            context,
            message: "Invalid password. Please try again.",
          );
        }
      } else {
        // Email not found
        CustomSnackBar.showError(
          context,
          message: "Account not found. Please check your email.",
        );
      }
    });
  }

  void _navigateByRole(UserRole role) {
    switch (role) {
      case UserRole.waiter:
        NavigationService.goToWaiterDashboard();
        break;
      case UserRole.chef:
        NavigationService.goToChefDashboard();
        break;
    }
  }


  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}