import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:get/get.dart';
import '../../../core/Theme/app_theme.dart';

// Controller
class AcceptOrdersController extends GetxController {
  final orders = <Map<String, dynamic>>[
    {
      'orderNo': 1,
      'tableNo': 7,
      'time': '10:30 AM',
      'items': [
        {'name': 'Chicken Biryani', 'quantity': 2},
        {'name': 'Paneer Tikka', 'quantity': 1},
        {'name': 'Garlic Naan', 'quantity': 3},
      ],
      'specialInstructions': 'Less spicy please',
    },
    {
      'orderNo': 2,
      'tableNo': 12,
      'time': '10:35 AM',
      'items': [
        {'name': 'Margherita Pizza', 'quantity': 1},
        {'name': 'Caesar Salad', 'quantity': 2},
      ],
      'specialInstructions': null,
    },
    {
      'orderNo': 3,
      'tableNo': 5,
      'time': '10:40 AM',
      'items': [
        {'name': 'Grilled Salmon', 'quantity': 1},
        {'name': 'French Fries', 'quantity': 2},
        {'name': 'Lemonade', 'quantity': 2},
      ],
      'specialInstructions': 'No onions',
    },
  ].obs;

  final isLoading = false.obs;

  void acceptOrder(int orderNo) {
    isLoading.value = true;
    // Add your API call here
    Future.delayed(const Duration(milliseconds: 800), () {
      orders.removeWhere((order) => order['orderNo'] == orderNo);
      isLoading.value = false;
      Get.snackbar(
        'Success',
        'Order #$orderNo accepted successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppTheme.success,
        colorText: Colors.white,
        margin: EdgeInsets.all(AppTheme.space16),
        borderRadius: AppTheme.radiusMedium,
        duration: const Duration(seconds: 2),
      );
    });
  }

  void rejectOrder(int orderNo, String reason) {
    if (reason.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Please provide a reason for rejection',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppTheme.error,
        colorText: Colors.white,
        margin: EdgeInsets.all(AppTheme.space16),
        borderRadius: AppTheme.radiusMedium,
      );
      return;
    }

    isLoading.value = true;
    // Add your API call here with reason
    Future.delayed(const Duration(milliseconds: 800), () {
      orders.removeWhere((order) => order['orderNo'] == orderNo);
      isLoading.value = false;
      Get.back(); // Close dialog
      Get.snackbar(
        'Order Rejected',
        'Order #$orderNo has been rejected',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppTheme.error,
        colorText: Colors.white,
        margin: EdgeInsets.all(AppTheme.space16),
        borderRadius: AppTheme.radiusMedium,
        duration: const Duration(seconds: 2),
      );
    });
  }

  void showRejectDialog(int orderNo, BuildContext context) {
    final TextEditingController reasonController = TextEditingController();
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
          ),
          backgroundColor: theme.colorScheme.surface,
          contentPadding: EdgeInsets.zero,
          content: Container(
            width: MediaQuery.of(context).size.width * 0.85,
            padding: EdgeInsets.all(AppTheme.space24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Warning Icon
                Container(
                  width: 60.w,
                  height: 60.h,
                  decoration: BoxDecoration(
                    color: AppTheme.error.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    PhosphorIcons.warning(),
                    color: AppTheme.error,
                    size: 32.sp,
                  ),
                ),
                SizedBox(height: AppTheme.space16),

                // Title
                Text(
                  'Reject Order #$orderNo',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                SizedBox(height: AppTheme.space8),

                // Subtitle
                Text(
                  'Please provide a reason for rejecting this order',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: isDark
                        ? AppTheme.darkTextSecondary
                        : AppTheme.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: AppTheme.space20),

                // Text Field
                TextField(
                  controller: reasonController,
                  maxLines: 4,
                  style: theme.textTheme.bodyMedium,
                  decoration: InputDecoration(
                    hintText: 'Enter reason for cancellation...',
                    hintStyle: theme.inputDecorationTheme.hintStyle,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                      borderSide: BorderSide(
                        color: theme.colorScheme.primary,
                        width: 2.w,
                      ),
                    ),
                    contentPadding: EdgeInsets.all(AppTheme.space16),
                    filled: true,
                    fillColor: isDark
                        ? AppTheme.darkSurfaceVariant
                        : AppTheme.surfaceVariant,
                  ),
                ),
                SizedBox(height: AppTheme.space20),

                // Buttons
                Row(
                  children: [
                    // Cancel Button
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.of(dialogContext).pop(),
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppTheme.space20,
                            vertical: AppTheme.space12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                          ),
                          side: BorderSide(
                            color: theme.colorScheme.outline,
                            width: 1.5.w,
                          ),
                          foregroundColor: theme.colorScheme.onSurface,
                        ),
                        child: Text(
                          'Cancel',
                          style: theme.textTheme.labelLarge,
                        ),
                      ),
                    ),
                    SizedBox(width: AppTheme.space12),

                    // Reject Button
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(dialogContext).pop();
                          rejectOrder(orderNo, reasonController.text);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.error,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                            horizontal: AppTheme.space20,
                            vertical: AppTheme.space12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'Reject',
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }


}