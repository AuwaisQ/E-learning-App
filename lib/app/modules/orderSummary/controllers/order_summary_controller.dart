import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mini_guru/app/modules/bottomBar/views/bottom_bar_view.dart';
import 'package:mini_guru/app/modules/cart/controllers/cart_controller.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../constants.dart';
import '../../../apiServices/apiServices.dart';

class OrderSummaryController extends GetxController {
  CartController cartController = Get.put(CartController());

  var walletBal = 0.obs;
  var userId = ''.obs;
  var userMobile = ''.obs;
  var transactionId = ''.obs;
  var isLoading = false.obs;
  var productArgs = Get.arguments;//Coming From Address View
  var amount = "".obs;
  late TextEditingController walletBalance = TextEditingController();
  final GlobalKey<FormState> walletKey = GlobalKey<FormState>();
  var razorPayAPIKey = 'rzp_test_lKn15QYwfOMEpW'.obs;
  Razorpay? razorpay;


  @override
  void onInit() async{
    final prefs = await SharedPreferences.getInstance();
    userId.value = prefs.getString('UserId')!;
    userMobile.value = prefs.getString('userMobileNumber')!;
    if (kDebugMode) {print("Order Id - ${productArgs[0]}");}
    getWalletBal();
    razorpay = Razorpay();
    razorpay!.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorpay!.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay!.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
    super.onInit();
  }

  //Wallet Balance API
  void getWalletBal() async{
    isLoading.value = true;
    try{
      var response = await ApiServices().getWalletBalance(int.parse(userId.value));
      if(response['status']){
        if (kDebugMode) {print('Wallet Balance ${response['data']}');}
        walletBal.value = response['data'];
        isLoading.value = false;
      }
    }catch(e){
      Get.back();
      if (kDebugMode) {print('Wallet API Error - $e');}
      Get.snackbar(
          'Wallet Error 👻',
          'Something went wrong please try again',
          backgroundColor: redColor,
          snackPosition: SnackPosition.TOP,
          colorText: Colors.white
      );
    }
    isLoading.value = false;
  }

  void checkOut()async{
    isLoading.value = true;
    try{
      var response = await ApiServices().checkOut(
          productArgs[0],
          cartController.cartValue.value,
          userId.value
      );
      if(response['status']){
        isLoading.value = false;
        Get.dialog(
          barrierDismissible: false,
          Center(
            child: Lottie.asset('lottieFiles/payment.json',
                height: 300, width: 300, fit: BoxFit.cover),
          ),
        );
        Future.delayed(const Duration(milliseconds: 2500), () {
          cartController.getCartItems();
          getWalletBal();
          Get.offAll(() => BottomBarView());
        });
      }
    }catch(e){
      Get.snackbar(
          'Checkout Error 👻',
          'Something went wrong please try again',
          backgroundColor: redColor,
          snackPosition: SnackPosition.TOP,
          colorText: Colors.white
      );
      isLoading.value = false;
      if (kDebugMode) {
        print('Checkout API = $e');
      }
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

  //Wallet Balance API
  void updateWallet() async{
    isLoading.value = true;
    try{
      var response = await ApiServices().updateWalletBalance(int.parse(userId.value),walletBalance.text);
      if(response['status']){
        getWalletBal();
        if (kDebugMode) {print(response);}
      }
    }catch(e){
      Get.back();
      if (kDebugMode) {print('Update Wallet API Error - $e');}
      Get.snackbar(
          'Wallet Error 👻',
          'Something went wrong please try again',
          backgroundColor: redColor,
          snackPosition: SnackPosition.TOP,
          colorText: Colors.white
      );
    }
    isLoading.value = false;
  }

  @override
  void dispose() {
    walletBalance.dispose();
    super.dispose();
  }


  //Razorpay Success Payment
  void handlerPaymentSuccess(PaymentSuccessResponse response) async {
    transactionId.value = response.paymentId.toString();
    updateWallet();
    walletBalance.clear();
  }

  //Razorpay Fail Payment
  void handlerErrorFailure() {
    walletBalance.clear();
    Get.snackbar('Payment Error', 'Something went wrong please try again',
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.black,
        backgroundColor: Colors.yellow);
  }

  //Razorpay Wallet Payment
  void handlerExternalWallet() {
    walletBalance.clear();
    Get.snackbar('Wallet', 'Something went wrong with the wallet',
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.black,
        backgroundColor: Colors.yellow);
  }

  //Razorpay Trigger
  void openCheckout(int amt) {
    isLoading.value = true;
    var options = {
      'key': razorPayAPIKey.value,
      'amount': amt * 100,
      'name': 'Mini Guru',
      'description': 'Select This Plan to register',
      'prefill': {'contact': userMobile.value, 'email': 'mspl@gmail.com'},
      'external': {
        'wallets': ['paytm']
      }
    };
    try {
      razorpay!.open(options);
    } catch (e) {
      if (kDebugMode) {print(e.toString());}
    }
    isLoading.value = false;
  }

}
