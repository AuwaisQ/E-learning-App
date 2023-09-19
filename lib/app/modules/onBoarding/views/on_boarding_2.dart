import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import '../../../../constants.dart';

class OnBoarding2 extends StatelessWidget {
  const OnBoarding2({Key? key}) : super(key: key);

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
                'images/onboarding2.png',
              ),
            ),
          ],),
          const DelayedDisplay(
            slidingBeginOffset: Offset(0, -0.4),
            delay: Duration(milliseconds: 300),
            child: Column(children: [
              Text(
                'Your own pace and speed',
                style: titleStyle,
              ),
              SizedBox(height: 10),
              Text(
                'The tools on the platform facilitate your progress according to you',
                textAlign: TextAlign.center,
                style: subTitle,
              ),
            ],),
          ),
          const DelayedDisplay(
            delay: Duration(milliseconds: 300),
            slidingBeginOffset: Offset(0, -0.4),
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Icon(Icons.arrow_back_ios,size: 20,),
                Text('Continue',style: buttonTitleStyle,),
                Icon(Icons.arrow_forward_ios,size: 20,),
              ],),
            ),
          ),
        ],
      ),
    );
  }
}
