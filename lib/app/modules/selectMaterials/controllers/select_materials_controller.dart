import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mini_guru/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../apiServices/apiServices.dart';

class SelectMaterialsController extends GetxController {
  //TODO: Implement SelectMaterialsController

  var goinCount = ''.obs;
  var isLoading = false.obs;
  var userId = ''.obs;
  var totalValue = 0.obs;

  @override
  void onInit() async{
    final prefs = await SharedPreferences.getInstance();
    userId.value = prefs.getString('UserId')!;
    getGoinData();
    super.onInit();
  }



  //Get GoinData
  void getGoinData() async{
    isLoading.value = true;
    var response = await ApiServices().getGoins(userId.value);
    if(response['status']){
      print('GoinData- ${response['data']}');
      goinCount.value = response['data'].toString();
      isLoading.value = false;
    }else{
      goinCount.value = '0';
    }
    isLoading.value = false;
  }


  //Add Project Material
  void addProjectMaterial(String projectId, String materialId) async{
    isLoading.value = true;
    var response = await ApiServices().addProjectMaterial(
      projectId,
      materialId
    );
    if(response['status']){
      Fluttertoast.showToast(
          msg: "Added",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: greenColor,
          textColor: Colors.white,
          fontSize: 20.0
      );
    }else{
      goinCount.value = '0';
    }
    isLoading.value = false;
  }


  //Delete Project Material
  void deleteProjectMaterial(String projectId, String materialId) async{
    isLoading.value = true;
    var response = await ApiServices().deleteProjectMaterial(
        projectId,
        materialId
    );
    if(response['status']){
      Fluttertoast.showToast(
          msg: "Item Deleted",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: redColor,
          textColor: Colors.white,
          fontSize: 20.0,
      );
    }else{
      goinCount.value = '0';
    }
    isLoading.value = false;
  }
}
