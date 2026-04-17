import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/TaskController.dart';

import 'package:get_x/get_navigation/src/root/get_material_app.dart';
import 'package:get_x/get_navigation/src/routes/get_route.dart';

import 'views/calendar_page.dart';
import 'views/login.dart';
import 'views/signup.dart';
import 'views/homescreen.dart';
import 'views/Dashboard_screen.dart';
import 'lib/controller/TaskController.dart';
import 'views/profile.dart';
import 'views/settings.dart';

List<GetPage> routes = [
  GetPage(name: '/', page: () => LoginScreen()),
  GetPage(name: '/login', page: () => LoginScreen()),
  GetPage(name: '/signup', page: () => SignupScreen()),
  GetPage(name: '/homescreen', page: () => HomeScreen()),
];

void main() {
  Get.put(TaskController());
  runApp(
    GetMaterialApp(
      home: const MovingCalendar(),
      initialRoute: '/',
      getPages: routes,
      debugShowCheckedModeBanner: false,
    ),
  );
}
