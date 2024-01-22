import 'package:get/get.dart';
import 'package:millicent_assignment/modules/home/presentation/controllers/home_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
