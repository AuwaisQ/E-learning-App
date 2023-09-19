import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../constants.dart';
import '../../login/views/login_view.dart';

class OnBoarding3 extends StatelessWidget {
  const OnBoarding3({Key? key}) : super(key: key);

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
              child: Container(
                height: 55,width: 55,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Center(child: Icon(Icons.arrow_forward_ios,color: Colors.grey,),),
              ),
            ),
            const SizedBox(height: 20),
             DelayedDisplay(
              slidingBeginOffset: const Offset(0, -0.4),
              delay: const Duration(milliseconds: 300),
              child: Image.asset(
                'images/onboarding3.png',
              ),
            ),
          ],),
          const DelayedDisplay(
            slidingBeginOffset: Offset(0, -0.4),
            delay: Duration(milliseconds: 300),
            child: Column(children: [
              Text(
                'Fully Flexible Schedule',
                style: titleStyle,
              ),
              SizedBox(height: 10),
              Text(
                'There is no set schedule and you can learn whenever you want',
                textAlign: TextAlign.center,
                style: subTitle,
              ),
            ],),
          ),
          InkWell(
            onTap: ()=> Get.to(const LoginView(),transition: Transition.upToDown),
            child: DelayedDisplay(
              slidingBeginOffset: const Offset(0, -0.4),
              delay: const Duration(milliseconds: 300),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                height: MediaQuery.of(context).size.width/7,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(15)
                ),
                child: const Stack(
                  children: [
                    Center(child: Text('Continue',style: buttonTitleStyle,)),
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