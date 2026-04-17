import 'package:flutter_application_1/views/Dashboard_screen.dart';
import 'package:flutter_application_1/views/homescreen.dart';
import 'package:flutter_application_1/views/login.dart';
import 'package:flutter_application_1/views/signup.dart';
import 'package:get/get.dart';

var routes = [
  GetPage(name: '/', page: () => const LoginScreen()),
  GetPage(name: '/signup', page: () => const SignupScreen()),
  GetPage(name: '/homescreen', page: () => const HomeScreen()),
  GetPage(name: '/dashboard', page: () => const DashboardScreen()),
];
