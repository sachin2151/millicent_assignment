import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:millicent_assignment/core/storage_service.dart';
import 'package:millicent_assignment/modules/home/data/models/platform_list_model.dart';

class HomeController extends GetxController {
  HomeController();

  late bool notificationEnabled;
  late bool savePreferenceLoading = false;

  final box = GetStorage();

  @override
  void onInit() async {
    notificationEnabled = box.read(StorageKeys.keyNotificationOn) ?? false;
    String? notificationData = box.read(StorageKeys.keyNotificationData);
    Iterable notificationJsonData = jsonDecode(notificationData ?? "");
    notificationOptionsData = List<PlatformListModel>.from(
        notificationJsonData.map((model) => PlatformListModel.fromJson(model)));
    super.onInit();
  }

  List<PlatformListModel> notificationOptionsData = [
    PlatformListModel(
      platform: "Twitter",
      expanded: true,
      enabled: true,
      option: 0,
      options: [
        Options(title: "As it happens", selected: true),
        Options(title: "Summarised", selected: false)
      ],
    ),
    PlatformListModel(
      platform: "Print",
      enabled: false,
      expanded: true,
      option: 0,
      options: [
        Options(title: "As it happens", selected: true),
        Options(title: "Summarised", selected: false)
      ],
    ),
    PlatformListModel(
      platform: "Online",
      enabled: false,
      expanded: true,
      option: 0,
      options: [
        Options(title: "As it happens", selected: true),
        Options(title: "Summarised", selected: false)
      ],
    ),
  ];
}
