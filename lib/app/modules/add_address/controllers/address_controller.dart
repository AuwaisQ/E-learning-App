import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mini_guru/app/modules/display_address/controllers/display_address_controller.dart';
import 'package:mini_guru/others/NameIdModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../apiServices/apiServices.dart';
import '../model/addressModel.dart';

class AddressController extends GetxController {
  DisplayAddressController displayAddressController = Get.put(DisplayAddressController());

  var isApiLoading = false.obs;
  var userId = ''.obs;
  var stateList = <NameIdModel>[].obs;
  var cityList = <CityIdModel>[].obs;
  var stateId ='1'.obs;
  var cityId = '0'.obs;
  var addressType="Home".obs;
  final GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();
  late TextEditingController addressController;
  String address="";

  @override
  void onInit() async {
    addressController = TextEditingController();
    final prefs = await SharedPreferences.getInstance();
    userId.value = prefs.getString('UserId')!;
    getStateList();
    super.onInit();
  }

  @override
  void onClose(){
    addressController.dispose();
    super.onClose();
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

  addAddress()async{
    isApiLoading.value = true;
    var response = await ApiServices().addAddress(
      userId.value,
      addressController.text,
      stateId.value,
      cityId.value,
      addressType.value
    );
    try{
      print(response);
      if(response['status']){
        Get.back();
        stateId.value = '1';
        cityId.value = cityList[0].id.toString();
        addressController.clear();
        displayAddressController.getAddress();
        isApiLoading.value = false;
      }
    }catch(e){
      print(e);
    }
    isApiLoading.value = false;
  }

  //Select Office & Home
  onChangeAddressType(var type) {
    print(type);
    addressType.value=type;
  }
}
