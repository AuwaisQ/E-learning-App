import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../../../constants.dart';
import '../controllers/notification_controller.dart';

class NotificationView extends GetView<NotificationController>
{
  const NotificationView({super.key});


  @override
  Widget build(BuildContext context)
  {
    NotificationController controller=Get.put(NotificationController());
    final size = MediaQuery
        .of(context)
        .size;
    final appBar = DelayedDisplay(
      delay: const Duration(milliseconds: 200),
      slidingBeginOffset: const Offset(0.4, 0),
      child: SizedBox(
        height: size.width / 6,
        child: Stack(
          children: [
            const Center(child: Text('Notifications', style: titleStyle,)),
            //Back Button
            Align(
              alignment: Alignment.centerLeft,
              child: InkWell(
                onTap: () => Get.back(),
                child: Container(
                  height: size.width * 0.15,
                  width: size.width * 0.15,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(150),
                      border: Border.all(color: Colors.grey)
                  ),
                  child: const Center(child: Icon(Icons.arrow_back_ios_new),),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent,elevation: 0,
        title: const Text("Notifications",style: titleStyle,),centerTitle: true,leading: 
        InkWell(
          onTap: () => Get.back(),
          child: Container(
            margin: const EdgeInsets.all(5),
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(150),
                border: Border.all(color: Colors.grey)
            ),
            child: const Center(child: Icon(Icons.arrow_back_ios_new,color: Colors.black,),),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15,),
        child: SingleChildScrollView(
          child: DelayedDisplay(
            slidingCurve: Curves.easeInOutBack,
            delay: const Duration(milliseconds: 200),
            slidingBeginOffset: const Offset(0.4, 0),
            child: Column(children: [
              SizedBox(
                height: size.width * 0.05,
              ),
              //New Courses
              Obx(() {
                return Column(children: List.generate(controller
                    .notificationList.length, (index) =>
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      padding: const EdgeInsets.all(15),
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
                              width: size.width * 0.15,
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(150),
                              ),
                              child: const Center(child: FaIcon(
                                FontAwesomeIcons.file, color: Colors.white,
                                size: 30,),),
                            ),
                          ),
                          SizedBox(width: size.width * 0.05,),
                          Column(

                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(controller.notificationList[index].title, style: titleStyle,),
                              Text(
                                controller.notificationList[index].message,
                                style: subTitle,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  const SizedBox(),
                                  Text(controller.notificationList[index].date.toString(), style: subTitle,),
                                ],
                              ),
                            ],
                          ),
                        ],),
                    )),);
              })
              // //New Achievement
              // Container(
              //   padding: const EdgeInsets.all(15),
              //   height: size.width * 0.45,
              //   width: size.width,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(15),
              //     border: Border.all(color: Colors.grey),
              //   ),
              //   child: Row(
              //     children: [
              //       Align(
              //         alignment: Alignment.topLeft,
              //         child: Container(
              //           height: size.width * 0.15,
              //           width: size.width* 0.15,
              //           decoration: BoxDecoration(
              //             color: secondaryColor,
              //             borderRadius: BorderRadius.circular(150),
              //           ),
              //           child: const Center(child: FaIcon(FontAwesomeIcons.star,color: Colors.white,size: 30,),),
              //         ),
              //       ),
              //       SizedBox(width: size.width * 0.05,),
              //       Column(
              //         mainAxisAlignment: MainAxisAlignment.spaceAround,
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: const [
              //           Text('New Achievement',style: titleStyle,),
              //           Text('We have just received 1 new\nbadge for all your work',style: subTitle,),
              //           Text('Yesterday',style: subTitle,),
              //         ],
              //       ),
              //     ],),
              // ),
              // SizedBox(
              //   height: size.width * 0.05,
              // ),
              // //Complete Purchase
              // Container(
              //   padding: const EdgeInsets.all(15),
              //   height: size.width * 0.45,
              //   width: size.width,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(15),
              //     border: Border.all(color: Colors.grey),
              //   ),
              //   child: Row(
              //     children: [
              //       Align(
              //         alignment: Alignment.topLeft,
              //         child: Container(
              //           height: size.width * 0.15,
              //           width: size.width* 0.15,
              //           decoration: BoxDecoration(
              //             color: redColor,
              //             borderRadius: BorderRadius.circular(150),
              //           ),
              //           child: const Center(child: FaIcon(FontAwesomeIcons.wallet,color: Colors.white,size: 30,),),
              //         ),
              //       ),
              //       SizedBox(width: size.width * 0.05,),
              //       Column(
              //         mainAxisAlignment: MainAxisAlignment.spaceAround,
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: const [
              //           Text('Complete Purchase',style: titleStyle,),
              //           Text('Please Complete your \npurchase now to get\na 50% discount',style: subTitle,),
              //           Text('7 days ago',style: subTitle,),
              //         ],
              //       ),
              //     ],),
              // ),
              // SizedBox(
              //   height: size.width * 0.05,
              // ),
              // //Unread Message
              // Container(
              //   padding: const EdgeInsets.all(15),
              //   height: size.width * 0.45,
              //   width: size.width,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(15),
              //     border: Border.all(color: Colors.grey),
              //   ),
              //   child: Row(
              //     children: [
              //       Align(
              //         alignment: Alignment.topLeft,
              //         child: Container(
              //           height: size.width * 0.15,
              //           width: size.width* 0.15,
              //           decoration: BoxDecoration(
              //             color: greenColor,
              //             borderRadius: BorderRadius.circular(150),
              //           ),
              //           child: const Center(child: FaIcon(FontAwesomeIcons.message,color: Colors.white,size: 30,),),
              //         ),
              //       ),
              //       SizedBox(width: size.width * 0.05,),
              //       Column(
              //         mainAxisAlignment: MainAxisAlignment.spaceAround,
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: const [
              //           Text('Complete Purchase',style: titleStyle,),
              //           Text('You have 3 unread messages\nin your mail box',style: subTitle,),
              //           Text('16 days ago',style: subTitle,),
              //         ],
              //       ),
              //     ],),
              // ),
            ],),
          ),
        ),
      ),),
    );
  }
}
