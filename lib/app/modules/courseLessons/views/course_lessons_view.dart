// ignore_for_file: avoid_types_as_parameter_names

import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mini_guru/others/progressHud.dart';
import 'package:video_viewer/video_viewer.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../../../constants.dart';
import '../controllers/course_lessons_controller.dart';

class CourseLessonsView extends GetView<CourseLessonsController> {
  CourseLessonsController courseController = Get.put(CourseLessonsController());

  CourseLessonsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return DelayedDisplay(
        delay: const Duration(milliseconds: 500),
          child: ProgressHud(buildUi(context), courseController.isLoading.value));
    });
  }

  Widget buildUi(BuildContext context) {
    const String demoImage = 'https://t3.ftcdn.net/jpg/02/22/85/16/360_F_222851624_jfoMGbJxwRi5AWGdPgXKSABMnzCQo9RN.jpg';
    final size = MediaQuery.of(context).size;

    //----App Bar----
    final appBar = SizedBox(
      height: size.width * 0.13,
      child: Stack(
        children: [
          Center(
              child: Text(
                courseController.title.value,
                style: titleStyle,
              )),
          //Back Button
          Align(
            alignment: Alignment.centerLeft,
            child: InkWell(
              onTap: (){
                Get.back();
              },
              child: Container(
                height: size.width * 0.12,
                width: size.width * 0.12,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(150),
                    border: Border.all(color: Colors.grey)),
                child: const Center(
                  child: Icon(Icons.arrow_back_ios_new),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    //----Add Comment Button----
    final addComment = SizedBox(
      height: size.width * 0.15,
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.only(left: size.width * 0.05),
        child: Row(
          children: [
            //----Comments Field----
            Expanded(
              flex: 5,
              child: SizedBox(
                  height: size.width * 0.13,
                  child: CupertinoTextField(
                    controller: courseController.commentTextEditingController,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    placeholder: 'Enter Comment',
                  )),
            ),
            SizedBox(width: size.width * 0.01),
            InkWell(
              onTap: () => courseController.addComment(),
              child: const CircleAvatar(
                backgroundColor: primaryColor,
                radius: 25,
                child: Center(
                  child: Icon(
                    CupertinoIcons.arrow_right_circle,
                    color: Colors.white,
                    size: 45,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );

    return RefreshIndicator(
      onRefresh: () async {
        courseController.getComments();
        // courseController.getLikes();
      },
      child: Scaffold(
        // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        // floatingActionButton: courseController.showComment.value == true
        //     ? EnterAnimation(addComment)
        //     : FloatingActionButton(
        //   onPressed: () {
        //     courseController.showComment.value = true;
        //     if (kDebugMode) {print(courseController.showComment.value);}
        //   },
        //   backgroundColor: primaryColor,
        //   child: const Icon(
        //     Icons.mode_edit_outline_outlined,
        //     size: 35,
        //     color: Colors.white,
        //   ),
        // ),
        body: SafeArea(
          child: YoutubePlayerBuilder(
            player: YoutubePlayer(controller: courseController.controller,),
            // ignore: non_constant_identifier_names
            builder: (BuildContext, Widget ) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    appBar,
                    const SizedBox(height: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: YoutubePlayer(
                        thumbnail: Image.asset('images/background.png'),
                        controller: courseController.controller,
                        showVideoProgressIndicator: true,
                        onReady: () {
                          print('Player is ready.');
                          // courseController.likeTypes();
                          // courseController.getComments();
                          // courseController.getLikes();
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: SingleChildScrollView(child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Title",),
                          Text(courseController.data[1].toString(),style: headline),
                          const SizedBox(height: 10),
                          const Text("Description"),
                        Text(courseController.data[2].toString(),style: headline,),
                      ],)),
                    ),


                    // Padding(
                    //   padding: const EdgeInsets.symmetric(vertical: 10),
                    //   child: Text(
                    //     controller.description.value, style: subTitle,),
                    // ),
                    // SizedBox(
                    //   height: size.width * 0.001,
                    // ),
                    // //Like Row
                    // Wrap(
                    //   spacing: 20,
                    //   children: List.generate(
                    //       controller.likes.length, (index) =>
                    //       Badge(
                    //         alignment: AlignmentDirectional.topEnd,
                    //         textStyle: const TextStyle(
                    //             fontWeight: FontWeight.bold,
                    //             fontSize: 11),
                    //         label: Text(controller.likeType[index].count.toString()),
                    //         child: InkWell(
                    //           onTap: () {
                    //             controller.updateLikes(controller.likeType[index].likeTypeId.toString());
                    //           },
                    //           child: Chip(
                    //             padding: const EdgeInsets.all(0),
                    //             backgroundColor: primaryColor,
                    //             label: Text(
                    //                 controller.likes[index].likeType,
                    //                 style: const TextStyle(
                    //                     color: Colors.white,
                    //                     fontSize: 15,
                    //                     letterSpacing: 1.2,
                    //                     fontWeight: FontWeight.bold)),
                    //           ),
                    //         ),
                    //       )),),
                    // SizedBox(height: size.width * 0.001),
                    // const Divider(thickness: 1,),
                    // //Comment Text
                    // Align(
                    //   alignment: Alignment.centerLeft,
                    //   child: Text(
                    //     controller.commentList.isEmpty
                    //         ? 'Add Comment'
                    //         : 'Comment\'s',
                    //     style: titleStyle,
                    //   ),
                    // ),
                    // SizedBox(height: size.width * 0.03),
                    // //Comment List
                    // Column(children: List.generate(
                    //     controller.commentList.length,
                    //         (index) =>
                    //         Padding(
                    //           padding: const EdgeInsets.only(bottom: 10),
                    //           child: Column(
                    //             children: [
                    //               Row(
                    //                 mainAxisAlignment:
                    //                 MainAxisAlignment.start,
                    //                 children: [
                    //                   Expanded(
                    //                     flex: 1,
                    //                     child: CircleAvatar(
                    //                       backgroundColor: courseController.generateRandomColor(),
                    //                       radius: 20,
                    //                       child: Text(
                    //                         controller.commentList[index]
                    //                             .name[0].toUpperCase(),
                    //                         style: const TextStyle(
                    //                             fontSize: 20,
                    //                             color: Colors.white,
                    //                             fontWeight: FontWeight
                    //                                 .bold),
                    //                       ),
                    //                     ),
                    //                   ),
                    //                   SizedBox(
                    //                     width: size.width * 0.02,
                    //                   ),
                    //                   Expanded(
                    //                     flex: 6,
                    //                     child: Column(
                    //                       crossAxisAlignment:
                    //                       CrossAxisAlignment.start,
                    //                       children: [
                    //                         Text(
                    //                           controller
                    //                               .commentList[index]
                    //                               .name,
                    //                           style: headline1,
                    //                         ),
                    //                         Text(
                    //                           controller
                    //                               .commentList[index]
                    //                               .comment,
                    //                           style: subTitle,
                    //                         ),
                    //                       ],
                    //                     ),
                    //                   )
                    //                 ],
                    //               ),
                    //               const Divider(),
                    //             ],
                    //           ),
                    //         )),)
                  ],
                ),
              );
            },),
        ),
      ),
    );
  }
}
