import 'dart:convert';
import 'dart:io' as Io;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mini_guru/constants.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../others/NameIdModel.dart';
import '../../../apiServices/apiServices.dart';
import '../../add_address/model/addressModel.dart';


class ProfilePageController extends GetxController {
  var currentAddress = "".obs;
  late String phoneNumber;
  var isLocationLoading = false.obs;
  final GlobalKey<FormState>profileFormKey=GlobalKey<FormState>();

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController parentNameController = TextEditingController();
  final TextEditingController schoolNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController schoolAddress = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  var studentName= ''.obs;
  var parentName= ''.obs;
  var schoolName= ''.obs;
  var mobile= ''.obs;
  var email= ''.obs;
  var gender= ''.obs;
  var genderType= "Other".obs;
  var userMobileNumber = ''.obs;
  var userId = ''.obs;
  var profilePicture= ''.obs;
  var base64Image = ''.obs;
  var isImageLoading = false.obs;
  var isApiLoading= false.obs;

  //Shared Preferences Data
  var userName = ''.obs;

  var stateList = <NameIdModel>[].obs;
  var cityList = <CityIdModel>[].obs;
  var stateId ='1'.obs;
  var cityId = '0'.obs;

  var dateOfBirth = DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;
  final count = 0.obs;
  late TextEditingController rechargeAmountController;

  @override
  void onInit() async {
    getStateList();
    final prefs = await SharedPreferences.getInstance();
    userMobileNumber.value = prefs.getString('userMobileNumber')!;
    super.onInit();
  }

  void sendUserProfile() async {
    isApiLoading.value = true;
    //Sending data from api
    final response = await ApiServices().createUserProfile(
      base64Image.value,
      fullNameController.text,
      parentNameController.text,
      addressController.text,
      stateId.value,
      cityId.value,
      userMobileNumber.value,
      genderType.value,
      emailController.text,
      schoolNameController.text,
      schoolAddress.text,
      dateOfBirth.value,
    );
    if(response['status']){
      userId.value = response['userId'].toString();//fetching response and assigning value.
      final prefs = await SharedPreferences.getInstance();
      prefs.setBool('isLogin',true);//Login True
      prefs.setString('UserId',userId.value);//storing userId into Shared Preferences
      Get.offNamed('/bottom-bar');
      isApiLoading.value = false;
    }else{
      Get.snackbar(
        'Error',
        'Something Went Wrong PLease Try Again',
        margin: const EdgeInsets.all(20),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  //Getting State List
  getStateList() async {
    isApiLoading.value = true;
    var response = await ApiServices().getStateList();
    print('State List Status - ${response['status']}\n');
    stateList.value = nameIdModelFromJson(jsonEncode(response['data']));
    isApiLoading.value = false;
  }

  //Getting City List
  getCityList(int stateId) async {
    isApiLoading.value = true;
    var response = await ApiServices().getCityList(stateId);
    print('City List Status - ${response['status']}\n');

    if (response['status'] == true) {
      cityList.value = cityIdModelFromJson(jsonEncode(response['data']));
      cityId.value = cityList[0].id.toString();
    }else{
      Fluttertoast.showToast(
          msg: "Something Went Wrong",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
    isApiLoading.value = false;
  }

  //Profile Image Picker
  getImage(ImageSource imageSource) async {
    isImageLoading.value = true;
    final pickedFile = await ImagePicker().pickImage(source: imageSource);
    if(pickedFile != null){
      profilePicture.value = pickedFile.path;
      final bytes = await Io.File(profilePicture.value).readAsBytes();
      base64Image.value = base64Encode(bytes);
    } else {
      Get.snackbar(
        'Error',
        'No Image Selected',
        margin: const EdgeInsets.all(20),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
    isImageLoading.value = false;
  }

  //Gender
  setGender(var type) {
    gender.value=type;
    genderType.value=type;
    print(gender.value);
  }

  //DOB
  selectDateOfBirth() async {
    print("Date Picker Called");
    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(1000),
      lastDate: DateTime.now(),
      currentDate: DateTime.now(),
      initialEntryMode: DatePickerEntryMode.calendar,
      builder: (context,child){
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: secondaryColor, // <-- SEE HERE
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(),
            ),
          ),
          child: child!,
        );
      },
    );
    dateOfBirth.value = DateFormat('yyyy-MM-dd').format(pickedDate!);
  }
}