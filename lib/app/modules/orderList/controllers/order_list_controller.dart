
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:mini_guru/app/modules/model/OrderDetailModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../apiServices/apiServices.dart';

class OrderListController extends GetxController
{
  //TODO: Implement OrderListController
  var isLoading = false.obs;
  var userId = ''.obs;
  var pendingOrderList=<PendingOrderList>[].obs;
  var completeOrderList=<PendingOrderList>[].obs;

  @override
  void onInit() async{
    super.onInit();
    final prefs = await SharedPreferences.getInstance();
    userId.value = prefs.getString('UserId')!;
    getPendingOrderList();
    // getDeliveredList();
  }

  void getPendingOrderList()async{
    isLoading.value = true;
    var response = await ApiServices().getPendingOrderList(userId.value);
    if(response['status']){
      pendingOrderList.value = PendingOrderListFromJson(jsonEncode(response['order_list']));
      if (kDebugMode) {print("PendingOrder List Length - ${pendingOrderList.length}");}
      isLoading.value = false;
    }else{
      Get.back();
      isLoading.value = false;
    }
  }


  void getDeliveredList()async{
    isLoading.value = true;
    var response = await ApiServices().getDeliveredOrderList(userId.value);
    if(response['status']){
      completeOrderList.value = PendingOrderListFromJson(jsonEncode(response['order_list']));
      if (kDebugMode) {
        print("Pending List Length- ${pendingOrderList.length}");
      }
      isLoading.value = false;
    }else{
      Get.back();
      isLoading.value = false;
    }
  }
}
