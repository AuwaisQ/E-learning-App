import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mini_guru/app/modules/progressReport/controllers/progress_report_controller.dart';
import 'package:mini_guru/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_viewer/domain/bloc/controller.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../../apiServices/apiServices.dart';
import '../model/course_lesson_model.dart';

class CourseLessonsController extends GetxController {
  ProgressReportController progressReportController = Get.put(ProgressReportController());

  var isLoading=false.obs;
  var projectId="1".obs;
  var userId= "".obs;
  var likeIndex = 0.obs;
  var commentList = <Comments>[].obs;
  var likeType = <LikeType>[].obs;
  var likes = <Likes>[].obs;
  var title="Video".obs;
  var description="This is Video Description".obs;
  var showComment= false.obs;
  var data = Get.arguments;
  late final YoutubePlayerController controller;
  late final TextEditingController commentTextEditingController = TextEditingController();

  @override
  void onInit() async{
    controller = YoutubePlayerController(
      initialVideoId: data[0],
      flags: const YoutubePlayerFlags(
        useHybridComposition: true,
        mute: false,
        autoPlay: true,
      ),
    );
    final prefs = await SharedPreferences.getInstance();
    userId.value = prefs.getString('UserId')!;
    if (kDebugMode) {print('User Id-${userId.value}');}
    super.onInit();
  }

  @override
  void onClose() {
    commentTextEditingController.dispose();
    super.onClose();
  }

  void addComment() async {
    if(commentTextEditingController.text.isEmpty) {
      Fluttertoast.showToast(msg:"Please Add Comment!",backgroundColor: Colors.red);
    } else {
      isLoading.value = true;
      var response = await ApiServices().addComment(
        userId.value,
        projectId.value,
        commentTextEditingController.text
      );
      if (kDebugMode) {
        print(response);
      }
      if(response['status']){
        isLoading.value = false;
        getComments();
        commentTextEditingController.clear();
        showComment.value = false;
      }
    }
    isLoading.value = false;
  }

  void getComments() async {
    isLoading.value = true;
    var response = await ApiServices().getComments(projectId.value);
    if (kDebugMode) {
      print('Comments Data-$response');
    }
    if(response['status']){
      commentList.value = commentsFromJson(jsonEncode(response['data']));
      isLoading.value = false;
    }
    if (kDebugMode) {
      print('API Response - $response');
    }
  }

  //Get Like Count
  // getLikes()async{
  //   isLoading.value = true;
  //   var response = await ApiServices().getLikeTypeList(
  //       userId.value,
  //       projectId.value
  //   );
  //   if (kDebugMode) {
  //     print(response);
  //   }
  //   if(response['status']){
  //     likeType.value = likeTypeFromJson(jsonEncode(response['data']));
  //     isLoading.value = false;
  //   }
  // }

  //Update Likes
  updateLikes(String likeId)async{
    isLoading.value = true;
    var response = await ApiServices().updateLikes(
        userId.value,
        projectId.value,
        likeId
    );
    if (kDebugMode) {
      print(response);
    }
    if(response['status']){
      // getLikes();
      progressReportController.getLikes();
      isLoading.value = false;
    }
  }

  //get Like Types
  likeTypes()async{
    isLoading.value = true;
    var response = await ApiServices().getLikes();
    if (kDebugMode) {
      print(response);
    }
    if(response['status']){
      likes.value = likesFromJson(jsonEncode(response['data']));
      isLoading.value = false;
    }
  }

  //---Color-Generator---
  Color generateRandomColor() {
    const predefinedColors = [
      primaryColor,
      secondaryColor,
      redColor,
      greenColor,
    ];
    Random random = Random();
    return predefinedColors[random.nextInt(predefinedColors.length)];
  }

}
