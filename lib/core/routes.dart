import 'package:get/get.dart';
import 'package:millicent_assignment/modules/home/presentation/bindings/home_binding.dart';
import 'package:millicent_assignment/modules/home/presentation/views/home_view.dart';

class OneRoute {
  static const String homeView = "home-view";
  static List<GetPage> routes = [
    GetPage(
      name: '/$homeView',
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
  ];
}
