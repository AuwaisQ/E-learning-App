
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mini_guru/app/modules/cart/model/cart_model.dart';
import 'package:mini_guru/app/modules/model/CartModel.dart';
import 'package:mini_guru/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../apiServices/apiServices.dart';


class CartController extends GetxController {

  var productList = <CartModel>[].obs;
  var cartProductList = <CartListModel>[].obs;
  var searchProd = <CartModel>[].obs;
  List<Map<String, dynamic>> orderDetails = [];
  var cartValue = 0.obs;
  var walletBal = 1000.obs;
  var userId = ''.obs;
  var cartId = 0.obs;
  var isLoading = false.obs;
  var amount = ''.obs;
  late TextEditingController walletBalance = TextEditingController();
  final GlobalKey<FormState> walletKey = GlobalKey<FormState>();

  @override
  void onInit() async{
    final prefs = await SharedPreferences.getInstance();
    userId.value = prefs.getString('UserId')!;
    super.onInit();
  }

  void getCartItems()async{
    isLoading.value = true;
    final prefs = await SharedPreferences.getInstance();
    var response = await ApiServices().getCartItems(int.parse(userId.value));
    if(response['status']){
      if (kDebugMode) {print('Cart Items List- ${response['cartlist']}');}
      productList.value = cartModelFromJson(jsonEncode(response['cartlist']));

      isLoading.value = false;
    }
  }

  void deleteItem(int productId)async{
    isLoading.value = true;
    var response = await ApiServices().deleteItem(
        int.parse(userId.value),
        productId
    );
    if(response['status']){
      if (kDebugMode) {print(response);}
      getCartItems();
    }
    isLoading.value = false;
  }

  //Delete Cart Items
  void decreaseQuantity(int productId)async{
    isLoading.value = true;
    var response = await ApiServices().decreaseQuantity(
        int.parse(userId.value),
        productId
    );
    if(response['status']){
      if (kDebugMode) {print(response);}
      getCartItems();
      Fluttertoast.showToast(
          msg: "Removed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
    isLoading.value = false;
  }

  //Delete Cart Items
  void increaseQuantity(int productId)async{
    isLoading.value = true;
    var response = await ApiServices().increaseQuantity(
        int.parse(userId.value),
        productId
    );
    if(response['status']){
      if (kDebugMode) {print(response);}
      getCartItems();
      Fluttertoast.showToast(
          msg: "Added",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
    isLoading.value = false;
  }

  //Payment Dialog
  showAlertDialog(String title, String content) {
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Get.back();
        walletBalance.clear();
      },
    );
    Get.defaultDialog(
      title: title,
      actions: [okButton],
      content: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Text(content),
      ),
    );
  }

  //Item Delete Dialog
  showConfirmDialog(BuildContext context,int index) {
    Widget cancelButton = ElevatedButton(
      style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(secondaryColor),),
      child: Text("Cancel".tr,style: const TextStyle(fontFamily: "Varela",color: Colors.white),),
      onPressed: () {
        Get.back();
      },
    );
    Widget deleteButton =  ElevatedButton(
      style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(primaryColor),),
      child: Text("Delete".tr,style: const TextStyle(fontFamily: "Varela",color: Colors.white)),
      onPressed:() {
          Get.back();
          deleteItem(productList[index].productId);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Delete Item".tr,style: const TextStyle(fontFamily: "Varela")),
      elevation: 5.0,
      content: Text("Are you sure to delete this?".tr,style: const TextStyle(fontFamily: "Varela")),
      actions: [
        cancelButton,
        deleteButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  setCartValue() {
    cartValue.value = productList.fold(0, (sum, item) => sum + (int.parse(item.quantity) * int.parse(item.price)));
  }

  @override
  void dispose() {
    walletBalance.dispose();
    super.dispose();
  }
}
