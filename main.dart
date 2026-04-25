import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/TaskController.dart';
import 'package:flutter_application_1/controller/ThemeController.dart';
import 'package:flutter_application_1/views/Dashboard_screen.dart';
import 'package:flutter_application_1/views/homescreen.dart';
import 'package:flutter_application_1/views/login.dart';
import 'package:flutter_application_1/views/signup.dart';
import 'package:get/get.dart';

List<GetPage> routes = [
  GetPage(name: '/', page: () => const LoginScreen()),
  GetPage(name: '/login', page: () => const LoginScreen()),
  GetPage(name: '/signup', page: () => const SignupScreen()),
  GetPage(name: '/homescreen', page: () => const HomeScreen()),
  GetPage(name: '/dashboard', page: () => const DashboardScreen()),
];

class MyTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': {
      'Settings': 'Settings',
      'Save': 'Save',
      'Edit': 'Edit',
      'Profile': 'Profile',
      'Username': 'Username',
      'Email': 'Email',
      'Appearance': 'Appearance',
      'Dark Mode': 'Dark Mode',
      'Dark theme is on': 'Dark theme is on',
      'Light theme is on': 'Light theme is on',
      'Notifications': 'Notifications',
      'Push Notifications': 'Push Notifications',
      "You'll receive task reminders": "You'll receive task reminders",
      'Notifications are off': 'Notifications are off',
      'Preferences': 'Preferences',
      'Clear All Tasks': 'Clear All Tasks',
      'Remove all tasks permanently': 'Remove all tasks permanently',
      'About': 'About',
      'App Version': 'App Version',
      'Built with': 'Built with',
      'Cancel': 'Cancel',
      'Clear': 'Clear',
    },
    'sw_KE': {
      'Settings': 'Mipangilio',
      'Save': 'Hifadhi',
      'Edit': 'Hariri',
      'Profile': 'Wasifu',
      'Username': 'Jina la mtumiaji',
      'Email': 'Barua pepe',
      'Appearance': 'Muonekano',
      'Dark Mode': 'Hali ya Giza',
      'Dark theme is on': 'Mandhari ya giza imewashwa',
      'Light theme is on': 'Mandhari ya mwanga imewashwa',
      'Notifications': 'Arifa',
      'Push Notifications': 'Arifa za kusukuma',
      "You'll receive task reminders": "Utapokea vikumbusho vya kazi",
      'Notifications are off': 'Arifa zimezimwa',
      'Preferences': 'Mapendeleo',
      'Clear All Tasks': 'Futa kazi zote',
      'Remove all tasks permanently': 'Ondoa kazi zote kabisa',
      'About': 'Kuhusu',
      'App Version': 'Toleo la programu',
      'Built with': 'Imetengenezwa kwa',
      'Cancel': 'Ghairi',
      'Clear': 'Futa',
    },
  };
}

void main() {
  final themeController = Get.put(ThemeController());
  Get.put(TaskController());

  runApp(
    Obx(
      () => GetMaterialApp(
        home: const LoginScreen(),
        initialRoute: '/',
        getPages: routes,
        debugShowCheckedModeBanner: false,

        translations: MyTranslations(),
        locale: const Locale('en', 'US'),
        fallbackLocale: const Locale('en', 'US'),

        themeMode: themeController.themeMode,
        theme: ThemeData.light(useMaterial3: true),
        darkTheme: ThemeData.dark(useMaterial3: true),
      ),
    ),
  );
}
