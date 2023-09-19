import 'package:delayed_display/delayed_display.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../constants.dart';
import '../controllers/filters_controller.dart';

class FiltersView extends GetView<FiltersController> {
  FiltersController filtersController = Get.put(FiltersController());

  FiltersView({super.key});
  @override
  Widget build(BuildContext context) {

    final List<String> ageList = ['1', '2', '3', '4'];
    final size = MediaQuery.of(context).size;
    final ageUnselected = InkWell(
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      onTap: () {
        filtersController.isAgeSwitcher.value = true;
      },
      child: Image.asset(
        'images/ageunselected.png',
        height: size.width / 3,
        width: size.width / 5,
      ),
    );
    final ageSelected = InkWell(
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      onTap: () {
        filtersController.isAgeSwitcher.value = false;
      },
      child: Image.asset(
        'images/ageYellowSelected.png',
        height: size.width / 3,
        width: size.width / 5,
      ),
    );
    // final topicUnselected = InkWell(
    //   overlayColor: MaterialStateProperty.all(Colors.transparent),
    //   onTap: () {
    //     filtersController.isTopicSwitcher.value = true;
    //   },
    //   child: Image.asset(
    //     'images/topicUnselected.png',
    //     height: size.width / 3,
    //     width: size.width / 5,
    //   ),
    // );
    final topicSelected = InkWell(
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      onTap: () {
        filtersController.isTopicSwitcher.value = false;
      },
      child: Image.asset(
        'images/topicYellowSelected.png',
        height: size.width / 3,
        width: size.width / 5,
      ),
    );
    final cityUnselected = InkWell(
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      onTap: () {
        filtersController.isCitySwitcher.value = true;
      },
      child: Image.asset(
        'images/cityUnselected.png',
        height: size.width / 3,
        width: size.width / 5,
      ),
    );
    final citySelected = InkWell(
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      onTap: () {
        filtersController.isCitySwitcher.value = false;
      },
      child: Image.asset(
        'images/cityYellowSelected.png',
        height: size.width / 3,
        width: size.width / 5,
      ),
    );
    final commentsUnselected = InkWell(
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      onTap: () {
        filtersController.isCommentsSwitcher.value = true;
      },
      child: Image.asset(
        'images/commentsUnselected.png',
        height: size.width / 3,
        width: size.width / 5,
      ),
    );
    final commentsSelected = InkWell(
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      onTap: () {
        filtersController.isCommentsSwitcher.value = false;
      },
      child: Image.asset(
        'images/commentsYellowSelected.png',
        height: size.width / 3,
        width: size.width / 5,
      ),
    );
    Widget unselectedClass(String text){
      return InkWell(
        onTap: ()=> filtersController.is1stClass.value = false,
        child: Container(
          height: size.width / 5,
          width: size.width / 5,
          decoration: BoxDecoration(
            border: Border.all(color: primaryColor),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(child: Text(text,textAlign: TextAlign.center,style: headline1,),),
        ),
      );
    }

    Widget selectedClass(String text){
      return InkWell(
        onTap: ()=> filtersController.is1stClass.value = true,
        child: Container(
          height: size.width / 5,
          width: size.width / 5,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(15),
          ),
          child: const Center(child: Text('1st Class',style: subTitle,),),
        ),
      );
    }

    final continueButton = BottomAppBar(
      elevation: 0.0,
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
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

    return Scaffold(
      bottomNavigationBar:continueButton,
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: EnterAnimation( Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            InkWell(
              onTap: ()=> Get.back(),
              child: Container(
                height: size.width / 7,
                width: size.width / 7,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: Colors.grey),
                ),
                child: const Center(child: Icon(Icons.arrow_back_ios_new),),
              ),
            ),
              SizedBox(
                height: size.width / 10,
              ),
              const Text(
                'Category',
                style: headline1,
              ),
              SizedBox(
                height: size.width / 30,
              ),
              Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    filtersController.isAgeSwitcher.value == true ? ageSelected : ageUnselected,
                    //filtersController.isTopicSwitcher.value == true ? topicSelected : topicUnselected,
                    filtersController.isCitySwitcher.value == true ? citySelected : cityUnselected,
                    filtersController.isCommentsSwitcher.value == true ? commentsSelected : commentsUnselected,
                  ],
                );
              }),
              SizedBox(
                height: size.width / 10,
              ),
              const Text(
                'Category',
                style: headline1,
              ),
              SizedBox(
                height: size.width / 30,
              ),
              Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    filtersController.is1stClass.value == true ? unselectedClass('1st Class') : selectedClass('1st Class'),

                    filtersController.is1stClass.value == true ? unselectedClass('1st Class') : selectedClass('1st Class'),
                    filtersController.is1stClass.value == true ? unselectedClass('1st Class') : selectedClass('1st Class'),
                  ],
                );
              }),
              SizedBox(
                height: size.width / 10,
              ),
              const Text(
                'Select Age',
                style: headline1,
              ),
              SizedBox(
                height: size.width / 30,
              ),
              //Drop Down Widget
              Container(
                height: size.width / 7,
                decoration: BoxDecoration(
                  borderRadius:BorderRadius.circular(7),
                  border: Border.all(color: Colors.grey.shade400,width: 2),
                ),
                child: Center(
                  child: DropdownButtonHideUnderline(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10),
                      child: DropdownButton2(
                        dropdownDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey.shade400),
                        ),
                        isExpanded: true,
                        isDense: true,
                        hint: const Text(
                          'Select',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 17,
                            color: Colors.black,
                          ),
                        ),
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.black,
                        ),
                        onChanged: (_) {},
                        items: ageList.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ),
          ],),
        ),
      ),)
    );
  }
}
