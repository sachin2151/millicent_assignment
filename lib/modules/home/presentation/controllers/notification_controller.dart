import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:millicent_assignment/core/storage_service.dart';
import 'package:millicent_assignment/core/strings.dart';
import 'package:millicent_assignment/modules/home/data/models/platform_list_model.dart';

class NotificationController extends GetxController {
  NotificationController();

  /// Varibales to store notifcation and preference loading state
  late bool notificationEnabled;
  late bool savePreferenceLoading = false;

  final pref = GetStorage();

  @override
  void onInit() async {
    notificationEnabled = pref.read(StorageKeys.keyNotificationOn) ?? true;
    String? notificationData = pref.read(StorageKeys.keyNotificationData);
    Iterable notificationJsonData = jsonDecode(notificationData ?? "");
    notificationOptionsData = List<PlatformListModel>.from(
        notificationJsonData.map((model) => PlatformListModel.fromJson(model)));
    super.onInit();
  }

  /// Expand Expansion Tile
  expandExpansionTile(int index) {
    notificationOptionsData[index].expanded =
        !(notificationOptionsData[index].expanded ?? false);
    update();
  }

  /// Toggle Platform Value
  platformToggle(int index) {
    notificationOptionsData[index].enabled =
        !(notificationOptionsData[index].enabled ?? false);
    update();
  }

  /// Save Selected Options
  saveSelectedOption(int index, int i) {
    notificationOptionsData[index].option = i;
    update();
  }

  /// Toggle Main Notification Value
  mainNotificationToggle() {
    notificationEnabled = !notificationEnabled;
    update();
  }

  //Save My Preference
  saveSelectedPreference() {
    if (savePreferenceLoading == false) {
      /// savePreferenceLoading key for handling loading state  while saving
      savePreferenceLoading = true;
      update();
      Future.delayed(const Duration(seconds: 2), () {
        /// store in local storage
        pref.write(StorageKeys.keyNotificationOn, notificationEnabled);
        pref.write(StorageKeys.keyNotificationData,
            jsonEncode(notificationOptionsData));

        /// show snackbar after added into local storage
        Get.snackbar("Hey", GlobalStrings.preferenceUpdated,
            snackPosition: SnackPosition.TOP,
            margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            backgroundColor: Colors.orange[100]);
        savePreferenceLoading = false;
        update();
      });
    }
  }

  /// Initial Data set
  List<PlatformListModel> notificationOptionsData = [
    PlatformListModel(
      platform: "Twitter",
      expanded: true,
      enabled: true,
      option: 0,
      options: [
        Options(
            title: "As it happens",
            description: "Get notified on every tweet as and when happens",
            selected: true),
        Options(
            title: "Summarised",
            description: "Hourly summary of volumes on various platforms",
            selected: false)
      ],
    ),
    PlatformListModel(
      platform: "Print",
      enabled: false,
      expanded: true,
      option: 0,
      options: [
        Options(
            title: "As it happens",
            description: "Get notified on every tweet as and when happens",
            selected: true),
        Options(
            title: "Summarised",
            description: "Hourly summary of volumes on various platforms",
            selected: false)
      ],
    ),
    PlatformListModel(
      platform: "Online",
      enabled: false,
      expanded: true,
      option: 0,
      options: [
        Options(
            title: "As it happens",
            description: "Get notified on every tweet as and when happens",
            selected: true),
        Options(
            title: "Summarised",
            description: "Hourly summary of volumes on various platforms",
            selected: false)
      ],
    ),
  ];
}
