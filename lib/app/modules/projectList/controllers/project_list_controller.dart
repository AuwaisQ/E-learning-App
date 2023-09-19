import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:mini_guru/app/apiServices/apiServices.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/MyProjectListModel.dart';

class ProjectListController extends GetxController {
  //TODO: Implement ProjectListController

  final count = 0.obs;
  var isLoading = false.obs;
  var userId = ''.obs;
  late File videoPicked;
  var totalProject = 0.obs;
  var completedProjectList = <CompletedProjectList>[].obs;
  var onGoingProjectList = <OngoingProjectList>[].obs;
  late TextEditingController textEditingControllerProgress;

  @override
  void onInit() async{
    final prefs = await SharedPreferences.getInstance();
    userId.value = prefs.getString('UserId')!;
    textEditingControllerProgress = TextEditingController();
    getCompletedProjectList();
    getOngoingProjectList();
    super.onInit();
  }

  @override
  void onClose(){
    super.onClose();
    textEditingControllerProgress.clear();
  }

  getOngoingProjectList()async {
    isLoading.value = true;
    var response = await ApiServices().getOngoingProjectList(userId.value);
    if(response['status']){
      if (kDebugMode) {print(response);}
      totalProject.value = response['numofpro'];
      onGoingProjectList.value = onGoingProjectListFromJson(jsonEncode(response['data']));
      isLoading.value = false;
    }
  }

  getCompletedProjectList()async{
    isLoading.value = true;
    var response = await ApiServices().getCompletedProjectList(userId.value);
    if(response['status']){
      if (kDebugMode) {
        print(response);
      }
      completedProjectList.value = completedProjectListFromJson(jsonEncode(response['data']));
      isLoading.value = false;
    }
  }
}
