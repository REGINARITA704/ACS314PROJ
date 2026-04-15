import 'package:get_x/get_rx/src/rx_types/rx_types.dart';
import 'package:get_x/get_state_manager/src/simple/get_controllers.dart';

class LoginController extends GetxController {
  var username = "".obs;
  var password = "".obs;
  var ispasswordvisible = false.obs;
  bool login(String user, String pass) {
    username.value = user;
    password.value = pass;
    if (username.value == "admin" && password.value == "12345") {
      return true;
    } else {
      return false;
    }
  }

  void togglePassword() {
    ispasswordvisible.value = !ispasswordvisible.value;
  }
}
