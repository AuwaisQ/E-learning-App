// ignore_for_file: unrelated_type_equality_checks

import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mini_guru/others/progressHud.dart';
import '../../../../constants.dart';
import '../controllers/my_projects_controller.dart';

class MyProjectsView extends GetView<MyProjectsController> {
  @override
  MyProjectsController controller = Get.put(MyProjectsController());
  MyProjectsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ProgressHud(buildUi(context), controller.isLoading.value);
    });
  }


  Widget buildUi(BuildContext context) {
    final size = MediaQuery.of(context).size;

    //AppBar
    final appBar = Stack(
      alignment: Alignment.center,
      children: [
        const Center(child: Text('Add Project',style: titleStyle,)),
        //Back Button
        Align(
          alignment: Alignment.centerLeft,
          child: InkWell(
            onTap: (){
              controller.editingControllerDescription.clear();
              controller.editingControllerTitle.clear();
              controller.sketch.value = '';
              Get.back();
            },
            child: Container(
              height: size.width * 0.12,
              width: size.width * 0.12,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(150),
                  border: Border.all(color: Colors.grey)),
              child: const Center(
                child: Icon(Icons.arrow_back_ios_new),
              ),
            ),
          ),
        ),
      ],
    );

    return Scaffold(
        backgroundColor: Colors.grey.shade300,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 15, right: 15, left: 15),
            child: EnterAnimation(SingleChildScrollView(
              child: Column(
                children: [
                  appBar,
                  SizedBox(height: size.width * 0.05),
                  Container(
                    padding: const EdgeInsets.all(10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.grey.shade300),
                        boxShadow: [
                          // Shadow for top-left corner
                          BoxShadow(
                            color: Colors.grey.shade500,
                            offset: const Offset(10, 10),
                            blurRadius: 6,
                            spreadRadius: 1,
                          ),
                          // Shadow for bottom-right corner
                          const BoxShadow(
                            color: Colors.white70,
                            offset: Offset(-10, -10),
                            blurRadius: 6,
                            spreadRadius: 1,
                          ),
                        ]
                    ),
                    child: Form(
                      key: controller.profileFormKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Project Title', style: headline1),
                          SizedBox(height: size.width * 0.02,),
                          //----Project-Title----
                          TextFormField(
                            controller: controller.editingControllerTitle,
                            validator: (value) {
                              if (value!.length < 5) {
                                return 'Add At least 5 Characters';
                              }
                              return null;
                            },
                            maxLength: 30,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: 'Enter Project Title',
                              labelStyle: TextStyle(color: Colors.grey.shade400),
                              suffixIcon: Icon(
                                Icons.add_card_sharp,
                                color: Colors.grey.shade400,
                              ),
                              counterText: '',
                              alignLabelWithHint: false,
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
                          SizedBox(height: size.width * 0.05,),
                          const Text(' Project Description', style: headline1),
                          SizedBox(height: size.width * 0.02,),
                          //----Description-TextField----
                          TextFormField(
                            controller: controller.editingControllerDescription,
                            validator: (value) {
                              if (value!.length < 5) {
                                return 'Add At least 5 characters';
                              }
                              return null;
                            },
                            maxLength: 500,
                            maxLines: 2,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: 'Description.....',
                              labelStyle: TextStyle(color: Colors.grey.shade400),
                              suffixIcon: const Icon(
                                CupertinoIcons.decrease_indent,
                                color: primaryColor,
                              ),
                              counterText: '',
                              alignLabelWithHint: false,
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
                          SizedBox(height: size.width * 0.05,),
                          //----Sketch-Attachment----
                          Obx(() {
                            return DottedBorder(
                              strokeWidth: 1,
                              borderType: BorderType.RRect,
                              color: primaryColor,
                              radius: const Radius.circular(15),
                              padding: const EdgeInsets.all(5),
                              child: InkWell(
                                onTap: () {
                                  Get.defaultDialog(
                                      middleText: 'Select Image',
                                      title: 'My Project Sketch',
                                      barrierDismissible: true,
                                      radius: 5.0,
                                      confirm: InkWell(
                                        onTap: () {
                                          Get.back();
                                          controller.getImage(
                                              ImageSource.gallery);
                                        },
                                        child: Card(
                                          elevation: 5,
                                          child: Container(
                                              height: size.width * 0.25,
                                              width: size.width * 0.25,
                                              decoration: BoxDecoration(
                                                color: primaryColor,
                                                borderRadius:
                                                BorderRadius.circular(5),
                                              ),
                                              child: const Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    CupertinoIcons
                                                        .photo_on_rectangle,
                                                    size: 50,
                                                    color: Colors.white,
                                                  ),
                                                  Text(
                                                    "Gallery",
                                                    style: TextStyle(
                                                        color: Colors
                                                            .white,
                                                        fontSize: 15),
                                                  )
                                                ],
                                              )),
                                        ),
                                      ),
                                      cancel: InkWell(
                                        onTap: () {
                                          Get.back();
                                          controller.getImage(
                                              ImageSource.camera);
                                        },
                                        child: Card(
                                          elevation: 5,
                                          child: Container(
                                              height: size.width * 0.25,
                                              width: size.width * 0.25,
                                              decoration: BoxDecoration(
                                                color: primaryColor,
                                                borderRadius:
                                                BorderRadius.circular(5),
                                              ),
                                              child: const Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    CupertinoIcons
                                                        .camera_on_rectangle,
                                                    size: 50,
                                                    color: Colors.white,
                                                  ),
                                                  Text(
                                                    "Camera",
                                                    style: TextStyle(
                                                        color: Colors
                                                            .white,
                                                        fontSize: 15),
                                                  )
                                                ],
                                              )),
                                        ),
                                      ));
                                },
                                child: Container(
                                    height: size.width * 0.3,
                                    width: size.width,
                                    decoration: BoxDecoration(
                                        color: primaryColor.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: controller.sketch.value != ''
                                        ? ClipRRect(
                                        borderRadius: BorderRadius
                                            .circular(10),
                                        child: Image.file(
                                            File(controller.sketch.value),
                                            fit: BoxFit.cover))
                                        : const Center(child: Text(
                                      'Tap To Select\nProject Thumbnail',
                                      textAlign: TextAlign.center,
                                      style: subTitle,))
                                ),
                              ),
                            );
                          }),
                          SizedBox(height: size.width * 0.03,),
                          //----Start-&-End-Date----
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //Start Date Button
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text('Start Date', style: headline,),
                                  Container(
                                    height: size.width * 0.1,
                                    width: size.width * 0.35,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    decoration: BoxDecoration(
                                        color: primaryColor,
                                        borderRadius: BorderRadius.circular(
                                            10),
                                        boxShadow: [
                                          BoxShadow(
                                            offset: const Offset(0, 5),
                                            color: Colors.grey.withOpacity(
                                                0.4),
                                            blurRadius: 4,
                                          ),
                                        ]
                                    ),
                                    child: Center(child: InkWell(onTap: () =>
                                    {
                                      controller.selectStartDate()
                                    }, child: Obx(() {
                                      return Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceAround,
                                        children: [
                                          const Icon(
                                            Icons.calendar_month_outlined,
                                            color: Colors.white,),
                                          Text(controller.startDate.value,
                                            style: blueButtonSubTitle,),
                                        ],
                                      );
                                    })),),
                                  ),
                                ],
                              ),
                              //Start Date Button
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text('End Date', style: headline,),
                                  Container(
                                    height: size.width * 0.1,
                                    width: size.width * 0.35,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    decoration: BoxDecoration(
                                        color: primaryColor,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            offset: const Offset(0, 5),
                                            color: Colors.grey.withOpacity(0.4),
                                            blurRadius: 4,
                                          ),
                                        ]
                                    ),
                                    child: Center(child: InkWell(onTap: () => {
                                      controller.selectEndDate()
                                    }, child: Obx(() {
                                      return Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          const Icon(
                                            Icons.calendar_month_outlined,
                                            color: Colors.white,),
                                          //SizedBox(width: 5,),
                                          Text(controller.endDate.value,
                                            style: blueButtonSubTitle,),
                                        ],
                                      );
                                    })),),
                                  ),
                                ],
                              ),
                            ],),
                          SizedBox(height: size.width * 0.05,),
                          //----Material-Select----
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 13),
                            width: size.width,
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(child: InkWell(
                              onTap: (){
                                if(controller.profileFormKey.currentState!.validate()){
                                  controller.createProject();
                                }else{
                                  Get.snackbar(
                                    'Error',
                                    'Some Fields are missing',
                                    margin: const EdgeInsets.all(20),
                                    snackPosition: SnackPosition.BOTTOM,
                                    duration: const Duration(seconds: 3),
                                    backgroundColor: redColor.withOpacity(0.8),
                                    colorText: Colors.white,
                                  );
                                }
                              },
                              child: const Text('Select Material',style: blueButtonSubTitle),
                            ),),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ),
          ),
        ));
  }
}
