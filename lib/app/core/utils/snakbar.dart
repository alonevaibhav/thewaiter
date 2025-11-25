import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Theme/app_theme.dart';

enum SnackBarType { success, error, warning, info }

class CustomSnackBar {
  static void show(
      BuildContext context, {
        required String message,
        SnackBarType type = SnackBarType.info,
        Duration duration = const Duration(seconds: 3),
        String? actionLabel,
        VoidCallback? onAction,
      }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Get colors based on type
    Color backgroundColor;
    Color iconColor;
    IconData icon;

    switch (type) {
      case SnackBarType.success:
        backgroundColor = AppTheme.success;
        iconColor = Colors.white;
        icon = Icons.check_circle_rounded;
        break;
      case SnackBarType.error:
        backgroundColor = AppTheme.error;
        iconColor = Colors.white;
        icon = Icons.error_rounded;
        break;
      case SnackBarType.warning:
        backgroundColor = AppTheme.warning;
        iconColor = Colors.white;
        icon = Icons.warning_rounded;
        break;
      case SnackBarType.info:
        backgroundColor = isDark ? AppTheme.primaryLight : AppTheme.primary;
        iconColor = Colors.white;
        icon = Icons.info_rounded;
        break;
    }

    final snackBar = SnackBar(
      content: Row(
        children: [
          Icon(
            icon,
            color: iconColor,
            size: 24.sp,
          ),
          SizedBox(width: AppTheme.space12),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
      ),
      margin: EdgeInsets.all(AppTheme.space16),
      padding: EdgeInsets.symmetric(
        horizontal: AppTheme.space16,
        vertical: AppTheme.space16,
      ),
      duration: duration,
      action: actionLabel != null
          ? SnackBarAction(
        label: actionLabel,
        textColor: Colors.white,
        onPressed: onAction ?? () {},
      )
          : null,
      elevation: 8,
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  // Convenience methods
  static void showSuccess(
      BuildContext context, {
        required String message,
        Duration duration = const Duration(seconds: 3),
      }) {
    show(context, message: message, type: SnackBarType.success, duration: duration);
  }

  static void showError(
      BuildContext context, {
        required String message,
        Duration duration = const Duration(seconds: 3),
      }) {
    show(context, message: message, type: SnackBarType.error, duration: duration);
  }

  static void showWarning(
      BuildContext context, {
        required String message,
        Duration duration = const Duration(seconds: 3),
      }) {
    show(context, message: message, type: SnackBarType.warning, duration: duration);
  }

  static void showInfo(
      BuildContext context, {
        required String message,
        Duration duration = const Duration(seconds: 3),
      }) {
    show(context, message: message, type: SnackBarType.info, duration: duration);
  }
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// 📦 ALTERNATIVE: Custom Widget SnackBar (More Customizable)
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

class ModernSnackBar extends StatelessWidget {
  final String message;
  final SnackBarType type;
  final String? actionLabel;
  final VoidCallback? onAction;

  const ModernSnackBar({
    super.key,
    required this.message,
    this.type = SnackBarType.info,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Color backgroundColor;
    Color iconColor;
    IconData icon;

    switch (type) {
      case SnackBarType.success:
        backgroundColor = AppTheme.success;
        iconColor = Colors.white;
        icon = Icons.check_circle_rounded;
        break;
      case SnackBarType.error:
        backgroundColor = AppTheme.error;
        iconColor = Colors.white;
        icon = Icons.error_rounded;
        break;
      case SnackBarType.warning:
        backgroundColor = AppTheme.warning;
        iconColor = Colors.white;
        icon = Icons.warning_rounded;
        break;
      case SnackBarType.info:
        backgroundColor = isDark ? AppTheme.primaryLight : AppTheme.primary;
        iconColor = Colors.white;
        icon = Icons.info_rounded;
        break;
    }

    return Container(
      margin: EdgeInsets.all(AppTheme.space16),
      padding: EdgeInsets.symmetric(
        horizontal: AppTheme.space16,
        vertical: AppTheme.space16,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
        boxShadow: isDark ? AppTheme.darkShadowLarge : AppTheme.shadowLarge,
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(AppTheme.space8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 24.sp,
            ),
          ),
          SizedBox(width: AppTheme.space16),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white,
                height: 1.4,
              ),
            ),
          ),
          if (actionLabel != null) ...[
            SizedBox(width: AppTheme.space8),
            TextButton(
              onPressed: onAction,
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: AppTheme.space12,
                  vertical: AppTheme.space8,
                ),
                backgroundColor: Colors.white.withOpacity(0.2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
                ),
              ),
              child: Text(
                actionLabel!,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  static void show(
      BuildContext context, {
        required String message,
        SnackBarType type = SnackBarType.info,
        Duration duration = const Duration(seconds: 3),
        String? actionLabel,
        VoidCallback? onAction,
      }) {
    final snackBar = SnackBar(
      content: ModernSnackBar(
        message: message,
        type: type,
        actionLabel: actionLabel,
        onAction: onAction,
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      duration: duration,
      padding: EdgeInsets.zero,
      margin: EdgeInsets.zero,
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// 📝 USAGE EXAMPLES
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

/*

// Simple Usage:
CustomSnackBar.showSuccess(context, message: 'Operation successful!');
CustomSnackBar.showError(context, message: 'Something went wrong');
CustomSnackBar.showWarning(context, message: 'Please check your input');
CustomSnackBar.showInfo(context, message: 'New updates available');

// With Custom Duration:
CustomSnackBar.show(
  context,
  message: 'Custom message',
  type: SnackBarType.success,
  duration: const Duration(seconds: 5),
);

// With Action Button:
CustomSnackBar.show(
  context,
  message: 'File deleted',
  type: SnackBarType.error,
  actionLabel: 'UNDO',
  onAction: () {
    print('Undo action triggered');
  },
);

// Using ModernSnackBar (Alternative):
ModernSnackBar.show(
  context,
  message: 'This is a modern snackbar!',
  type: SnackBarType.success,
  actionLabel: 'VIEW',
  onAction: () {
    print('View action triggered');
  },
);

*/