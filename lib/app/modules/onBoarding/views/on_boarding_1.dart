import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants.dart';

class OnBoarding1 extends StatelessWidget {
  const OnBoarding1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(children: [
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () {
                  Get.toNamed('/login');
                },
                child: const Text('Skip',style: subTitle,),
              ),
            ),
            const SizedBox(height: 20),
            DelayedDisplay(
              slidingBeginOffset: const Offset(0, -0.4),
              delay: const Duration(milliseconds: 300),
              child: Image.asset(
                'images/onboarding1.png',
              ),
            ),
          ],),
          const DelayedDisplay(
            slidingBeginOffset: Offset(0, -0.4),
            delay: Duration(milliseconds: 300),
            child: Column(children: [
              Text(
                'Share your creativity',
                style: titleStyle,
              ),
              SizedBox(height: 10),
              Text(
                'Make and work on your creative ideas and share with peer By using MiniGurus platform For 8-14 year kids',
                textAlign: TextAlign.center,
                style: subTitle,
              ),
            ],),
          ),
          DelayedDisplay(
            slidingBeginOffset: const Offset(0, -0.4),
            delay: const Duration(milliseconds: 300),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SizedBox(
                height: MediaQuery.of(context).size.width/6,
                width: double.infinity,
                child: const Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text('Get Started',style: buttonTitleStyle,),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Icon(Icons.arrow_forward_ios,size: 20,),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
