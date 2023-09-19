import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../constants.dart';
import '../controllers/prefrences_controller.dart';

class PrefrencesView extends GetView<PrefrencesController> {
  PrefrencesController prefrenceController = Get.put(PrefrencesController());

  PrefrencesView({super.key});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    final appBar = SizedBox(
      height: size.width * 0.2,
      child: Stack(
        children: [
          const Center(child: Text('Preferences', style: titleStyle,)),
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
      return SizedBox(
        height: size.width * 0.25,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.topLeft,
                child: Row(
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
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: headline,),
                  const Text('High quality offers just for you in our mail box every week.', style: subTitle,),
                ],
              ),
            ),
            Obx(() {
              return Expanded(
                flex: 1,
                child: CupertinoSwitch(
                  trackColor: Colors.grey.shade300,
                  thumbColor: Colors.white,
                  activeColor: switcherColor,
                  value: prefrenceController.isNotify.value,
                  onChanged: (value) {
                    prefrenceController.isNotify.value = value;
                  },
                ),
              );
            })
          ],),
      );
    }
    return Scaffold(
      body: SafeArea(
        child: Padding(padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
          child: EnterAnimation(Column(children: [
            appBar,
            SizedBox(height: size.width * 0.07,),
            achievementWidget(
              title: 'Email Promotions',
              iconData: CupertinoIcons.mail,
              iconColor: Colors.white,
              iconBackColor: primaryColor,
              switcherColor: primaryColor,
            ),
            SizedBox(height: size.width * 0.07,),
            achievementWidget(
              title: 'User Feedback',
              iconData: CupertinoIcons.person,
              iconColor: Colors.white,
              iconBackColor: secondaryColor,
              switcherColor: secondaryColor,
            ),
          ],),
          ),
        ),),
    );
  }
}
