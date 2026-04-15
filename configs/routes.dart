import 'package:get_x/get_navigation/src/routes/get_route.dart';

import '../views/homescreen.dart';
import '../views/login.dart';
import '../views/signup.dart';

var routes = [
  GetPage(name: "/", page: () => LoginScreen()),
  GetPage(name: "/signup", page: () => SignupScreen()),
  GetPage(name: "/homescreen", page: () => HomeScreen()),
];
