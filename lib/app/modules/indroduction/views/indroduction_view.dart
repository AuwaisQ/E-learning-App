import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../../../constants.dart';
import '../controllers/indroduction_controller.dart';

class IntroductionView extends GetView<IndroductionController> {
  const IntroductionView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final appBar = DelayedDisplay(
      delay: const Duration(milliseconds: 200),
      slidingBeginOffset: const Offset(0, -0.4),
      child: SizedBox(
        height: size.width/6,
        child: Stack(
          children: [
            const Center(child: Text('JavaScript',style: titleStyle,)),
            //Back Button
            Align(
              alignment: Alignment.centerLeft,
              child: InkWell(
                onTap: ()=> Get.back(),
                child: Container(
                  height: size.width * 0.15,
                  width: size.width* 0.15,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(150),
                      border: Border.all(color: Colors.grey)
                  ),
                  child: const Center(child: Icon(Icons.arrow_back_ios_new),),
                ),
              ),
            ),
            //Wallet Button
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () {},
                child: Container(
                  height: size.width * 0.15,
                  width: size.width* 0.15,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(150),
                      border: Border.all(color: Colors.grey)
                  ),
                  child: const Center(child: Icon(Icons.account_balance_wallet_outlined),),
                ),
              ),
            )
          ],
        ),
      ),
    );
    return Scaffold(
      body: SafeArea(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
        child: SingleChildScrollView(
          child: Column(children: [
            appBar,
            SizedBox(
              height: size.width * 0.05,
            ),
            DelayedDisplay(
              delay: const Duration(milliseconds: 200),
              slidingBeginOffset: const Offset(0, -0.4),
              child: Container(
                padding: const EdgeInsets.all(15),
                height: size.width * 0.45,
                width: size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('- 3h 15min.',style: TextStyle(fontSize: 15,color: Colors.grey),),
                      Text('JavaScript',style: titleStyle,),
                      Text('Advance web \nApplications.',style: subTitle,),
                    ],
                  ),
                  Image.asset('images/introImage.png')
                ],),
              ),
            ),
            SizedBox(
              height: size.width * 0.1,
            ),
            const  DelayedDisplay(
              delay:Duration(milliseconds: 200),
              slidingBeginOffset: Offset(0, -0.4),
              child:Align(
                alignment: Alignment.centerLeft,
                  child: Text('Lessons 📖',style: titleStyle),
              ),
            ),
            SizedBox(
              height: size.width * 0.05,
            ),
            //Introduction & Basics
            DelayedDisplay(
              delay: const Duration(milliseconds: 200),
              slidingBeginOffset: const Offset(0, -0.4),
              child: InkWell(
                onTap: ()=>Get.toNamed('/course-lessons'),
                child: Container(
                  padding: const EdgeInsets.all(15),
                  height: size.width * 0.45,
                  width: size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Row(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          height: size.width * 0.15,
                          width: size.width* 0.15,
                          decoration: BoxDecoration(
                            color: primaryColor,
                              borderRadius: BorderRadius.circular(150),
                          ),
                          child: const Center(child: FaIcon(FontAwesomeIcons.magnifyingGlass,color: Colors.white,size: 30,),),
                        ),
                      ),
                      SizedBox(width: size.width * 0.05,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const  Text('- 0h 55min.',style: TextStyle(fontSize: 15,color: Colors.grey),),
                          const Text('Introduction & Basics',style: titleStyle,),
                          const Text('Advance web Applications.',style: subTitle,),
                          LinearPercentIndicator(
                            barRadius: const Radius.circular(30),
                            width: size.width * 0.5,
                            lineHeight: size.width * 0.02,
                            percent: 0.7,
                            backgroundColor: Colors.grey.shade300,
                            progressColor: primaryColor,
                            trailing: const Text('70%',style: subTitle,),
                          ),
                        ],
                      ),
                    ],),
                ),
              ),
            ),
            SizedBox(
              height: size.width * 0.05,
            ),
            //Terminology
            DelayedDisplay(
              delay: const Duration(milliseconds: 200),
              slidingBeginOffset: const Offset(0, -0.4),
              child: Container(
                padding: const EdgeInsets.all(15),
                height: size.width * 0.45,
                width: size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey),
                ),
                child: Row(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        height: size.width * 0.15,
                        width: size.width* 0.15,
                        decoration: BoxDecoration(
                          color: secondaryColor,
                          borderRadius: BorderRadius.circular(150),
                        ),
                        child: const Center(child: FaIcon(FontAwesomeIcons.chartSimple,color: Colors.white,size: 30,),),
                      ),
                    ),
                    SizedBox(width: size.width * 0.05,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const  Text('- 1h 15min.',style: TextStyle(fontSize: 15,color: Colors.grey),),
                        const Text('Terminology',style: titleStyle,),
                        const Text('Advance web Applications.',style: subTitle,),
                        LinearPercentIndicator(
                          barRadius: const Radius.circular(30),
                          width: size.width * 0.5,
                          lineHeight: size.width * 0.02,
                          percent: 0.4,
                          backgroundColor: Colors.grey.shade300,
                          progressColor: secondaryColor,
                          trailing: const Text('40%',style: subTitle,),
                        ),
                      ],
                    ),
                  ],),
              ),
            ),
            SizedBox(
              height: size.width * 0.05,
            ),
            //Advance Apps
            Container(
              padding: const EdgeInsets.all(15),
              height: size.width * 0.45,
              width: size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.grey),
              ),
              child: Row(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      height: size.width * 0.15,
                      width: size.width* 0.15,
                      decoration: BoxDecoration(
                        color: greenColor,
                        borderRadius: BorderRadius.circular(150),
                      ),
                      child: const Center(child: FaIcon(FontAwesomeIcons.gear,color: Colors.white,size: 30,),),
                    ),
                  ),
                  SizedBox(width: size.width * 0.05,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const  Text('- 0h 25min.',style: TextStyle(fontSize: 15,color: Colors.grey),),
                      const Text('Advance Apps',style: titleStyle,),
                      const Text('Advance web Applications.',style: subTitle,),
                      LinearPercentIndicator(
                        barRadius: const Radius.circular(30),
                        width: size.width * 0.5,
                        lineHeight: size.width * 0.02,
                        percent: 0.5,
                        backgroundColor: Colors.grey.shade300,
                        progressColor: greenColor,
                        trailing: const Text('50%',style: subTitle,),
                      ),
                    ],
                  ),
                ],),
            ),
            SizedBox(
              height: size.width * 0.05,
            ),
            //Final Assessment
            Container(
              padding: const EdgeInsets.all(15),
              height: size.width * 0.45,
              width: size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.grey),
              ),
              child: Row(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      height: size.width * 0.15,
                      width: size.width* 0.15,
                      decoration: BoxDecoration(
                        color: redColor,
                        borderRadius: BorderRadius.circular(150),
                      ),
                      child: const Center(child: FaIcon(FontAwesomeIcons.star,color: Colors.white,size: 30,),),
                    ),
                  ),
                  SizedBox(width: size.width * 0.05,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const  Text('- 0h 35min.',style: TextStyle(fontSize: 15,color: Colors.grey),),
                      const Text('Final Assessment',style: titleStyle,),
                      const Text('Advance web Applications.',style: subTitle,),
                      LinearPercentIndicator(
                        barRadius: const Radius.circular(30),
                        width: size.width * 0.5,
                        lineHeight: size.width * 0.02,
                        percent: 0.7,
                        backgroundColor: Colors.grey.shade300,
                        progressColor: redColor,
                        trailing: const Text('70%',style: subTitle,),
                      ),
                    ],
                  ),
                ],),
            ),
          ],),
        ),
      ),),
    );
  }
}
