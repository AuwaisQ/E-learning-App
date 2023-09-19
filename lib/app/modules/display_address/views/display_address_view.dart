import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mini_guru/constants.dart';
import 'package:mini_guru/others/progressHud.dart';
import '../../add_address/views/add_address_view.dart';
import '../controllers/display_address_controller.dart';

class DisplayAddressView extends GetView<DisplayAddressController> {
  DisplayAddressController addressController = Get.put(DisplayAddressController());

  DisplayAddressView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ProgressHud(buildUi(context), addressController.isLoading.value);
    });
  }


  Widget buildUi(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final appBar = SizedBox(
      height: size.width * 0.15,
      child: Stack(
        children: [
          const Center(
              child: Text(
                'Select Address',
                style: titleStyle,
              )),
          //Back Button
          Align(
            alignment: Alignment.centerLeft,
            child: InkWell(
              onTap: () => Get.back(),
              child: Container(
                height: size.width * 0.10,
                width: size.width * 0.10,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(150),
                    border: Border.all(color: Colors.grey)),
                child: const Center(
                  child: Icon(Icons.arrow_back_ios_new),
                ),
              ),
            ),
          ),
          //Add Address Button
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 5),
              child: InkWell(
                onTap: () => Get.to(()=>AddAddressView()),
                child: const Icon(
                  Icons.add_home_outlined, color: Colors.black,
                  size: 35,),
              ),
            ),
          ),
        ],
      ),
    );

    final button = Container(
      height: size.width * 0.15,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
          child: InkWell(
            onTap: (() {
              if (kDebugMode) {print(addressController.selectedAddressId.value);}
              if(addressController.selectedAddressId.value != 0){
                if(addressController.orderId.value != 0){
                  addressController.selectOrderAddress();
                }else{
                  Get.back();
                  Get.snackbar(
                      'Something Went Wrong 😕',
                      'Order ID is not generated please try again',
                      backgroundColor: redColor,
                      snackPosition: SnackPosition.TOP,
                      colorText: Colors.white
                  );
                }
              }else{
                Get.snackbar(
                    'Select Address 👻',
                    'Please Select or add you address',
                    backgroundColor: redColor,
                    snackPosition: SnackPosition.TOP,
                  colorText: Colors.white
                );
              }
            }),
            child: const Text('Checkout', style: buttonTitleStyle,),
          )),
    );

    return RefreshIndicator(
      onRefresh: ()async{
        addressController.getAddress();
      },
      child: Scaffold(
          floatingActionButton: button,
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
                child: EnterAnimation(
                  Column(children: [
                    Expanded(flex: 0, child: appBar),
                    SizedBox(height: size.width * 0.05,),
                    Expanded(flex: 1, child: Obx(() {
                      return Column(
                        children: [
                          addressController.isLoading.value
                              ? Container()
                              : addressController.addresses.isEmpty
                              ? Align(
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                Lottie.network('https://assets8.lottiefiles.com/packages/lf20_WpDG3calyJ.json'),
                                const Text(
                                  'Add Address to Proceed',
                                  style: subTitle,
                                )
                              ],
                            ),
                          )
                              : Column(
                            children: List.generate(
                                addressController.addresses.length,
                                    (index) =>
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 5),
                                      child: Card(
                                        elevation: 5,
                                        child: ListTile(
                                            onTap: () => addressController.setAddress(addressController.addresses[index].id),
                                            title: Text(
                                              addressController.addresses[index].address,
                                              style: headline,
                                            ),
                                            subtitle: Text(
                                              '${addressController.addresses[index].city}, ${addressController.addresses[index].state}',
                                              style: subTitle
                                            ),
                                            trailing: Icon(addressController.selectedAddressId.value == addressController.addresses[index].id
                                                ? Icons.radio_button_checked_sharp
                                                : Icons.radio_button_off,
                                              color: primaryColor,
                                            )),
                                      ),
                                    )),
                          )
                        ],
                      );
                    },
                    ),)
                  ],),
                )
            ),
          )
      ),
    );
  }
}
