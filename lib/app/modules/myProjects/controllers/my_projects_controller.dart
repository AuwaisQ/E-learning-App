import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mini_guru/app/apiServices/apiServices.dart';
import 'package:mini_guru/app/modules/model/MaterialList.dart';
import 'package:mini_guru/constants.dart';
import 'package:mini_guru/others/NameIdModel.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../selectMaterials/views/select_materials_view.dart';
import 'dart:io' as Io;

class MyProjectsController extends GetxController {
  //TODO: Implement MyProjectsController
  final userId= ''.obs;
  final GlobalKey<FormState>profileFormKey= GlobalKey<FormState>();
  final price = 0.obs;
  var projectID = 0.obs;
  var isLoading= false.obs;
  var startDate = DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;
  var endDate = DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;
  var ageGroup= 0.obs;
  var sketch= ''.obs;
  var sketchBase64= ''.obs;
  late TextEditingController editingControllerTitle;
  late TextEditingController editingControllerDescription;
  var projectTitle = "".obs;
  var projectDescription = "".obs;
  var selectedAgeGroup = 1.obs;
  var materialList = <MaterialModel>[].obs;
  var filteredProductList = <MaterialModel>[].obs;
  var selectedProductList = <MaterialModel>[].obs;
  var selectedIds = <int>[].obs;
  var selectedItems = <String>[].obs;

  late TextEditingController searchController;
  var ageList = <NameIdModel>[NameIdModel(id: 1, name: '5-7'),NameIdModel(id: 2, name: '7-10'),NameIdModel(id: 3, name: '10-13')].obs;

  @override
  void onInit() async{
    super.onInit();
    final prefs = await SharedPreferences.getInstance();
    userId.value = prefs.getString('UserId')!;
    getMaterials();
    searchController = TextEditingController();
    editingControllerTitle = TextEditingController();
    editingControllerDescription = TextEditingController();
  }


  //Create Project
  void createProject()async {
    try{
      isLoading.value = true;
      var response = await ApiServices().createProject(
        userId.value,
        editingControllerTitle.text,
        editingControllerDescription.text,
        startDate.value,
        endDate.value,
        sketchBase64.value,
      );
      if(kDebugMode) {
        print(response);
      }
      if(response['status']){
        projectID.value = response['project_id'];
        Get.off(()=> SelectMaterialsView(),arguments: [projectID.value]);
        editingControllerDescription.clear();
        editingControllerTitle.clear();
        startDate.value = DateFormat('yyyy-MM-dd').format(DateTime.now());
        endDate.value = DateFormat('yyyy-MM-dd').format(DateTime.now());
        isLoading.value = false;
      }
      isLoading.value = false;
    }catch(e){
      isLoading.value = false;
      if (kDebugMode) {
        print(e);
      }
    }
  }

  // void getProjectData()async
  // {
  //   print("valid");
  //   isLoading.value = true;
  //   var response = await ApiService().getProjectData();
  //   isLoading.value = false;
  //   print("Response's there:${response['data'][0]['title']}");
  //   // String message = response['msg'];
  //   // // if (response.containsKey('status'))
  //   // // {
  //   // if (response['status'] == true)
  //   // {
  //   //   var dta=response['data'];
  //   //   return dta;
  //   // } else {
  //   //   print("some Thing Went wrong");
  //   // }
  // }

  //Get Project Image

  void getImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().pickImage(source: imageSource);
    if(pickedFile != null){
      sketch.value = pickedFile.path;
      final bytes = await Io.File(sketch.value).readAsBytes();
      sketchBase64.value = base64Encode(bytes); //Base64 Image
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

  void calculateItemDetail() {
    selectedIds.clear();
    selectedItems.clear();
    selectedProductList.clear();
    selectedProductList.value = filteredProductList.where((element) => element.isSelected).toList();
    for(var i=0; i<selectedProductList.length; i++) {
      // selectedIds.add(selectedProductList[i].id);
      selectedItems.add(selectedProductList[i].name);
    }
    print("Work Now${selectedIds.length}");
    Get.back();
  }

  filterNow(String value) {
    print("SearchingString is here:$value");
    if(searchController.text.isEmpty) {
      filteredProductList.value=materialList;
    } else {
      var cnvVal=value.toLowerCase();
      filteredProductList.value=materialList;
      filteredProductList.value=materialList.where((element) => element.name.toLowerCase().contains(cnvVal)).toList();
    }
    print("SearchingString is here:${filteredProductList.length}");
  }

  void getMaterials() async {
    var response = await ApiServices().materialList();
    print("material response is here:-$response");
    materialList.value = getMaterialModelFromJson(jsonEncode(response['data']));
    filteredProductList.value = getMaterialModelFromJson(jsonEncode(response['data']));
  }

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
    startDate.value = DateFormat('dd-MM-yyyy').format(pickedDate!);
  }

  Color generateRandomColor() {
    // Define all colors you want here
    const predefinedColors = [
      primaryColor,
      secondaryColor,
      redColor,
      greenColor,
    ];
    Random random = Random();
    return predefinedColors[random.nextInt(predefinedColors.length)];
  }

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

  // getAge()async
  // {
  //   final prefs = await SharedPreferences.getInstance();
  //   dateOfBirth.value = prefs.getString('dateOfBirth');
  //   Fluttertoast.showToast(msg: "Age is:${dateOfBirth.value}");
  //   DateTime tempDate = DateFormat("dd/MM/yyyy").parse(dateOfBirth.value);
  //   DateTime today = DateTime.parse("2022-10-10");
  //
  //   var age = today.year-tempDate.year;//today.getFullYear() - tempDate.getFullYear();
  //   Fluttertoast.showToast(msg: "Age is:${age}");
  //   // var m = today.getMonth() - birthDate.getMonth();
  //   // if (m < 0 || (m === 0 && today.getDate() < birthDate.getDate()))
  //   // {
  //   // age--;
  //   // }
  //   //return age;
  // }
}
