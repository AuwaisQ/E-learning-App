import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mini_guru/app/modules/cart/controllers/cart_controller.dart';
import 'package:mini_guru/others/progressHud.dart';
import '../../../../constants.dart';
import '../../../apiServices/apiServices.dart';
import '../controllers/checkout_controller.dart';

class CheckoutView extends GetView<CheckoutController> {

  CheckoutController checkoutController = Get.put(CheckoutController());
  CartController cartController = Get.put(CartController());
  CheckoutView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ProgressHud(buildUi(context), checkoutController.isLoading.value);
    });
  }

  Widget buildUi(BuildContext context) {

    final size = Get.size;

    //AppBar
    final appBar = SizedBox(
      height: size.width * 0.15,
      child: Stack(
        children: [
          const Center(
              child: Text(
                'Checkout',
                style: titleStyle,
              )),
          //Back Button
          Align(
            alignment: Alignment.centerLeft,
            child: InkWell(
              onTap: () {Get.back();},
              child: Container(
                height: size.width * 0.11,
                width: size.width * 0.11,
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
      ),
    );

    //Item Total Button
    final itemTotalButton = Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      height: size.width / 7,
      width: double.infinity,
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(
          15,
        ),
      ),
      child: Stack(
        children: [
          Obx(() {
            return Center(
                child: InkWell(
                  onTap: () {
                    if (cartController.cartValue.value <= checkoutController.walletBal.value) {
                      Get.snackbar(
                        'Low Balance',
                        'Update Your Wallet balance',
                        margin: const EdgeInsets.all(20),
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.red.withOpacity(0.6),
                      );
                      // checkoutController.checkOut();
                    } else {
                      Get.snackbar(
                        'Low Balance',
                        'Update Your Wallet balance',
                        margin: const EdgeInsets.all(20),
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.red.withOpacity(0.6),
                      );
                    }
                  },
                  child: Text.rich(TextSpan(
                      text: 'Item Total : ',
                      style: buttonTitleStyle,
                      children: [
                        TextSpan(
                          text: '₹${cartController.cartValue.value.toString()}/-',
                          style: headline,
                        )
                      ])),
                ));
          }),
          const Align(
            alignment: Alignment.centerRight,
            child: Icon(
              CupertinoIcons.arrow_right_circle,
              size: 20,
            ),
          )
        ],
      ),
    );

    return RefreshIndicator(
      displacement: 50,
      backgroundColor: primaryColor,
      color: Colors.white,
      strokeWidth: 2,
      onRefresh: () async {
        await Future.delayed(const Duration(milliseconds: 500));
        checkoutController.getWalletBal();
      },
      child: Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: itemTotalButton,
          ),
          body: SafeArea(
            child: Padding(
              padding:
              const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 80),
              child: EnterAnimation(
                Column(
                  children: [
                    Flexible(
                      flex: 0,
                      child: Column(
                        children: [
                          appBar,
                          SizedBox(
                            height: size.width * 0.03,
                          ),
                        ],
                      ),
                    ),

                    //Wallet
                    Container(
                      margin: const EdgeInsets.only(
                          bottom: 10, right: 5, left: 5),
                      padding: const EdgeInsets.only(
                          top: 10, right: 10, left: 10, bottom: 5),
                      height: 80,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: secondaryColor,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black, width: 1.5)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Text('Wallet Balance', style: headline,),
                                  const SizedBox(width: 5),
                                  //Add Payment Button
                                  InkWell(
                                      onTap: () {
                                        Get.bottomSheet(
                                            Container(
                                              height: 270,
                                              width: double.infinity,
                                              padding: const EdgeInsets.all(10),
                                              decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.only(
                                                      topLeft: Radius.circular(
                                                          20),
                                                      topRight: Radius.circular(
                                                          20)
                                                  )
                                              ),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .start,
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .center,
                                                children: [
                                                  const Text(
                                                    'Add Money To Wallet',
                                                    style: titleStyle,),
                                                  SizedBox(
                                                    height: size.width * 0.05,),
                                                  //Add Amount Row
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      //Add Amount TextField
                                                      Expanded(
                                                        flex: 2,
                                                        child: SizedBox(
                                                          height: size.width *
                                                              0.11,
                                                          width: size.width,
                                                          child: TextFormField(
                                                            key: checkoutController
                                                                .walletKey,
                                                            autovalidateMode: AutovalidateMode
                                                                .onUserInteraction,
                                                            controller: checkoutController
                                                                .walletBalance,
                                                            keyboardType: TextInputType
                                                                .number,
                                                            validator: (value) {
                                                              if (value!.isEmpty) {
                                                                return 'Enter Correct Value';
                                                              }
                                                              return null;
                                                            },
                                                            decoration: InputDecoration(
                                                              alignLabelWithHint: true,
                                                              contentPadding: const EdgeInsets
                                                                  .only(bottom: 5,
                                                                  left: 10),
                                                              labelText: 'Enter Amount ₹',
                                                              labelStyle: subTitle,
                                                              focusedBorder: OutlineInputBorder(
                                                                borderRadius: BorderRadius
                                                                    .circular(10),
                                                                borderSide: const BorderSide(
                                                                  color: primaryColor,
                                                                  width: 2.0,
                                                                ),
                                                              ),
                                                              enabledBorder: OutlineInputBorder(
                                                                borderRadius: BorderRadius
                                                                    .circular(10),
                                                                borderSide: const BorderSide(
                                                                  color: primaryColor,
                                                                  width: 2.0,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(width: size.width *
                                                          0.05,),
                                                      //Amount Add Button
                                                      Expanded(
                                                        flex: 1,
                                                        child: InkWell(
                                                          onTap: () {
                                                            if (kDebugMode) {print('Amount-${checkoutController.walletBalance.text}');}
                                                            if(checkoutController.walletBalance.text.isEmpty){
                                                              Get.snackbar('Wallet Error', 'Please fill the correct amount',
                                                                  snackPosition: SnackPosition.BOTTOM,
                                                                  colorText: Colors.black,
                                                                  backgroundColor: Colors.yellow);
                                                            }else{
                                                              checkoutController.openCheckout(int.parse(checkoutController.walletBalance.text));
                                                            }
                                                            Get.back();
                                                          },
                                                          child: Container(
                                                            height: size.width * 0.11,
                                                            decoration: BoxDecoration(
                                                                color: secondaryColor,
                                                                borderRadius: BorderRadius.circular(10)
                                                            ),
                                                            child: const Center(child: Text('Add',style: headline)),
                                                          ),
                                                        ),
                                                      ),
                                                    ],),
                                                  SizedBox(
                                                    height: size.width * 0.05,),
                                                  //Wallet history button
                                                  Container(
                                                    padding: const EdgeInsets.symmetric(horizontal: 15),
                                                    height: size.width * 0.14,
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                      color: secondaryColor,
                                                      borderRadius: BorderRadius
                                                          .circular(
                                                        15,
                                                      ),
                                                    ),
                                                    child: Stack(
                                                      children: [
                                                        Center(
                                                            child: InkWell(
                                                              onTap: (() => {
                                                                //TODO: Redirect to Wallet history Page
                                                              }),
                                                              child: const Text(
                                                                'Wallet History',
                                                                style: headline,),
                                                            )),
                                                        const Align(
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child: Icon(
                                                            CupertinoIcons
                                                                .arrow_right_circle,
                                                            size: 25,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],),
                                            )
                                        );
                                      },
                                      child: const Icon(Icons.add_circle_outline))
                                ],
                              ),
                              Obx(() {
                                return Text('₹ ${checkoutController.walletBal}/-',
                                  style: titleStyle,);
                              })
                            ],
                          ),
                          Lottie.asset('lottieFiles/wallet.json'),
                        ],),
                    ),

                    //items List
                    Obx(() {
                      return Flexible(
                        flex: 1,
                        child: ListView.builder(
                            itemCount: cartController.productList.length,
                            itemBuilder: (BuildContext ctx, int index) {
                              return Card(
                                elevation: 5.0,
                                shadowColor: Colors.grey.shade400,
                                child: ListTile(
                                    leading: Container(
                                      height: size.width * 0.15,
                                      width: size.width * 0.15,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                ApiServices().productImageURL + cartController.productList[index].image),
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                    //Item Name
                                    title: Text(
                                      cartController.productList[index]
                                          .productName,
                                      style: headline1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    //Item Price
                                    subtitle: Row(children: [
                                      const Text(
                                        'Quantity: ',
                                        style: subTitle,
                                      ),
                                      Text(
                                        cartController
                                            .productList[index].quantity
                                            .toString(),
                                        style: subTitle,
                                      ),
                                    ],
                                    ),
                                    //Counter Button
                                    trailing: Text(
                                        '₹ ${cartController.productList[index]
                                            .price}/-',
                                        style: buttonTitleStyle)
                                ),
                              );
                            }),
                      );
                    }),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
