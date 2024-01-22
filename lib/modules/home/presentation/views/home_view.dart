import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:millicent_assignment/core/storage_service.dart';
import 'package:millicent_assignment/core/strings.dart';
import 'package:millicent_assignment/modules/home/presentation/controllers/home_controller.dart';
import 'package:millicent_assignment/modules/home/presentation/widgets/notification_header.dart';
import 'package:millicent_assignment/modules/home/presentation/widgets/platform_notification_ui.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (value) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[200],
          elevation: 0,
          centerTitle: true,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.grey[200],
          ),
          leading: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          title: const Text(
            GlobalStrings.appBarTitle,
            style: TextStyle(color: Colors.black),
          ),
        ),
        bottomNavigationBar: GestureDetector(
          onTap: () {
            if (controller.savePreferenceLoading == false) {
              controller.savePreferenceLoading = true;
              controller.update();
              Future.delayed(const Duration(seconds: 2), () {
                controller.box.write(StorageKeys.keyNotificationOn,
                    controller.notificationEnabled);
                controller.box.write(StorageKeys.keyNotificationData,
                    jsonEncode(controller.notificationOptionsData));

                Get.snackbar("Hey", GlobalStrings.preferenceUpdated,
                    snackPosition: SnackPosition.TOP,
                    margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    backgroundColor: Colors.orange[100]);
                controller.savePreferenceLoading = false;
                controller.update();
              });
            }
          },
          child: Container(
            height: 48,
            decoration: BoxDecoration(
                color: Colors.orange[700],
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
            child: controller.savePreferenceLoading
                ? const Center(
                    child: CircularProgressIndicator(
                    color: Colors.white,
                  ))
                : const Text(
                    GlobalStrings.saveMyPreference,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700),
                  ),
          ),
        ),
        body: ScrollConfiguration(
          behavior: const ScrollBehavior().copyWith(overscroll: false),
          child: SingleChildScrollView(
            child: Column(
              children: [
                NotificationHeader(),
                dividerLine(context),
                controller.notificationEnabled
                    ? Column(
                        children: List.generate(
                          controller.notificationOptionsData.length,
                          (index) => PlatformSpecificUI(
                            data: controller.notificationOptionsData[index],
                            index: index,
                          ),
                        ),
                      )
                    : const Padding(
                        padding: EdgeInsets.only(top: 40, left: 20, right: 20),
                        child: Text(
                          GlobalStrings.notificationDisabledMsg,
                          textAlign: TextAlign.center,
                        ),
                      )
              ],
            ),
          ),
        ),
      );
    });
  }

  Container dividerLine(BuildContext context) {
    return Container(
      height: 3,
      color: Colors.grey[400],
      width: MediaQuery.of(context).size.width,
    );
  }
}
