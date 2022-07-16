import 'package:chatter/controller/home_controller.dart';
import 'package:chatter/controller/login_controller.dart';
import 'package:get/get.dart';

class ChatterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController(), fenix: true);
    Get.lazyPut(() => LoginController(), fenix: true);
  }
}
