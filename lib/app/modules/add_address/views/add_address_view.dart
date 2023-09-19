import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:mini_guru/constants.dart';
import 'package:mini_guru/others/NameIdModel.dart';
import '../controllers/address_controller.dart';
import '../model/addressModel.dart';

class AddAddressView extends GetView<AddressController> {
  AddressController addressController = Get.put(AddressController());

  AddAddressView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    final appBar = SizedBox(
      height: size.width * 0.15,
      child: Stack(
        children: [
          const Center(
              child: Text(
                'Add Address',
                style: titleStyle,
              )),
          //Back Button
          Align(
            alignment: Alignment.centerLeft,
            child: InkWell(
              onTap: (){
                Get.back();
                addressController.stateId.value = '1';
                addressController.cityId.value = '0';
                addressController.addressController.clear();
              },
              child: const Icon(Icons.arrow_back_ios_new),
            ),
          ),
        ],
      ),
    );
    final addAddress = InkWell(
      onTap: (){
        if (kDebugMode) {print(addressController.userId);}
        if (kDebugMode) {print(addressController.stateId);}
        if (kDebugMode) {print(addressController.cityId);}
        if (kDebugMode) {print(addressController.addressType);}
        if (kDebugMode) {print(addressController.addressController.text);}
        if(addressController.addressFormKey.currentState!.validate() && addressController.cityId.value != '0'){
          addressController.addAddress();
        }else{
          Get.snackbar(
              'Empty Address 🧐',
              'Please Select or add you address',
              backgroundColor: Colors.red.withOpacity(0.7),
              snackPosition: SnackPosition.TOP,
              colorText: Colors.white
          );
        }
      },
      child: Container(
        height: size.width * 0.15,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: const Center(
          child: Text(
            'ADD',
            style: buttonTitleStyle,
          ),
        ),
      ),
    );
    return Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: addAddress,
        body: Form(
          key: controller.addressFormKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: EnterAnimation(
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
              child: Column(children: [
                appBar,
                SizedBox(height: size.width * 0.03,),
                Obx(() {
                  return Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 5,
                            spreadRadius: .5,
                            color: Colors.black.withOpacity(.2),
                            offset: const Offset(1.0, 5.0))
                      ],
                    ),
                    child: addressController.isApiLoading.value == true
                        ? Center(child: Lottie.asset(
                        'lottieFiles/loading.json', height: 100, width: 100),)
                        : Column(
                      children: [
                        const Align(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 5),
                              child: Text("Select State"),
                            )),

                        SizedBox(height: size.width * 0.001,),
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
                                    addressController.stateId.value = value.toString();
                                    addressController.getCityList(int.parse(value.toString()));
                                  },
                                  value: addressController.stateId.value,
                                  items: addressController.stateList
                                      .map<DropdownMenuItem<String>>((
                                      NameIdModel value) {
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

                        SizedBox(height: size.width * 0.05,),

                        const Align(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 5),
                              child: Text("Select City"),
                            )),

                        SizedBox(height: size.width * 0.001,),

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
                                    addressController.cityId.value = value.toString();
                                    print('Selected CityId is - ${addressController.cityId.value}');
                                  },
                                  value: addressController.cityId.value,
                                  items: addressController.cityList.map<
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

                        SizedBox(height: size.width * 0.05),

                        const Align(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 5),
                              child: Text("Full Address"),
                            )),

                        SizedBox(
                          height: size.width * 0.001,
                        ),

                        //Address
                        TextFormField(
                          controller: addressController.addressController,
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value!.length < 5) {
                              return 'Please Provide Address Briefly';
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

                        SizedBox(height: size.width * 0.05),
                        Row(
                          children: [
                            Expanded(
                              child: ListTile(
                                leading: Obx(() {
                                  return Radio<String>(
                                    value: 'Home'.tr,
                                    groupValue:
                                    addressController.addressType.value,
                                    onChanged: (value) {
                                      addressController
                                          .onChangeAddressType(value);
                                      //controller.address_type = valu!;
                                    },
                                    activeColor: Colors.purple,
                                    fillColor:
                                    MaterialStateProperty.all(primaryColor),
                                  );
                                }),
                                title: Text('Home'.tr, style: headline1),
                              ),
                            ),
                            Expanded(
                                child: ListTile(
                                  leading: Obx(() {
                                    return Radio<String>(
                                      value: 'Office'.tr,
                                      groupValue:
                                      addressController.addressType.value,
                                      onChanged: (value) {
                                        addressController.onChangeAddressType(
                                            value);
                                      },
                                      activeColor: Colors.purple,
                                      fillColor:
                                      MaterialStateProperty.all(primaryColor),
                                    );
                                  }),
                                  title: const Text(
                                    'Office',
                                    style: headline1,
                                  ),
                                )),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
              ]),
            ),
          ),
        ));
  }
}
