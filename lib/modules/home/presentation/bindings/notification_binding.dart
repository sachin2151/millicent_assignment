import 'package:get/get.dart';
import 'package:millicent_assignment/modules/home/presentation/controllers/notification_controller.dart';

class NotificationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationController>(() => NotificationController());
  }
}
