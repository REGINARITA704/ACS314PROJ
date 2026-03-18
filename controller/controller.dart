import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class LoginController extends GetxController {
  var Username;
  var Password;
  var ispasswordvisible = false.obs;
  login(User, Pass) {
    Username = User;
    Password = Pass;
    if (Username == "admin" && Password == "12345") {
      return true;
    } else {
      return false;
    }
  }

  togglepassword() {
    ispasswordvisible.value = !ispasswordvisible.value;
  }
}
