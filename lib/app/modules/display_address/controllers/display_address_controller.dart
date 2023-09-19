import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mini_guru/app/modules/display_address/model/addressModel.dart';
import 'package:mini_guru/app/modules/orderSummary/views/order_summary_view.dart';
import 'package:mini_guru/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../apiServices/apiServices.dart';


class DisplayAddressController extends GetxController
{
  //TODO: Implement AddAddressController
  var isLoading=false.obs;
  var userId= ''.obs;
  var addresses = <Address>[].obs;
  var date = DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;
  var addressType="Home".obs;
  var orderId= 0.obs;
  var selectedCityId= "".obs;
  var selectedAddressId= 0.obs;


  @override
  void onInit() async{
    final prefs = await SharedPreferences.getInstance();
    userId.value = prefs.getString('UserId')!;
    getOrderId();
    getAddress();
    super.onInit();
  }

  onChangeAddressType(var type) {
    if (kDebugMode) {print(type);}
    addressType.value=type;
  }

  setAddress(int val) {
    selectedAddressId.value = val;
  }

  void getAddress()async{
    isLoading.value = true;
    var response = await ApiServices().getAddress(userId.value);
    if(response['status']){
      if (kDebugMode) {print('Address List- $response');}
      addresses.value = addressFromJson(jsonEncode(response['addressList']));
      isLoading.value = false;
    }else{
      Get.snackbar(
          'Address Error',
          'Something went wrong please try again',
          backgroundColor: secondaryColor,
          duration: const Duration(seconds: 1),
          snackPosition: SnackPosition.TOP
      );
      isLoading.value = false;
    }
  }

  void getOrderId()async{
    isLoading.value = true;
    var response = await ApiServices().placeOrder(
        userId.value,
        date.value
    );
    if(response['status']){
      orderId.value = response['order_id'];
      if (kDebugMode) {print('OrderID - ${orderId.value}');}
    }else{
      if(kDebugMode){
        print('Order ID API Error');
      }
    }
  }

  void selectOrderAddress()async{
    isLoading.value = true;
    var response = await ApiServices().selectOrderAddress(
        selectedAddressId.value,
        orderId.value
    );
    if(response['status']){
      Get.to(()=>OrderSummaryView(), arguments: [orderId.value]);
      if (kDebugMode) {print('Address Select True');}
      isLoading.value = false;
    }
  }
}
