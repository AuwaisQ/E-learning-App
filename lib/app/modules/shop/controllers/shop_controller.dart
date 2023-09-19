import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_guru/app/modules/cart/controllers/cart_controller.dart';
import 'package:mini_guru/app/modules/model/ProductModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../apiServices/apiServices.dart';
import '../../model/CartModel.dart';

class ShopController extends GetxController {
  CartController cartController = Get.put(CartController());

  final count = 0.obs;
  var productList = <ProductModel>[].obs;
  var filteredProductList = <ProductModel>[].obs;
  var isLoading = false.obs;
  var userId = ''.obs;
  var userName = ''.obs;
  var selectedCategory = 1.obs;
  late final TextEditingController searchController = TextEditingController();

  @override
  void onInit() async{
    final prefs = await SharedPreferences.getInstance();
    userId.value = prefs.getString('UserId')!;
    userName.value = prefs.getString('userName')!;
    getProducts();
    getCartItems();
    super.onInit();
  }

  void getCartItems()async{
    isLoading.value = true;
    var response = await ApiServices().getCartItems(int.parse(userId.value));
    if(response['status']){
      if (kDebugMode) {print('Cart Items List- ${response['cartlist']}');}
      cartController.productList.value = cartModelFromJson(jsonEncode(response['cartlist']));
      isLoading.value = false;
    }
  }

  void getProducts() async {
    isLoading.value = true;
    var response = await ApiServices().shopItems();
    if (kDebugMode) {
      print('Shop Item Response - $response');
    }
    isLoading.value = false;
    productList.value = productModelFromJson(jsonEncode(response['data']));
    filteredProductList.value = productModelFromJson(jsonEncode(response['data']));
  }

  filterProduct() {
    filteredProductList.value = productList;
    filteredProductList.value = productList.where((element) => element.itemId.isEqual(selectedCategory.value)).toList();
    if (kDebugMode) {
      print("filter is:${filteredProductList.length}");
    }
  }

  filterNow(String value) {
    if (kDebugMode) {
      print("Search String is here:$value");
    }
    if(searchController.text.isEmpty)
      {
        filteredProductList.value = productList;
      }else
        {
          var cnvVal = value.toLowerCase();
          filteredProductList.value = productList;
          filteredProductList.value = productList.where((element) => element.productName.toLowerCase().contains(cnvVal)).toList();
        }
      if (kDebugMode) {
        print("Search String is here:${filteredProductList.length}");
      }
  }

  void increment() => count.value++;
}
