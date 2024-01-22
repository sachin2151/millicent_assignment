import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:millicent_assignment/modules/home/data/models/platform_list_model.dart';
import 'package:millicent_assignment/modules/home/presentation/controllers/home_controller.dart';

class PlatformSpecificUI extends StatelessWidget {
  PlatformSpecificUI({super.key, required this.data, required this.index});

  final PlatformListModel? data;
  final int index;
  final controller = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (value) {
      return Container(
        margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
        child: Column(
          children: [
            Theme(
              data:
                  Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                initiallyExpanded: data?.expanded ?? false,
                tilePadding: const EdgeInsets.fromLTRB(0, 0, 38, 0),
                onExpansionChanged: (value) {
                  controller.notificationOptionsData[index].expanded =
                      !(data?.expanded ?? false);
                  controller.update();
                },
                trailing:
                    controller.notificationOptionsData[index].enabled ?? false
                        ? Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(color: Colors.orange)),
                            child: Icon(
                              data?.expanded ?? false
                                  ? Icons.expand_less
                                  : Icons.expand_more,
                              size: 20,
                              color: Colors.orange[700],
                            ),
                          )
                        : const SizedBox.shrink(),
                title: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: Row(
                    children: [
                      Text(
                        data?.platform ?? "",
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          controller.notificationOptionsData[index].enabled =
                              !(data?.enabled ?? false);
                          controller.update();
                        },
                        child: Icon(
                          data?.enabled ?? false
                              ? Icons.toggle_on_outlined
                              : Icons.toggle_off_outlined,
                          color: Colors.orange[700],
                          size: 28,
                        ),
                      )
                    ],
                  ),
                ),
                children:
                    controller.notificationOptionsData[index].enabled ?? false
                        ? [
                            optionSelectWidget(
                                context,
                                "Get notified on every tweet as and when happens",
                                0),
                            optionSelectWidget(
                                context,
                                "Hourly summary of volumes on various platforms",
                                1),
                          ]
                        : [],
              ),
            ),
            if (index < (controller.notificationOptionsData.length - 1))
              Container(
                margin: const EdgeInsets.only(top: 20),
                height: 3,
                color: Colors.grey[300],
                width: MediaQuery.of(context).size.width,
              ),
          ],
        ),
      );
    });
  }

  Widget optionSelectWidget(BuildContext context, String description, int i) {
    return GestureDetector(
      onTap: () {
        controller.notificationOptionsData[index].option = i;
        controller.update();
      },
      child: Container(
          decoration: BoxDecoration(
              color: data?.option == i
                  ? Colors.orange.withOpacity(0.1)
                  : Colors.grey.withOpacity(0.1),
              border: Border.all(
                color: data?.option == i
                    ? Colors.orange.withOpacity(0.5)
                    : Colors.grey.withOpacity(0.2),
              )),
          margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
          padding: const EdgeInsets.fromLTRB(10, 10, 15, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data?.options?[i].title ?? ""),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Text(description),
                  ),
                ],
              ),
              Icon(
                data?.option == i
                    ? Icons.radio_button_checked
                    : Icons.radio_button_unchecked,
                color: data?.option == i ? Colors.orange[700] : Colors.grey,
              ),
            ],
          )),
    );
  }
}
