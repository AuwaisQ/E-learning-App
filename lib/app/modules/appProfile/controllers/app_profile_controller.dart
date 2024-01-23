import 'dart:convert';
import 'dart:io';
import 'dart:io' as Io;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mini_guru/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../apiServices/apiServices.dart';

class AppProfileController extends GetxController {
  //TODO: Implement AppProfileController

  var isLoading = false.obs;
  var userId = ''.obs;
  var userImage = ''.obs;
  var userName = ''.obs;
  var userMobile = ''.obs;
  var profilePicture = ''.obs;
  var base64Image = ''.obs;
  var isImageLoading = false.obs;
  final TextEditingController nameController = TextEditingController();

  @override
  void onInit() async {
    final prefs = await SharedPreferences.getInstance();
    userId.value = prefs.getString('UserId')!;
    print(userId.value);
    getUserData();
    super.onInit();
  }

  //Get UserData
  void getUserData() async {
    isLoading.value = true;
    var response = await ApiServices().getUserProfileDetails(userId.value);
    if (response['status']) {
      if (kDebugMode) {
        print('Name - ${response['data'][0]['name']}');
      }
      if (kDebugMode) {
        print('mobile - ${response['data'][0]['mobile']}');
      }
      if (kDebugMode) {
        print('Image - ${ApiServices().userImageURL}/${response['data'][0]['image']}');
      }
      userName.value = response['data'][0]['name'].toString();
      userMobile.value = response['data'][0]['mobile'].toString();
      userImage.value = response['data'][0]['image'].toString();
      isLoading.value = false;
    } else {
      userName.value = '';
    }
    isLoading.value = false;
  }

  // This shows a CupertinoModalPopup which hosts a CupertinoActionSheet.
  void openEditSheet() {
    Get.bottomSheet(
      SingleChildScrollView(
        child: Column(
          children: [
            //Title
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Account Detail's",
                    style: titleStyle,
                  ),
                  IconButton(onPressed: () => Get.back(),
                      icon: const Icon(
                        Icons.close, color: Colors.red, size: 30,))
                ],
              ),
            ),
            //Image Update
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: primaryColor,
                    radius: 90,
                    child: Obx(() {
                      return CircleAvatar(
                          radius: 86,
                          backgroundImage: profilePicture.isEmpty
                              ? NetworkImage(ApiServices().userImageURL +
                              userImage.value)
                              : FileImage(File(
                              profilePicture.value)) as ImageProvider
                      );
                    }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MaterialButton(
                        textColor: Colors.white,
                        color: primaryColor,
                        onPressed: () {
                          Get.defaultDialog(
                              middleText: 'Select Image',
                              title: 'Update Profile Photo',
                              barrierDismissible: true,
                              radius: 5.0,
                              confirm: InkWell(
                                onTap: () {
                                  Get.back();
                                  getImage(ImageSource.gallery);
                                },
                                child: Card(
                                  elevation: 5,
                                  child: Container(
                                      height: Get.width * 0.25,
                                      width: Get.width * 0.25,
                                      decoration: BoxDecoration(
                                        color: primaryColor,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: const Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            CupertinoIcons.photo_on_rectangle,
                                            size: 50,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            "Gallery",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15),
                                          )
                                        ],
                                      )),
                                ),
                              ),
                              cancel: InkWell(
                                onTap: () {
                                  Get.back();
                                  getImage(ImageSource.camera);
                                },
                                child: Card(
                                  elevation: 5,
                                  child: Container(
                                      height: Get.width * 0.25,
                                      width: Get.width * 0.25,
                                      decoration: BoxDecoration(
                                        color: primaryColor,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: const Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            CupertinoIcons.camera_on_rectangle,
                                            size: 50,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            "Camera",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15),
                                          )
                                        ],
                                      )),
                                ),
                              ));
                        },
                        child: const Text('Select Image'),
                      ),
                      const SizedBox(width: 10),
                      MaterialButton(
                        textColor: Colors.white,
                        color: primaryColor,
                        onPressed: () async {
                          if (base64Image.value == '') {
                            Get.snackbar(
                              'Account Image Error',
                              'Please Select Image to update Account',
                              margin: const EdgeInsets.all(20),
                              snackPosition: SnackPosition.TOP,
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                            );
                          } else {
                            var response = await ApiServices().updateUserImage(
                                int.parse(userId.value),
                                base64Image.value
                            );
                            print(response);
                            if (response['status']) {
                              Get.back();
                              getUserData();
                              nameController.clear();
                            }
                          }
                        },
                        child: const Text('Update Image'),
                      ),
                    ],
                  ),
                ],),
            ),
            const SizedBox(height: 20),
            //Name Update
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Name TextField
                  TextFormField(
                    controller: nameController,
                    validator: (value) {
                      if (value!.length < 5) {
                        return 'Add At least 5 letters';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.grey.shade400),
                      suffixIcon: Icon(
                        CupertinoIcons.person,
                        color: Colors.grey.shade400,
                      ),
                      hintText: userName.value,
                      counterText: '',
                      alignLabelWithHint: true,
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          color: Colors.red,
                          width: 2.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          color: primaryColor,
                          width: 2.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Colors.grey.shade300,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  MaterialButton(
                    textColor: Colors.white,
                    color: primaryColor,
                    onPressed: () async {
                      if (nameController.text == "") {
                        Get.snackbar(
                          'Account Name Error',
                          'Please Enter New Name In the Box',
                          margin: const EdgeInsets.all(20),
                          snackPosition: SnackPosition.TOP,
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                        );
                      } else {
                        var response = await ApiServices().updateUserName(int.parse(userId.value), nameController.text);
                        print(response);
                        if (response['status']) {
                          Get.back();
                          getUserData();
                          nameController.clear();
                        }
                      }
                    },
                    child: const Text('Update Name'),
                  ),
                ],),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }


  //Logout Bottom Sheet.
  void showActionSheet(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) =>
          CupertinoActionSheet(
            title: const Text('Logout', style: titleStyle,),
            message: const Text(
              'This action will logout your account from the app',
              style: subTitle,),
            actions: <CupertinoActionSheetAction>[
              CupertinoActionSheetAction(
                onPressed: () async {
                  isLoading.value = true;
                  final prefs = await SharedPreferences.getInstance();
                  prefs.setBool("isLogin", false);
                  prefs.clear();
                  SystemNavigator.pop();
                  exit(0);
                },
                child: const Text('Logout'),
              ),
              CupertinoActionSheetAction(
                isDestructiveAction: true,
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
            ],
          ),
    );
  }

  //Profile Image Picker
  getImage(ImageSource imageSource) async {
    isImageLoading.value = true;
    final pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
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

}
