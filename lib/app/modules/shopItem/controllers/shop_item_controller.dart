import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:mini_guru/app/modules/cart/controllers/cart_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../constants.dart';
import '../../../apiServices/apiServices.dart';

class ShopItemController extends GetxController {
  CartController cartController = Get.put(CartController());

  final count = 0.obs;
  var productArgs = Get.arguments;//Coming From Shop View
  var isLoading = false.obs;
  var userId = ''.obs;
  var heroTag = ''.obs;
  var userName = ''.obs;
  var price = 2000.obs;
  var quantity = 0.obs;
  var cartId = 0.obs;
  var id = 0.obs;
  var currentDate = DateFormat("yyyy-MM-dd").format(DateTime.now()).obs;
  var currentTime = DateFormat("HH:mm:ss").format(DateTime.now()).obs;

  @override
  void onInit() async {
    final prefs = await SharedPreferences.getInstance();
    userId.value = prefs.getString('UserId')!;
    userName.value = prefs.getString('userName')!;
    super.onInit();
  }

  //Add Item to Cart
  void addItemGetId() async{
    isLoading.value = true;
    var response = await ApiServices().addToCartAndGetId(
        userId.value,
        productArgs[0],
        quantity.value,
        currentDate.value,
        currentTime.value
    );
    if (kDebugMode) {print(response);}
    if(response['status']){
      Get.dialog(
        barrierDismissible: false,
        AlertDialog(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          content: Stack(
            children: [
              Padding(
                padding:
                const EdgeInsets.only(top: 75, left: 10),
                child: Container(
                  height: 200,
                  width: 270,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white.withOpacity(0.9),
                  ),
                  child: Column(
                    mainAxisAlignment:
                    MainAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(
                            top: 55, left: 20),
                        child: Text(
                          'Item Added Successfully 👍🏻',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 30,
                        ),
                        child: InkWell(
                          onTap: () {
                            Get.back();
                            Get.back();
                          },
                          child: Container(
                            height: 45,
                            width: 200,
                            decoration: BoxDecoration(
                              color: secondaryColor,
                              borderRadius:
                              BorderRadius.circular(100),
                            ),
                            child: const Center(
                              child: Text(
                                'Done',
                                style: buttonTitleStyle,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              //Logo
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset('lottieFiles/submitted.json',
                      height: 150,
                      width: 150,
                      fit: BoxFit.cover),
                ],
              ),
            ],
          ),
        ),
      );
      cartController.getCartItems();
      isLoading.value = false;
    }else{
      Get.snackbar(
          'Cart Error',
          'Item Already in cart',
          backgroundColor: redColor,
          snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white
      );
    }
    isLoading.value = false;
  }



}
