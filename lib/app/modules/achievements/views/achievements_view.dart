import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_guru/constants.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../controllers/achievements_controller.dart';

class AchievementsView extends GetView<AchievementsController> {
  const AchievementsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final appBar = SizedBox(
      height: size.width * 0.2,
      child: Stack(
        children: [
          const Center(child: Text('Achievement',style: titleStyle,)),
          Align(
            alignment: Alignment.centerLeft,
            child: InkWell(
              onTap: ()=> Get.back(),
              child: Container(
                height: size.width/7,
                width: size.width/7,
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
          required String description,
          required Color iconBackColor,
          required Color iconColor,
          required double percent,
          required Color percentColor,
          required String percentValue,
          required IconData iconData}){
      return Container(
        padding: const EdgeInsets.all(15),
        height: size.width * 0.45,
        width: size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  height: size.width * 0.15,
                  width: size.width* 0.15,
                  decoration: BoxDecoration(
                    color: iconBackColor,
                    borderRadius: BorderRadius.circular(150),
                  ),
                  child: Center(child: Icon(iconData,color: iconColor,size: 30,),),
                ),
              ),
            ),
            SizedBox(width: size.width * 0.05,),
            Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,style: headline,),
                  Text(description,style: subTitle,),
                  LinearPercentIndicator(
                    barRadius: const Radius.circular(30),
                    width: size.width * 0.5,
                    lineHeight: size.width * 0.02,
                    percent: percent,
                    backgroundColor: Colors.grey.shade300,
                    progressColor: percentColor,
                    trailing: Text('$percentValue%',style: subTitle,),
                  ),
                ],
              ),
            ),
          ],),
      );
    }
    return Scaffold(
      body: SafeArea(child: Padding(padding: const EdgeInsets.only(top: 15,left: 15,right: 15),
        child: EnterAnimation(Column(children: [
          appBar,
          SizedBox(
            height: size.width * 0.05,
          ),
          //Introduction & Basics
          achievementWidget(
              description: 'You have finished 10 courses in last 7 day\'s',
              title: 'Quick Learner',
              iconData: CupertinoIcons.search,
              iconColor: Colors.white,
              iconBackColor: primaryColor,
            percent: 0.5,
            percentColor: primaryColor,
            percentValue: '50',
          ),
          SizedBox(
            height: size.width * 0.05,
          ),
          //Introduction & Basics
          achievementWidget(
            description: 'You have completed 3 out of 12 skill assessments so far',
            title: 'Skill Master',
            iconData: CupertinoIcons.star,
            iconColor: Colors.white,
            iconBackColor: secondaryColor,
            percent: 0.7,
            percentColor: secondaryColor, percentValue: '70',
          ),
        ],)),
      ),),
    );
  }
}
