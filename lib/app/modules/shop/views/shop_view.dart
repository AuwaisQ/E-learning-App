import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mini_guru/app/modules/cart/controllers/cart_controller.dart';
import 'package:mini_guru/app/modules/cart/views/cart_view.dart';
import 'package:mini_guru/app/modules/checkout/controllers/checkout_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../constants.dart';
import '../../../apiServices/apiServices.dart';
import '../../orderList/views/order_list_view.dart';
import '../controllers/shop_controller.dart';

class ShopView extends GetView<ShopController> {
  ShopController shopController = Get.put(ShopController());
  CartController cartController = Get.put(CartController());
  CheckoutController checkoutController = Get.put(CheckoutController());

  ShopView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    //AppBar
    final appBar = Row(
      children: [
        Expanded(
            flex: 1,
            child: Text( shopController.userName.value.isEmpty
                ? " SHOP"
                : shopController.userName.value, style: headline)),
        const Spacer(),
        Row(
          children: [
            InkWell(
              onTap: () {
                Get.to(const OrderListView());
              },
              child: Image.asset(
                'images/bag.png',
                height: size.width * 0.07,
                width: size.width * 0.07,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 15,),
            InkWell(
              onTap: () {
                cartController.productList.isNotEmpty
                ? Get.to(()=> CartView())
                : Get.snackbar(
                  'Cart Empty',
                  'Please Add Products in the cart',
                  margin: const EdgeInsets.all(20),
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.yellow.withOpacity(0.6),
                );
              },
              child: Badge(
                backgroundColor: redColor,
                alignment: AlignmentDirectional.topStart,
                label: Obx(() {
                  return Text(
                    cartController.productList.length.toString(),
                    style: const TextStyle(fontSize: 10, color: Colors.white,fontWeight: FontWeight.bold),
                  );
                }),
                child: Image.asset(
                  'images/cart.png',
                  height: size.width * 0.07,
                  width: size.width * 0.07,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ],
    );

    //Search TextField
    final searchField = Container(
      padding: const EdgeInsets.only(left: 10, right: 20),
      width: size.width,
      height: size.width / 7,
      decoration: BoxDecoration(
          color: Colors.grey.shade200, borderRadius: BorderRadius.circular(15)),
      child: CupertinoTextField(
        controller: controller.searchController,
        onChanged: (value) {
          controller.filterNow(value);
        },
        padding: const EdgeInsets.only(top: 5, left: 5),
        placeholder: 'Search Product\'s',
        placeholderStyle: subTitle,
        suffix: const Icon(Icons.search),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );

    return RefreshIndicator(
      displacement: 50,
      backgroundColor: primaryColor,
      color: Colors.white,
      strokeWidth: 2,
      onRefresh: () async {
        await Future.delayed(const Duration(milliseconds: 500));
        final prefs = await SharedPreferences.getInstance();
        shopController.getProducts();
        shopController.getCartItems();
        checkoutController.getWalletBal();
        shopController.userName.value = prefs.getString('userName')!;
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
            child: EnterAnimation(Obx(() {
              return Column(
                children: [
                  Flexible(
                      flex: 0,
                      child: Column(
                        children: [
                          //Appbar
                          appBar,
                          SizedBox(height: size.height * 0.02),

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
                                        const SizedBox(width: 5,),
                                        // Add Payment Button
                                        InkWell(
                                            onTap: () {
                                              Get.bottomSheet(
                                                  Container(
                                                    height: 200,
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
                                                                  key: checkoutController.walletKey,
                                                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                                                  controller: checkoutController.walletBalance,
                                                                  keyboardType: TextInputType
                                                                      .number,
                                                                  validator: (value) {
                                                                    if (value!
                                                                        .isEmpty) {
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
                                                                  checkoutController.openCheckout(int.parse(checkoutController.walletBalance.text));
                                                                  Get.back();
                                                                },
                                                                child: Container(
                                                                  height: size.width *
                                                                      0.11,
                                                                  decoration: BoxDecoration(
                                                                      color: secondaryColor,
                                                                      borderRadius: BorderRadius
                                                                          .circular(10)
                                                                  ),
                                                                  child: const Center(
                                                                      child: Text('Add',
                                                                        style: headline,)),
                                                                ),
                                                              ),
                                                            ),
                                                          ],),
                                                        SizedBox(
                                                          height: size.width * 0.05,),
                                                        //Wallet history button
                                                        // Container(
                                                        //   padding: const EdgeInsets
                                                        //       .symmetric(
                                                        //       horizontal: 15),
                                                        //   height: size.width * 0.14,
                                                        //   width: double.infinity,
                                                        //   decoration: BoxDecoration(
                                                        //     color: secondaryColor,
                                                        //     borderRadius: BorderRadius
                                                        //         .circular(
                                                        //       15,
                                                        //     ),
                                                        //   ),
                                                        //   child: Stack(
                                                        //     children: [
                                                        //       Center(
                                                        //           child: InkWell(
                                                        //             onTap: (() =>
                                                        //             {
                                                        //               //TODO: Redirect to Wallet history Page
                                                        //             }),
                                                        //             child: const Text(
                                                        //               'Wallet History',
                                                        //               style: headline,),
                                                        //           )),
                                                        //       const Align(
                                                        //         alignment: Alignment
                                                        //             .centerRight,
                                                        //         child: Icon(
                                                        //           CupertinoIcons
                                                        //               .arrow_right_circle,
                                                        //           size: 25,
                                                        //         ),
                                                        //       )
                                                        //     ],
                                                        //   ),
                                                        // )
                                                      ],),
                                                  )
                                              );
                                            },
                                            child: const Icon(Icons.add_circle_outline))
                                      ],
                                    ),
                                    Obx(() {
                                      return Text('₹ ${checkoutController.walletBal.value}/-',
                                        style: titleStyle,);
                                    })
                                  ],
                                ),
                                Lottie.asset('lottieFiles/wallet.json'),
                              ],),
                          ),

                          //Search Field
                          searchField,
                          SizedBox(height: size.height * 0.02),
                        ],
                      )),
                  SizedBox(height: size.width * 0.01),
                  controller.filteredProductList.isEmpty
                      //Shimmer List
                      ? Flexible(
                          flex: 1,
                          child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisSpacing: 15,
                                mainAxisSpacing: 20,
                                crossAxisCount: 2,
                                childAspectRatio:
                                    size.width * 80 / size.width * 0.01,
                              ),
                              itemCount: 20,
                              itemBuilder: (BuildContext ctx, int index) {
                                return Container(
                                    padding: const EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey.shade400),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Lottie.asset(
                                        'lottieFiles/shimmer.json'));
                              }),
                        )
                      //Product List
                      : Obx(() {
                          return Flexible(
                            flex: 1,
                            child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisSpacing: 15,
                                  mainAxisSpacing: 20,
                                  crossAxisCount: 2,
                                  childAspectRatio:
                                      size.width * 80 / size.width * 0.01,
                                ),
                                itemCount: controller.filteredProductList.length,
                                itemBuilder: (BuildContext ctx, int index) {
                                  return Container(
                                    padding: const EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey.shade400),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        //Image Container
                                        Expanded(
                                          flex: 3,
                                          child: InkWell(
                                              onTap: () => Get.toNamed('/shop-item', arguments: [
                                                        controller.filteredProductList[index].itemId.toString(),
                                                        controller.filteredProductList[index].image,
                                                        controller.filteredProductList[index].productName,
                                                        controller.filteredProductList[index].price,
                                                        controller.filteredProductList[index].description,
                                                      ]),
                                              child: controller.productList[index].image.isEmpty
                                                  ? Container(
                                                      width: size.width,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(color: Colors.grey.shade400),
                                                        borderRadius: BorderRadius.circular(10),
                                                      ),
                                                      child: Lottie.asset('lottieFiles/shimmer.json'),
                                                    )
                                                  : Container(
                                                      decoration: BoxDecoration(
                                                        border: Border.all(color: Colors.grey.shade400),
                                                        borderRadius: BorderRadius.circular(10),
                                                        image: DecorationImage(image: NetworkImage(ApiServices().productImageURL + controller.filteredProductList[index].image), fit: BoxFit.cover),
                                                      ),
                                                    )),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 5),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  controller.filteredProductList[index].productName,
                                                  style: headline1,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                                SizedBox(
                                                    height: size.width * 0.01),
                                                Text('₹ ${controller.filteredProductList[index].price}/-', style: buttonSubTitleStyle),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                }),
                          );
                        }),
                ],
              );
            })),
          ),
        ),
      ),
    );
  }

  // Widget getChip(NameIdModel nameIdBean, int index) {
  //   return Padding(
  //       padding: const EdgeInsets.only(left: 2),
  //       child: ChoiceChip3D(
  //         style: ChoiceChip3DStyle(
  //           topColor: controller.selectedCategory.value == nameIdBean.id
  //               ? secondaryColor
  //               : Colors.grey,
  //           borderRadius: BorderRadius.circular(5),
  //         ),
  //         onSelected: () {
  //           controller.selectedCategory.value = nameIdBean.id;
  //           controller.filterProduct();
  //         },
  //         onUnSelected: () {},
  //         child: Text(
  //           nameIdBean.name,
  //           style: headline1,
  //         ),
  //       ));
  // }
}
