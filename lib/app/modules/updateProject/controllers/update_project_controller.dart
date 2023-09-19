import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:mini_guru/app/modules/projectList/controllers/project_list_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../constants.dart';
import '../../../apiServices/apiServices.dart';

class UpdateProjectController extends GetxController {
  ProjectListController projectListController = Get.put(ProjectListController());

  var isLoading = false.obs;
  final GlobalKey<FormState> profileFormKey = GlobalKey<FormState>();
  var startDate = DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;
  var endDate = DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;
  var ageGroup= 0.obs;
  var sketch= ''.obs;
  var userId = ''.obs;
  late File videoPicked;
  dynamic data;
  late TextEditingController editingControllerTitle = TextEditingController();
  late TextEditingController editingControllerDescription= TextEditingController();

  @override
  void onInit() async{
    editingControllerTitle = TextEditingController();
    editingControllerDescription = TextEditingController();
    data = Get.arguments;
    debugPrint('Project ID- ${data[0]}');
    debugPrint('Project Title- ${data[1]}');
    debugPrint('Project Description- ${data[2]}');
    debugPrint('Project Image- ${data[3]}');
    debugPrint('Project Start Date- ${data[4]}');
    debugPrint('Project End Date- ${data[5]}');
    final prefs = await SharedPreferences.getInstance();
    userId.value = prefs.getString('UserId')!;
    print(userId.value);
    super.onInit();
  }


  @override
  void onClose() {
    editingControllerDescription.dispose();
    editingControllerTitle.dispose();
    super.onClose();
  }

  //Get Image
  void getImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().pickImage(source: imageSource);
    if(pickedFile != null){
      sketch.value = pickedFile.path;
    } else {
      Get.snackbar(
        'Error',
        'No Image Selected',
        margin: const EdgeInsets.all(20),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: redColor,
        colorText: Colors.white,
      );
    }
  }

  //Select Start Date
  selectStartDate() async {
    print("Date Picker Called");
    DateTime? pickedDate = await showDatePicker(context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 90)),
      currentDate: null,
      initialEntryMode: DatePickerEntryMode.calendar,
      builder: (context,child){
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: primaryColor, // <-- SEE HERE
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: primaryColor, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    startDate.value = DateFormat('yyyy-MM-dd').format(pickedDate!);
  }

  //Select End Date
  selectEndDate() async {
    print("Date Picker Called");
    DateTime? pickedDate = await showDatePicker(context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 90)),
      currentDate: null,
      initialEntryMode: DatePickerEntryMode.calendar,
      builder: (context,child){
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: primaryColor, // <-- SEE HERE
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: primaryColor, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    endDate.value = DateFormat('yyyy-MM-dd').format(pickedDate!);
  }

  //Update Project
  void updateProject(String projectID)async {
    isLoading.value = true;
    try{
      var response = await ApiServices().updateProject(
        projectID,
        editingControllerTitle.text.isEmpty ? data[1] : editingControllerTitle.text,
        startDate.value == DateFormat('yyyy-MM-dd').format(DateTime.now()) ? DateFormat('yyyy-MM-dd').format(data[4]) : startDate.value,
        endDate.value == DateFormat('yyyy-MM-dd').format(DateTime.now()) ? DateFormat('yyyy-MM-dd').format(data[5]) : endDate.value,
        editingControllerDescription.text.isEmpty ? data[2] : editingControllerDescription.text,
        sketch.value
      );
      if(response['status']) {
        projectListController.getOngoingProjectList();
        print('Update Project Response - $response');
        isLoading.value = false;
        editingControllerDescription.clear();
        editingControllerTitle.clear();
        sketch.value = '';
        endDate.value = '';
        startDate.value = '';
        Get.back();
      }else{
        isLoading.value = false;
        Get.snackbar(
          'Error',
          'No Image Selected',
          duration: const Duration(milliseconds: 100),
          margin: const EdgeInsets.all(20),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: redColor,
          colorText: Colors.white,
        );
      }
    }catch(e){
      isLoading.value = false;
      Get.snackbar(
        'Error',
        'No Image Selected',
        duration: const Duration(milliseconds: 100),
        margin: const EdgeInsets.all(20),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: redColor,
        colorText: Colors.white,
      );
      print(e);
    }
  }

  uploadVideo(String projectId)async{
    isLoading.value = true;
    if(kDebugMode){print(videoPicked);}
    try{
      var response = await ApiServices().videoUpload(
          userId.value,
          projectId,
          videoPicked
      );
      if(true){
        isLoading.value = false;
        Get.dialog(
          barrierDismissible: false,
          Center(
            child: Lottie.asset('lottieFiles/videoUploaded.json',
                height: 300, width: 300, fit: BoxFit.cover),
          ),
        );
        Future.delayed(const Duration(milliseconds: 2100), () {
          Get.back();
          Get.back();
        });
      }
    }catch(e){
      isLoading.value = false;
      Get.snackbar(
        'Error',
        'Internet Error Please Try Again',
        margin: const EdgeInsets.all(20),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print("Video API Error - $e");
    }
  }

  //Profile Image Picker
  void pickVideo(String projectId) async {
    final pickedFile = await ImagePicker().pickVideo(source: ImageSource.gallery);
    if(pickedFile != null){
      videoPicked = File(pickedFile.path);
      print(userId.value);
      print(projectId);
      uploadVideo(projectId);
    } else {
      Get.snackbar(
        'Error',
        'No Video Selected',
        margin: const EdgeInsets.all(20),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

}
