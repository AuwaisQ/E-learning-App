import 'dart:io';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mini_guru/constants.dart';
import 'package:mini_guru/others/progressHud.dart';
import '../../../../others/NameIdModel.dart';
import '../../add_address/model/addressModel.dart';
import '../controllers/profile_page_controller.dart';

class ProfilePageView extends GetView<ProfilePageController> {
  ProfilePageController profilePageController = Get.put(ProfilePageController());

  ProfilePageView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ProgressHud(buildUi(context), profilePageController.isApiLoading.value);
    });
  }

  Widget buildUi(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const String demoImage = 'https://cdn-icons-png.flaticon.com/512/21/21104.png';
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: const Text('My Profile', style: titleStyle,),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                //Profile Image View
                Obx(() {
                  return Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      //Profile Photo
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: CircleAvatar(
                          backgroundColor: primaryColor,
                          radius: 100,
                          child: CircleAvatar(
                              radius: 95,
                              backgroundImage: profilePageController.profilePicture.isEmpty
                                  ? const NetworkImage(demoImage)
                                  : FileImage(File(
                                  profilePageController.profilePicture
                                      .value)) as ImageProvider
                          ),
                        ),
                      ),
                      //Profile Edit Button
                      InkWell(
                        onTap: () {
                          Get.defaultDialog(
                              middleText: 'Select Image',
                              title: 'Update Profile Photo',
                              barrierDismissible: true,
                              radius: 5.0,
                              confirm: InkWell(
                                onTap: () {
                                  Get.back();
                                  profilePageController.getImage(ImageSource.gallery);
                                },
                                child: Card(
                                  elevation: 5,
                                  child: Container(
                                      height: size.width * 0.25,
                                      width: size.width * 0.25,
                                      decoration: BoxDecoration(
                                        color: secondaryColor,
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
                                  profilePageController.getImage(ImageSource.camera);
                                },
                                child: Card(
                                  elevation: 5,
                                  child: Container(
                                      height: size.width * 0.25,
                                      width: size.width * 0.25,
                                      decoration: BoxDecoration(
                                        color: secondaryColor,
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
                        child: Container(
                            height: size.width / 12,
                            width: size.width / 5,
                            decoration: BoxDecoration(
                                color: secondaryColor,
                                borderRadius: BorderRadius.circular(15)),
                            child: const Center(
                              child: Text(
                                'Add',
                                style: headline1,
                              ),
                            )),
                      ),
                    ],
                  );
                }),
                SizedBox(height: size.width * 0.05),
                Form(
                  key: controller.profileFormKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(' Full Name', style: headline,),
                      //Name TextField
                      TextFormField(
                        controller: profilePageController.fullNameController,
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
                      SizedBox(height: size.width * 0.04),
                      const Text(' Guardian Name', style: headline,),
                      //Parent Name
                      TextFormField(
                        controller: profilePageController.parentNameController,
                        validator: (value) {
                          if (value!.length < 5) {
                            return 'Add At least 5 letters';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelStyle: TextStyle(color: Colors.grey.shade400),
                          suffixIcon: Icon(
                            CupertinoIcons.person_2,
                            color: Colors.grey.shade400,
                          ),
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
                      SizedBox(height: size.width * 0.04),
                      const Text(' Date of Birth', style: headline,),
                      //DOB TextField
                      Obx(() {
                        return InkWell(
                          onTap: () =>
                              profilePageController.selectDateOfBirth(),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            width: size.width,
                            height: size.width / 6.8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(profilePageController.dateOfBirth.value,
                                    style: subTitle),
                                Icon(CupertinoIcons.calendar,
                                    color: Colors.grey.shade400)
                              ],),
                          ),
                        );
                      }),
                      SizedBox(height: size.width * 0.04),
                      const Text(' School Name', style: headline,),
                      //School Name
                      TextFormField(
                        controller: profilePageController.schoolNameController,
                        validator: (value) {
                          if (value!.length < 5) {
                            return 'Add At least 5 letters';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelStyle: TextStyle(color: Colors.grey.shade400),
                          suffixIcon: Icon(
                            CupertinoIcons.book,
                            color: Colors.grey.shade400,
                          ),
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
                      SizedBox(height: size.width * 0.04),
                      const Text(' School Address', style: headline,),
                      //School Address
                      TextFormField(
                        controller: profilePageController.schoolAddress,
                        validator: (value) {
                          if (value!.length < 5) {
                            return 'Add At least 5 letters';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelStyle: TextStyle(color: Colors.grey.shade400),
                          suffixIcon: Icon(
                            CupertinoIcons.location_solid,
                            color: Colors.grey.shade400,
                          ),
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
                      SizedBox(height: size.width * 0.04),
                      const Text(' Contact', style: headline,),
                      //Mobile Number
                      Container(
                        height: size.width * 0.14,
                        width: size.width,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Obx(() {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //Here the mobile number is coming from shared preferences
                              Text(
                                profilePageController.userMobileNumber.value !=
                                    ''
                                    ? '+91-${profilePageController
                                    .userMobileNumber}'
                                    : '+91-000 000 0000',
                                style: const TextStyle(fontSize: 16),
                              ),
                              Icon(
                                Icons.phone_android,
                                color: Colors.grey.shade400,
                              )
                            ],
                          );
                        }),
                      ),
                      SizedBox(height: size.width * 0.04),
                      const Text(' Mail', style: headline,),
                      //Email
                      TextFormField(
                        controller: profilePageController.emailController,
                        validator: (value) {
                          if (value!.isEmail) {} else {
                            return 'Please enter correct email';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelStyle: TextStyle(color: Colors.grey.shade400),
                          suffixIcon: Icon(
                            CupertinoIcons.mail,
                            color: Colors.grey.shade400,
                          ),
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
                      SizedBox(height: size.width * 0.04),
                      const Text(' Gender', style: headline,),
                      // Gender Selection Button
                      Container(
                        width: size.width,
                        height: size.width / 6,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Obx(() {
                                    return Radio<String>(
                                      value: 'Boy',
                                      groupValue: controller.genderType.value,
                                      onChanged: (value) {
                                        controller.setGender(value);
                                        //controller.address_type = valu!;
                                      },
                                      activeColor: Colors.purple,
                                      fillColor: MaterialStateProperty.all(
                                          primaryColor),
                                    );
                                  }),
                                  const Text(
                                    'Boy',
                                    style: TextStyle(fontSize: 17),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Obx(() {
                                    return Radio<String>(
                                      value: 'Girl',
                                      groupValue: controller.genderType.value,
                                      onChanged: (value) {
                                        controller.setGender(value);
                                        //controller.address_type = valu!;
                                      },
                                      activeColor: Colors.purple,
                                      fillColor: MaterialStateProperty.all(
                                          primaryColor),
                                    );
                                  }),
                                  const Text(
                                    'Girl',
                                    style: TextStyle(fontSize: 17),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Obx(() {
                                    return Radio<String>(
                                      value: 'Other',
                                      groupValue: controller.genderType.value,
                                      onChanged: (value) {
                                        controller.setGender(value);
                                        //controller.address_type = valu!;
                                      },
                                      activeColor: Colors.purple,
                                      fillColor: MaterialStateProperty.all(
                                          primaryColor),
                                    );
                                  }),
                                  const Text(
                                    'Other',
                                    style: TextStyle(fontSize: 17),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: size.width * 0.04),
                      const Text(' State', style: headline,),
                      //Select State
                      Obx(() {
                        return Container(
                          height: size.width * 0.12,
                          width: size.width,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            border: Border.all(color: primaryColor),
                          ),
                          child: Center(
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                // searchInnerWidget: SizedBox(
                                //   height: size.width * 0.01,
                                //   width: size.width,
                                // ),
                                dropdownDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border:
                                  Border.all(color: Colors.grey.shade400),
                                ),
                                isExpanded: true,
                                isDense: true,
                                hint: LoadingAnimationWidget.prograssiveDots(
                                    color: primaryColor, size: 40),
                                icon: const Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.grey,
                                ),
                                onChanged: (value) {
                                  profilePageController.stateId.value =
                                      value.toString();
                                  profilePageController.getCityList(
                                      int.parse(value.toString()));
                                },
                                value: profilePageController.stateId.value,
                                items: profilePageController.stateList
                                    .map<DropdownMenuItem<String>>((NameIdModel value) {
                                  return DropdownMenuItem<String>(
                                    value: value.id.toString(),
                                    child: Text(
                                      value.name,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        );
                      }),
                      SizedBox(height: size.width * 0.04),
                      const Text(' City', style: headline,),
                      //Select City
                      Obx(() {
                        return Container(
                          height: size.width * 0.12,
                          width: size.width,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            border: Border.all(color: primaryColor),
                          ),
                          child: Center(
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                // searchInnerWidget: SizedBox(
                                //   height: size.width * 0.01,
                                //   width: size.width,
                                // ),
                                dropdownDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border:
                                  Border.all(color: Colors.grey.shade400),
                                ),
                                isExpanded: true,
                                isDense: true,
                                hint: LoadingAnimationWidget.prograssiveDots(
                                    color: primaryColor, size: 40),
                                icon: const Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.grey,
                                ),
                                onChanged: (value) {
                                  profilePageController.cityId.value = value.toString();
                                  print('Selected CityId is - ${profilePageController.cityId.value}');
                                },
                                value: profilePageController.cityId.value,
                                items: profilePageController.cityList.map<
                                    DropdownMenuItem<String>>(
                                        (CityIdModel value) {
                                      return DropdownMenuItem<String>(
                                        value: value.id.toString(),
                                        child: Text(
                                          value.city.toString(),
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                              ),
                            ),
                          ),
                        );
                      }),
                      SizedBox(height: size.width * 0.04),
                      const Text(' Full Address', style: headline,),
                      //Address
                      TextFormField(
                        controller: profilePageController.addressController,
                        validator: (value) {
                          if (value!.length < 5) {
                            return 'Add At least 5 letters';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelStyle: TextStyle(color: Colors.grey.shade400),
                          suffixIcon: Icon(
                            CupertinoIcons.location_solid,
                            color: Colors.grey.shade400,
                          ),
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
                      SizedBox(height: size.width * 0.04),
                      //Continue Button
                      EnterAnimation(
                        InkWell(
                          onTap: () {
                            if (profilePageController.profileFormKey.currentState!.validate()) {
                              profilePageController.sendUserProfile();
                            } else {
                              Get.snackbar(
                                'Empty field\'s',
                                'Check the field\'s which are empty',
                                margin: const EdgeInsets.all(20),
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.red.withOpacity(0.6),
                              );
                            }
                          },
                          child: Obx(() {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15),
                              height: size.width * 0.14,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: secondaryColor,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Stack(
                                children: [
                                  Center(
                                      child: Text(
                                        profilePageController.isApiLoading
                                            .value == true
                                            ? 'Saving'
                                            : 'Continue',
                                        style: headline1,
                                      )),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: profilePageController.isApiLoading
                                        .value == true
                                        ? LoadingAnimationWidget
                                        .threeArchedCircle(
                                        color: Colors.white, size: 25)
                                        : const Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.black,
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ),
                      ),
                      SizedBox(height: size.width * 0.03),
                    ],),),
              ],),
          ),
        ),
      ),
    );
  }
}
