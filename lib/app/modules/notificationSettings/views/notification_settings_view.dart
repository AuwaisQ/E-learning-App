import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../constants.dart';
import '../controllers/notification_settings_controller.dart';

class NotificationSettingsView extends GetView<NotificationSettingsController> {
  NotificationSettingsController notificationController = Get.put(
      NotificationSettingsController());

  NotificationSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    final appBar = SizedBox(
      height: size.width * 0.2,
      child: Stack(
        children: [
          const Center(child: Text('Notifications', style: titleStyle,)),
          Align(
            alignment: Alignment.centerLeft,
            child: InkWell(
              onTap: () => Get.back(),
              child: Container(
                height: size.width / 7,
                width: size.width / 7,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(150),
                    border: Border.all(color: Colors.grey)
                ),
                child: const Center(child: Icon(Icons.arrow_back_ios_new),),
              ),
            ),
          )
        ],
      ),
    );
    Widget achievementWidget(
        {required String title,
          required Color iconBackColor,
          required Color iconColor,
          required Color switcherColor,
          required IconData iconData}){
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: size.width * 0.13,
                width: size.width * 0.13,
                decoration: BoxDecoration(
                  color: iconBackColor,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Center(child: Icon(
                  iconData, color: iconColor, size: 30,),),
              ),
              SizedBox(width: size.width * 0.03,),
              Text(title, style: headline,),
            ],
          ),
          Obx(() {
            return CupertinoSwitch(
              trackColor: Colors.grey.shade300,
              thumbColor: Colors.white,
              activeColor: switcherColor,
              value: notificationController.isNotify.value,
              onChanged: (value) {
                notificationController.isNotify.value = value;
              },
            );
          })
        ],);
    }
    return Scaffold(
      body: SafeArea(
        child: Padding(padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
          child: EnterAnimation(Column(children: [
            appBar,
            SizedBox(height: size.width * 0.07,),
            achievementWidget(
              title: 'Push Notification\'s',
                iconData: CupertinoIcons.bell,
              iconColor: Colors.white,
              iconBackColor: primaryColor,
              switcherColor: primaryColor,
            ),
            SizedBox(height: size.width * 0.07,),
            achievementWidget(
              title: 'Mail Notification\'s',
              iconData: CupertinoIcons.mail,
              iconColor: Colors.white,
              iconBackColor: secondaryColor,
              switcherColor: secondaryColor,
            ),
            SizedBox(height: size.width * 0.07,),
            achievementWidget(
              title: 'Phone Message\'s',
              iconData: CupertinoIcons.device_phone_portrait,
              iconColor: Colors.white,
              iconBackColor: greenColor,
              switcherColor: greenColor,
            ),
          ],),
          ),
        ),),
    );
  }
}
