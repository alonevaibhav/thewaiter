import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  final _storage = GetStorage();
  final _key = 'theme_mode';

  // Keep GetX observable for other widgets
  Rx<ThemeMode> themeMode = ThemeMode.system.obs;

  // Add ValueNotifier for MaterialApp (more efficient)
  late final ValueNotifier<ThemeMode> themeModeNotifier;

  @override
  void onInit() {
    super.onInit();
    _loadThemeFromStorage();
    // Initialize ValueNotifier with current theme
    themeModeNotifier = ValueNotifier(themeMode.value);

    // Keep both in sync
    ever(themeMode, (mode) {
      themeModeNotifier.value = mode;
    });
  }

  @override
  void onClose() {
    themeModeNotifier.dispose();
    super.onClose();
  }

  void _loadThemeFromStorage() {
    final savedTheme = _storage.read(_key);
    if (savedTheme != null) {
      themeMode.value = _themeModeFromString(savedTheme);
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    themeMode.value = mode;
    await _storage.write(_key, _themeModeToString(mode));
  }

  void toggleTheme() {
    final newMode = themeMode.value == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
    setThemeMode(newMode);
  }

  ThemeMode _themeModeFromString(String mode) {
    switch (mode) {
      case 'light': return ThemeMode.light;
      case 'dark': return ThemeMode.dark;
      default: return ThemeMode.system;
    }
  }

  String _themeModeToString(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light: return 'light';
      case ThemeMode.dark: return 'dark';
      default: return 'system';
    }
  }

  bool get isDarkMode => themeMode.value == ThemeMode.dark;
  bool get isLightMode => themeMode.value == ThemeMode.light;
  bool get isSystemMode => themeMode.value == ThemeMode.system;
}