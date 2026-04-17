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
        themeMode: themeController.themeMode,
        theme: ThemeData.light(useMaterial3: true),
        darkTheme: ThemeData.dark(useMaterial3: true),
      ),
    ),
  );
}
