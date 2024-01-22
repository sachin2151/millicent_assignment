import 'package:get/get.dart';
import 'package:millicent_assignment/modules/home/presentation/bindings/home_binding.dart';
import 'package:millicent_assignment/modules/home/presentation/bindings/notification_binding.dart';
import 'package:millicent_assignment/modules/home/presentation/views/home_view.dart';
import 'package:millicent_assignment/modules/home/presentation/views/notification_view.dart';

class OneRoute {
  static const String homeView = "home-view";
  static const String notificationView = "notification-view";
  static List<GetPage> routes = [
    GetPage(
      name: '/$notificationView',
      page: () => const NotificationView(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: '/$homeView',
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
  ];
}
