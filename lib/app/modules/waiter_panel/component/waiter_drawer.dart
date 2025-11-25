import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../core/Theme/app_theme.dart';
import '../../../core/services/theme_service.dart';
import '../../../route/app_routes.dart';

class WaiterDrawer extends StatelessWidget {
  const WaiterDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final ThemeController themeController = Get.find<ThemeController>();


    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppTheme.primary, AppTheme.primaryDark],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40.r,
                    backgroundColor: Colors.white,
                    child: Icon(
                      PhosphorIcons.chefHat(PhosphorIconsStyle.fill),
                      size: 40.sp,
                      color: AppTheme.primary,
                    ),
                  ),
                  SizedBox(height: AppTheme.space12),
                  Text(
                    'Waiter Panel',
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(
                PhosphorIcons.house(),
                color: colorScheme.onSurface,
              ),
              title: Text('Dashboard'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                PhosphorIcons.user(),
                color: colorScheme.onSurface,
              ),
              title: Text('Profile'),
              onTap: () {
                Navigator.pop(context);
                // Navigate to profile
              },
            ),
            ListTile(
              leading: Icon(
                PhosphorIcons.gear(),
                color: colorScheme.onSurface,
              ),
              title: Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                // Navigate to settings
              },
            ),

            Obx(() => ListTile(
              leading: Icon(
                themeController.isDarkMode
                    ? PhosphorIcons.sun()
                    : PhosphorIcons.moon(),
                color: colorScheme.onSurface,
              ),
              title: Text(themeController.isDarkMode ? 'Light Mode' : 'Dark Mode'),
              trailing: Switch(
                value: themeController.isDarkMode,
                onChanged: (value) => themeController.toggleTheme(),
                activeColor: AppTheme.primary,
              ),
              onTap: () => themeController.toggleTheme(),
            )),
            Spacer(),
            Divider(),
            ListTile(
              leading: Icon(
                PhosphorIcons.signOut(),
                color: Colors.red,
              ),
              title: Text(
                'Logout',
                style: TextStyle(color: Colors.red),
              ),
              onTap: () {
                _showLogoutDialog(context);
              },
            ),
            SizedBox(height: AppTheme.space16),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop(); // Close drawer
                // Implement your logout logic here
                // Example: Get.offAllNamed('/login');
                NavigationService.goToLogin();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: Text('Logout'),
            ),
          ],
        );
      },
    );
  }
}