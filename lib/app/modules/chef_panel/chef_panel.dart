import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../core/Theme/app_theme.dart';
import '../../core/services/theme_service.dart';
import '../controller/chef_controller.dart';
import 'component/chef_drawer.dart';

class ChefPanel extends StatelessWidget {
  const ChefPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final ChefPanelController controller = Get.put(ChefPanelController());
    final ThemeController themeController = Get.put(ThemeController());

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(
              PhosphorIcons.list(),
              color: colorScheme.onSurface,
              size: 24.sp,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Alpani Hotel',
              style: theme.textTheme.headlineMedium?.copyWith(
                color: colorScheme.onSurface,
              ),
            ),
            Text(
              '2972 Westheimer Rd, Santa Ana, Illinois 85486',
              style: theme.textTheme.bodySmall?.copyWith(
                color: AppTheme.textSecondary,
              ),
            ),
          ],
        ),
      ),
      drawer: SafeArea(child: ChefDrawer()),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Container(
              color: colorScheme.surface,
              padding: EdgeInsets.symmetric(
                horizontal: AppTheme.space16,
                vertical: AppTheme.space12,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                ),
                padding: EdgeInsets.all(4.w),
                child: TabBar(
                  labelColor: AppTheme.textOnPrimary,
                  unselectedLabelColor: colorScheme.onSurface.withOpacity(0.7),
                  labelStyle: theme.textTheme.labelLarge,
                  unselectedLabelStyle: theme.textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                  indicator: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppTheme.primary, AppTheme.primaryDark],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                  splashFactory: NoSplash.splashFactory,
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                  tabs: [
                    Tab(
                      height: 44.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            PhosphorIcons.clockCounterClockwise(),
                            size: 18.sp,
                          ),
                          SizedBox(width: AppTheme.space8),
                          Text('Accept Orders'),
                        ],
                      ),
                    ),
                    Tab(
                      height: 44.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(PhosphorIcons.checkCircle(), size: 18.sp),
                          SizedBox(width: AppTheme.space8),
                          Text('Done Orders'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildPendingOrdersList(),
                  _buildInProgressOrdersList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPendingOrdersList() {
    return Padding(
      padding: EdgeInsets.all(AppTheme.space16),
      child: const Placeholder(),
    );
  }

  Widget _buildInProgressOrdersList() {
    return Padding(
      padding: EdgeInsets.all(AppTheme.space16),
      child: const Placeholder(),
    );
  }
}