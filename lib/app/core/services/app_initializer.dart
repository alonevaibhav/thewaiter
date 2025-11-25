import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'api_service.dart';
import 'theme_service.dart';
import '../../../apputils/services/Notification/notification_service.dart';

class AppInitializer {
  static Future<void> initialize() async {
    // Initialize GetStorage
    await GetStorage.init();

    // Initialize API Service
    await ApiService.init();

    // Initialize notification service
    await Get.putAsync(() => NotificationService().init());


    // Initialize controllers
    Get.put(ThemeController(), permanent: true);
  }
}