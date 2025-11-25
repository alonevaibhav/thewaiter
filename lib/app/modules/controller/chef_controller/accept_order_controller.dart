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

  void showRejectDialog(int orderNo) {
    final TextEditingController reasonController = TextEditingController();

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
        ),
        child: Container(
          padding: EdgeInsets.all(AppTheme.space24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
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
              Text(
                'Reject Order #$orderNo',
                style: Get.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: AppTheme.space8),
              Text(
                'Please provide a reason for rejecting this order',
                style: Get.textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AppTheme.space24),
              TextField(
                controller: reasonController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Enter reason for cancellation...',
                  hintStyle: TextStyle(
                    color: AppTheme.textSecondary.withOpacity(0.6),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                    borderSide: BorderSide(
                      color: Get.theme.colorScheme.outline,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                    borderSide: BorderSide(
                      color: Get.theme.colorScheme.outline.withOpacity(0.5),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                    borderSide: BorderSide(
                      color: AppTheme.primary,
                      width: 2,
                    ),
                  ),
                  contentPadding: EdgeInsets.all(AppTheme.space16),
                ),
              ),
              SizedBox(height: AppTheme.space24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Get.back(),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(AppTheme.radiusMedium),
                        ),
                        side: BorderSide(
                          color: Get.theme.colorScheme.outline,
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: Get.textTheme.labelLarge?.copyWith(
                          color: Get.theme.colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: AppTheme.space12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        rejectOrder(orderNo, reasonController.text);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.error,
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(AppTheme.radiusMedium),
                        ),
                      ),
                      child: Text(
                        'Reject',
                        style: Get.textTheme.labelLarge?.copyWith(
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
      ),
      barrierDismissible: false,
    );
  }
}