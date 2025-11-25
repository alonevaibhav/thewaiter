import 'package:get/get.dart';

import '../core/services/theme_service.dart';
import '../modules/auth/login_view_controller.dart';


class AppBindings extends Bindings {
  @override
  void dependencies() {
    // Register all controllers here
    Get.put(ThemeController(), permanent: true);
    // Get.lazyPut<LoginViewController>(() => LoginViewController(), fenix: true);
  }
}
