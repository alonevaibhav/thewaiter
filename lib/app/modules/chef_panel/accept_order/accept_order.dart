import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:get/get.dart';
import '../../../core/Theme/app_theme.dart';
import '../../controller/chef_controller/accept_order_controller.dart';

class AcceptOrdersPage extends StatelessWidget {
  const AcceptOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AcceptOrdersController());
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Obx(() {
      if (controller.orders.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                PhosphorIcons.clipboardText(),
                size: 64.sp,
                color: colorScheme.onSurface.withOpacity(0.3),
              ),
              SizedBox(height: 12.h),
              Text(
                'No Pending Orders',
                style: textTheme.titleLarge?.copyWith(
                  color: colorScheme.onSurface.withOpacity(0.6),
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                'All orders have been processed',
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurface.withOpacity(0.5),
                ),
              ),
            ],
          ),
        );
      }

      return ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 10.h),
        itemCount: controller.orders.length,
        itemBuilder: (context, index) {
          final order = controller.orders[index];
          return buildOrderCard(context, order, theme, colorScheme, textTheme);
        },
      );
    });
  }

  Widget buildOrderCard(
      BuildContext context,
      Map<String, dynamic> order,
      ThemeData theme,
      ColorScheme colorScheme,
      TextTheme textTheme,
      ) {
    final controller = Get.find<AcceptOrdersController>();
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: isDark ? AppTheme.darkShadowSmall : AppTheme.shadowSmall,
      ),
      child: Column(
        children: [
          // Header with Gradient
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  colorScheme.primary.withOpacity(0.1),
                  colorScheme.primary.withOpacity(0.05),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(14.r),
                topRight: Radius.circular(14.r),
              ),
            ),
            child: Row(
              children: [
                // Order Number Badge
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        colorScheme.primary,
                        isDark ? AppTheme.primaryLight : AppTheme.primaryDark,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    'Order #${order['orderNo']}',
                    style: textTheme.labelLarge?.copyWith(
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 13.sp,
                    ),
                  ),
                ),
                const Spacer(),
                // Time
                Icon(
                  PhosphorIcons.clock(),
                  size: 14.sp,
                  color: colorScheme.onSurface.withOpacity(0.6),
                ),
                SizedBox(width: 4.w),
                Text(
                  order['time'],
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurface.withOpacity(0.6),
                    fontWeight: FontWeight.w600,
                    fontSize: 12.sp,
                  ),
                ),
                SizedBox(width: 10.w),
                // Table Badge
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: AppTheme.success.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: AppTheme.success.withOpacity(0.3),
                      width: 1.2,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        PhosphorIcons.desk(),
                        size: 12.sp,
                        color: AppTheme.success,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        'Table ${order['tableNo']}',
                        style: textTheme.labelMedium?.copyWith(
                          color: AppTheme.success,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Items Section
          Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Food Items Header
                Row(
                  children: [
                    Icon(
                      PhosphorIcons.forkKnife(),
                      size: 16.sp,
                      color: colorScheme.primary,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      'Food Items',
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),

                // Items List
                ...List.generate(order['items'].length, (index) {
                  final item = order['items'][index];
                  return Container(
                    margin: EdgeInsets.only(bottom: 8.h),
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerHighest.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Row(
                      children: [
                        // Quantity Badge
                        Container(
                          width: 28.w,
                          height: 28.h,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                colorScheme.primary,
                                isDark ? AppTheme.primaryLight : AppTheme.primaryDark,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Center(
                            child: Text(
                              '${item['quantity']}',
                              style: textTheme.labelLarge?.copyWith(
                                color: colorScheme.onPrimary,
                                fontWeight: FontWeight.bold,
                                fontSize: 13.sp,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        // Item Name
                        Expanded(
                          child: Text(
                            item['name'],
                            style: textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),

                // Special Instructions
                if (order['specialInstructions'] != null) ...[
                  SizedBox(height: 8.h),
                  Container(
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                      color: AppTheme.warning.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(
                        color: AppTheme.warning.withOpacity(0.3),
                        width: 1.2,
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          PhosphorIcons.notepad(),
                          size: 14.sp,
                          color: AppTheme.warning,
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Special Instructions',
                                style: textTheme.labelSmall?.copyWith(
                                  color: AppTheme.warning,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11.sp,
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                order['specialInstructions'],
                                style: textTheme.bodyMedium?.copyWith(
                                  color: colorScheme.onSurface.withOpacity(0.7),
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),

          // Action Buttons
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest.withOpacity(0.3),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(14.r),
                bottomRight: Radius.circular(14.r),
              ),
            ),
            child: Row(
              children: [
                // Reject Button
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => controller.showRejectDialog(order['orderNo'],context),
                    icon: Icon(PhosphorIcons.x(), size: 16.sp),
                    label: Text(
                      'Reject',
                      style: TextStyle(fontSize: 13.sp),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: colorScheme.error,
                      padding: EdgeInsets.symmetric(vertical: 11.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      side: BorderSide(
                        color: colorScheme.error,
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                // Accept Button
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () => controller.acceptOrder(order['orderNo']),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      foregroundColor: colorScheme.onPrimary,
                    ),
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            colorScheme.primary,
                            isDark ? AppTheme.primaryLight : AppTheme.primaryDark,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 11.h),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(PhosphorIcons.check(), size: 16.sp),
                            SizedBox(width: 6.w),
                            Text(
                              'Accept Order',
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}