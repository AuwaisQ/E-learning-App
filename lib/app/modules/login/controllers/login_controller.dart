import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_guru/constants.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../apiServices/apiServices.dart';
import '../../bottomBar/views/bottom_bar_view.dart';

class LoginController extends GetxController {
  final GlobalKey<FormState>loginFormKey = GlobalKey<FormState>();
  late RoundedLoadingButtonController loadingButtonController;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  var statusString = 'welcome'.obs;
  var codeSent = 'no'.obs;
  var myVerificationId = '1'.obs;

  String get result => statusString.value;
  String get codeSentResult => codeSent.value;
  String get verifyResult => myVerificationId.value;

  var isLoading = false.obs;
  var termsCondition = false.obs;
  var userId = "".obs;

  late TextEditingController phoneNumber;
  late TextEditingController codeController;

  @override
  void onInit() {
    super.onInit();
    phoneNumber = TextEditingController();
    codeController = TextEditingController();
    loadingButtonController = RoundedLoadingButtonController();
  }

  //Phone Number Login
  signInPhoneNumber({required String myPhoneNumber}) async {
    if(myPhoneNumber.length != 10){
      Get.snackbar(
        'Incorrect Number',
        'Please Provide 10 digit Phone Number',
        margin: const EdgeInsets.all(20),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.6),
      );
    }else if(termsCondition.value){
      await firebaseAuth.verifyPhoneNumber(
        //Pass in the phone number
        phoneNumber: '+91$myPhoneNumber',
        //Triggers if phone number is verified
        verificationCompleted: (_){},
        //Triggers if verification fails
        verificationFailed: (FirebaseException exception){
          statusString.value = 'Error Verifying Your Phone Number';
        },
        //triggered when firebase sends a code
        codeSent: (verificationId,responseToken){
          if (kDebugMode) {print('Code Sent triggered');}
          codeSent.value = 'yes';
          myVerificationId.value = verificationId;
          isLoading.value = false;
        },
        //get a new code after timeout
        codeAutoRetrievalTimeout: (_){},
        //Time in which the code is valid
        timeout: const Duration(seconds:30),
      );
    }else{
      Get.snackbar(
        'Terms & Conditions',
        'Please Check Terms & Conditions for login',
        margin: const EdgeInsets.all(20),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: redColor,
      );
    }
  }

  //OTP Verification
  myCredentials(String verId, String userId) async {
    final prefs = await SharedPreferences.getInstance();
    AuthCredential authCredential = PhoneAuthProvider.credential(verificationId: verId, smsCode: userId);
    firebaseAuth.signInWithCredential(authCredential).then((UserCredential){
      //Saving mobile number into shared prefs.
      prefs.setString('userMobileNumber',phoneNumber.text);
      // Setting Login as true
      prefs.setBool('isLogin',true);
      //Checking Mobile
      mobileVerification(phoneNumber.text);
    }).catchError((e){
      if (kDebugMode) {print('Ye Hai Error:- $e');}
      Get.snackbar(
        'Invalid OTP',
        'Please Provide Correct OTP',
        margin: const EdgeInsets.all(20),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.6),
      );
    });
  }

  //Verify Mobile
  mobileVerification(String phoneNumber) async {
    if (kDebugMode) {print('Verifying Mobile Triggered');}
    final prefs = await SharedPreferences.getInstance();
    final response = await ApiServices().checkLogin(phoneNumber);//Getting response from api after giving number.
    if (kDebugMode) {print('Api Response- $response');}
    if(response['status']){
      userId.value = response['userid'].toString();//fetching response and assigning value.
      if (kDebugMode) {print('User Id- ${userId.value}');}
      prefs.setString('UserId',userId.value);//saving userID form API.
      Get.offAll(()=>BottomBarView());
    }else{
      Get.offAllNamed('/profile-page');
    }
  }
}
