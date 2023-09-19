import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:mini_guru/app/apiServices/apiServices.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/report_model.dart';

class ProgressReportController extends GetxController {

  var userId = "".obs;
  var projectId = "1".obs;
  var isLoading=false.obs;
  var likeDataList = <Map<String,dynamic>>[].obs;
  var projectTitle = "".obs;
  var likeNameList = <String>['Aesthetic','Unique','Creative','Study','Interactive','Aesthetic','Unique','Creative','Study','Interactive'].obs;
  var likeData = <LikeTypeList>[].obs;
  var totalProject = 0.obs;
  var completeProject = 0.obs;

  @override
  void onInit() async{
    final prefs = await SharedPreferences.getInstance();
    userId.value = prefs.getString('UserId')!;
    getLikes();
    super.onInit();
  }


  //----Get-Like-Data----
  getLikes() async {
    isLoading.value = true;
    var response = await ApiServices().getLikeTypeList(userId.value);
    if (kDebugMode) {print(response);}
    if(response['status']){
      likeData.value = likeTypeListFromJson(jsonEncode(response['data']));
        for (var i = 0; i < likeData.length; i++) {
          likeDataList.add({
            "domain" : likeData[i].materialName,
            "measure" : likeData[i].count
          }
        );
      }
      isLoading.value = false;
    }
  }
}
