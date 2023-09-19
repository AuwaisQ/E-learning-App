import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_guru/app/modules/onBoarding/views/on_boarding_3.dart';
import 'package:mini_guru/constants.dart';
import 'package:onboarding_animation/onboarding_animation.dart';
import '../controllers/on_boarding_controller.dart';
import 'on_boarding_1.dart';
import 'on_boarding_2.dart';

class OnBoardingView extends GetView<OnBoardingController> {
  const OnBoardingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.only(bottom: 20),
        child: OnBoardingAnimation(
          pages: [
            OnBoarding1(),
            OnBoarding2(),
            OnBoarding3(),
          ],
          indicatorDotHeight: 10.0,
          indicatorDotWidth: 10.0,
          indicatorActiveDotColor: primaryColor,
          indicatorInActiveDotColor: primaryColor,
          indicatorType: IndicatorType.expandingDots,
          indicatorPosition: IndicatorPosition.bottomCenter,
        ),
      ),
    );
  }
}
