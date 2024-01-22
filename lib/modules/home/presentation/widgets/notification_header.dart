import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:millicent_assignment/core/strings.dart';
import 'package:millicent_assignment/modules/home/presentation/controllers/notification_controller.dart';

class NotificationHeader extends StatelessWidget {
  NotificationHeader({super.key});

  final controller = Get.find<NotificationController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            GlobalStrings.notifications,
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
          ),
          GetBuilder<NotificationController>(builder: (value) {
            return IconButton(
              onPressed: () {
                controller.mainNotificationToggle();
              },
              icon: Icon(
                controller.notificationEnabled
                    ? Icons.toggle_on_outlined
                    : Icons.toggle_off_outlined,
                color: Colors.orange[700],
                size: 30,
              ),
            );
          })
        ],
      ),
    );
  }
}
