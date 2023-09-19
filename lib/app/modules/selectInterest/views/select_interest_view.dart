import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../constants.dart';
import '../controllers/select_interest_controller.dart';

class SelectInterestView extends GetView<SelectInterestController> {
  const SelectInterestView({super.key});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final continueButton = BottomAppBar(
      elevation: 0.0,
      color: Colors.transparent,
      child: InkWell(
        onTap: ()=> Get.toNamed('/bottom-bar'),
        child: DelayedDisplay(
          slidingBeginOffset: const Offset(0, -0.4),
          delay: const Duration(milliseconds: 100),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              height: size.width/7,
              width: double.infinity,
              decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: BorderRadius.circular(15,),
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
      ),
    );
    Widget choiceChip(String label) {
      return DelayedDisplay(
        slidingBeginOffset: const Offset(0, -0.4),
        delay: const Duration(milliseconds: 500),
        child: Chip(
          labelPadding:const EdgeInsets.all(2.0),
          avatar: CircleAvatar(
            backgroundColor: Colors.white70,
            child: Text(label[0].toUpperCase()),
          ),
          label: Text(
            label,
            style: const TextStyle(
              color: Colors.white,letterSpacing: 1,
            ),
          ),
          backgroundColor: primaryColor,
          elevation: 6.0,
          shadowColor: Colors.grey[60],
          padding: const EdgeInsets.all(8.0),
        ),
      );
    }
    return Scaffold(
      ///OTP Button
        bottomNavigationBar: continueButton,
      body: SafeArea(child: Stack(children: [
        Image.asset('images/background.png',
          height: size.height,width: size.width,fit: BoxFit.cover,color: Colors.grey.shade500,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 50),
          child: DelayedDisplay(
            slidingBeginOffset: const Offset(0, -0.4),
            delay: const Duration(milliseconds: 100),
            child: Column(
              children: [
              const Align(
                alignment: Alignment.topCenter,
                  child: Text('What Do you Like ?',style: titleStyle,)),
                SizedBox(height: size.width * 0.05,),
                const Align(
                    alignment: Alignment.topCenter,
                    child: Text('Please choose at least one from the following item\'s to get started',
                      textAlign: TextAlign.center,
                      style: subTitle,)),
                SizedBox(height: size.width * 0.1,),
                Wrap(
                  spacing: 10.0,
                  runSpacing: 10.0,
                  children: [
                    choiceChip('Physics'),
                    choiceChip('IT'),
                    choiceChip('Mathematics'),
                    choiceChip('Geology'),
                    choiceChip('History'),
                    choiceChip('Chemistry'),
                    choiceChip('Sports'),
                    choiceChip('Microbiology'),
                    choiceChip('Title'),
                    choiceChip('Label'),
                  ],
                )
            ],),
          ),
        ),
      ],),)
    );
  }
}
