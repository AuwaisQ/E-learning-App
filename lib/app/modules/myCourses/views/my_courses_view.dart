import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mini_guru/app/modules/notification/views/notification_view.dart';
import '../../../../constants.dart';
import '../controllers/my_courses_controller.dart';

class MyCoursesView extends GetView<MyCoursesController> {
  MyCoursesController myCoursesController = Get.put(MyCoursesController());

  MyCoursesView({super.key});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    Widget likeButton(String text){
      return Container(
        height: size.width / 11,
        width: size.width / 11,
        decoration: BoxDecoration(
            color: secondaryColor,
            borderRadius: BorderRadius.circular(100),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 5),
                color: Colors.grey.withOpacity(0.4),
                blurRadius: 4,
              ),
            ]
        ),
        child: Center(child: Text(text,style: headline1,)),
      );
    }
    final ageUnselected = InkWell(
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      onTap: () {
        myCoursesController.isAgeSwitcher.value = true;
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
        myCoursesController.isAgeSwitcher.value = false;
      },
      child: Image.asset(
        'images/ageYellowSelected.png',
        height: size.width / 3,
        width: size.width / 5,
      ),
    );
    final topicUnselected = InkWell(
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      onTap: () {
        myCoursesController.isTopicSwitcher.value = true;
      },
      child: Image.asset(
        'images/topicUnselected.png',
        height: size.width / 3,
        width: size.width / 5,
      ),
    );
    final topicSelected = InkWell(
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      onTap: () {
        myCoursesController.isTopicSwitcher.value = false;
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
        myCoursesController.isCitySwitcher.value = true;
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
        myCoursesController.isCitySwitcher.value = false;
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
        myCoursesController.isCommentsSwitcher.value = true;
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
        myCoursesController.isCommentsSwitcher.value = false;
      },
      child: Image.asset(
        'images/commentsYellowSelected.png',
        height: size.width / 3,
        width: size.width / 5,
      ),
    );
    final appBar = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('My Courses 🗃️', style: titleStyle),
          ],
        ),
        InkWell(
          onTap: ()=> Get.to(const NotificationView(),transition: Transition.rightToLeft),
          child: Container(
            height: size.width * 0.15,
            width: size.width * 0.15,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: Colors.grey),
            ),
            child: const Center(child: FaIcon(FontAwesomeIcons.bell),),
          ),
        ),
      ],
    );

    return Scaffold(
        body: SafeArea(child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: EnterAnimation(SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  appBar,
                  SizedBox(height: size.width * 0.1,),
                  Obx(() {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        myCoursesController.isAgeSwitcher.value == true ? ageSelected : ageUnselected,
                        myCoursesController.isTopicSwitcher.value == true ? topicSelected : topicUnselected,
                        myCoursesController.isCitySwitcher.value == true ? citySelected : cityUnselected,
                        myCoursesController.isCommentsSwitcher.value == true ? commentsSelected : commentsUnselected,
                      ],
                    );
                  }),
                  SizedBox(height: size.width * 0.05),
                  //Video Description Widget
                  Container(
                    padding: const EdgeInsets.all(10),
                    height: size.width/2.2,
                    width: size.width,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Introduction & Basics',style: headline1,),
                                Text('Advance web \nApplications.',style: subTitle,),
                              ],
                            ),
                            Row(
                              children: [
                                likeButton('A'),
                                SizedBox(
                                  width: size.width / 60,
                                ),
                                likeButton('U'),
                                SizedBox(
                                  width: size.width / 60,
                                ),
                                likeButton('M'),
                                SizedBox(
                                  width: size.width / 60,
                                ),
                                likeButton('S'),
                                SizedBox(
                                  width: size.width / 60,
                                ),
                                likeButton('T'),
                              ],)
                          ],),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //Video Widget
                            Container(
                              height: size.width/3.5,
                              width: size.width/ 3,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(20),
                                image: const DecorationImage(
                                    image: NetworkImage('https://bsmedia.business-standard.com/_media/bs/img/article/2021-01/21/full/1611251685-5188.jpg'),
                                    fit: BoxFit.cover
                                ),
                              ),
                              child: Center(child: Icon(Icons.play_circle_filled_rounded,color: Colors.white.withOpacity(0.7),size: 45,),),
                            ),
                            //Delete Button
                            Container(
                              height: size.width/11,
                              width: size.width/3,
                              decoration: BoxDecoration(
                                  color: secondaryColor,
                                  borderRadius: BorderRadius.circular(100),
                                  boxShadow: [
                                    BoxShadow(
                                      offset: const Offset(0, 5),
                                      color: Colors.grey.withOpacity(0.4),
                                      blurRadius: 4,
                                    ),
                                  ]
                              ),
                              child: const Center(child: Text('Delete🗑️',style: headline1,),),
                            ),
                          ],),
                      ],),
                  ),
                  SizedBox(height: size.width * 0.05),
                  //Video Description Widget
                  Container(
                    padding: const EdgeInsets.all(10),
                    height: size.width/2.2,
                    width: size.width,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Introduction & Basics',style: headline1,),
                                Text('Advance web \nApplications.',style: subTitle,),
                              ],
                            ),
                            Row(
                              children: [
                                likeButton('A'),
                                SizedBox(
                                  width: size.width / 60,
                                ),
                                likeButton('U'),
                                SizedBox(
                                  width: size.width / 60,
                                ),
                                likeButton('M'),
                                SizedBox(
                                  width: size.width / 60,
                                ),
                                likeButton('S'),
                                SizedBox(
                                  width: size.width / 60,
                                ),
                                likeButton('T'),
                              ],)
                          ],),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //Video Widget
                            Container(
                              height: size.width/3.5,
                              width: size.width/ 3,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(20),
                                image: const DecorationImage(
                                    image: NetworkImage('https://bsmedia.business-standard.com/_media/bs/img/article/2021-01/21/full/1611251685-5188.jpg'),
                                    fit: BoxFit.cover
                                ),
                              ),
                              child: Center(child: Icon(Icons.play_circle_filled_rounded,color: Colors.white.withOpacity(0.7),size: 45,),),
                            ),
                            //Delete Button
                            Container(
                              height: size.width/11,
                              width: size.width/3,
                              decoration: BoxDecoration(
                                  color: secondaryColor,
                                  borderRadius: BorderRadius.circular(100),
                                  boxShadow: [
                                    BoxShadow(
                                      offset: const Offset(0, 5),
                                      color: Colors.grey.withOpacity(0.4),
                                      blurRadius: 4,
                                    ),
                                  ]
                              ),
                              child: const Center(child: Text('Delete🗑️',style: headline1,),),
                            ),
                          ],),
                      ],),
                  ),
                  SizedBox(height: size.width * 0.05),
                  //Video Description Widget
                  Container(
                    padding: const EdgeInsets.all(10),
                    height: size.width/2.2,
                    width: size.width,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Introduction & Basics',style: headline1,),
                                Text('Advance web \nApplications.',style: subTitle,),
                              ],
                            ),
                            Row(
                              children: [
                                likeButton('A'),
                                SizedBox(
                                  width: size.width / 60,
                                ),
                                likeButton('U'),
                                SizedBox(
                                  width: size.width / 60,
                                ),
                                likeButton('M'),
                                SizedBox(
                                  width: size.width / 60,
                                ),
                                likeButton('S'),
                                SizedBox(
                                  width: size.width / 60,
                                ),
                                likeButton('T'),
                              ],)
                          ],),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //Video Widget
                            Container(
                              height: size.width/3.5,
                              width: size.width/ 3,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(20),
                                image: const DecorationImage(
                                    image: NetworkImage('https://bsmedia.business-standard.com/_media/bs/img/article/2021-01/21/full/1611251685-5188.jpg'),
                                    fit: BoxFit.cover
                                ),
                              ),
                              child: Center(child: Icon(Icons.play_circle_filled_rounded,color: Colors.white.withOpacity(0.7),size: 45,),),
                            ),
                            //Delete Button
                            Container(
                              height: size.width/11,
                              width: size.width/3,
                              decoration: BoxDecoration(
                                  color: secondaryColor,
                                  borderRadius: BorderRadius.circular(100),
                                  boxShadow: [
                                    BoxShadow(
                                      offset: const Offset(0, 5),
                                      color: Colors.grey.withOpacity(0.4),
                                      blurRadius: 4,
                                    ),
                                  ]
                              ),
                              child: const Center(child: Text('Delete🗑️',style: headline1,),),
                            ),
                          ],),
                      ],),
                  ),
                  SizedBox(height: size.width * 0.05),
                  //Video Description Widget
                  Container(
                    padding: const EdgeInsets.all(10),
                    height: size.width/2.2,
                    width: size.width,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Introduction & Basics',style: headline1,),
                                Text('Advance web \nApplications.',style: subTitle,),
                              ],
                            ),
                            Row(
                              children: [
                                likeButton('A'),
                                SizedBox(
                                  width: size.width / 60,
                                ),
                                likeButton('U'),
                                SizedBox(
                                  width: size.width / 60,
                                ),
                                likeButton('M'),
                                SizedBox(
                                  width: size.width / 60,
                                ),
                                likeButton('S'),
                                SizedBox(
                                  width: size.width / 60,
                                ),
                                likeButton('T'),
                              ],)
                          ],),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //Video Widget
                            Container(
                              height: size.width/3.5,
                              width: size.width/ 3,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(20),
                                image: const DecorationImage(
                                    image: NetworkImage('https://bsmedia.business-standard.com/_media/bs/img/article/2021-01/21/full/1611251685-5188.jpg'),
                                    fit: BoxFit.cover
                                ),
                              ),
                              child: Center(child: Icon(Icons.play_circle_filled_rounded,color: Colors.white.withOpacity(0.7),size: 45,),),
                            ),
                            //Delete Button
                            Container(
                              height: size.width/11,
                              width: size.width/3,
                              decoration: BoxDecoration(
                                  color: secondaryColor,
                                  borderRadius: BorderRadius.circular(100),
                                  boxShadow: [
                                    BoxShadow(
                                      offset: const Offset(0, 5),
                                      color: Colors.grey.withOpacity(0.4),
                                      blurRadius: 4,
                                    ),
                                  ]
                              ),
                              child: const Center(child: Text('Delete🗑️',style: headline1,),),
                            ),
                          ],),
                      ],),
                  ),
                ],),
            ),
          ),
        ),)
    );
  }
}
