import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_guru/constants.dart';
import '../../../../others/progressHud.dart';
import '../../../apiServices/apiServices.dart';
import '../controllers/shop_item_controller.dart';

class ShopItemView extends GetView<ShopItemController> {
  ShopItemController shopController = Get.put(ShopItemController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ProgressHud(buildUi(context), shopController.isLoading.value);
    });
  }

  Widget buildUi(BuildContext context) {
    final size = MediaQuery.of(context).size;
    //Button
    final addToCart = SizedBox(
      height: size.width * 0.1,
      child: Obx(() {
        return Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Obx(() {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            if (controller.quantity.value == 0) {
                            } else {
                              controller.quantity.value--;
                            }
                          },
                          child: Container(
                            height: size.width * 0.14,
                            decoration: const BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                              ),
                            ),
                            child: const Icon(
                              CupertinoIcons.minus_circle,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Text(
                          controller.quantity.value.toString(),
                          style: headline,
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () => {
                            controller.quantity.value++
                          }, //shopController.itemCount.value++,
                          child: Container(
                            height: size.width * 0.14,
                            decoration: const BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                            ),
                            child: const Icon(
                              CupertinoIcons.plus_circle,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
            SizedBox(width: size.width * 0.01),
            controller.quantity.value == 0
                ? Container()
                : Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () => shopController.addItemGetId(),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          color: secondaryColor,
                          borderRadius: BorderRadius.circular(
                            15,
                          ),
                        ),
                        child: Stack(
                          children: [
                            const Center(
                                child: Text('Add to cart',
                                    style: buttonTitleStyle)),
                            SizedBox(width: size.width * 0.02),
                            const Align(
                                alignment: Alignment.centerRight,
                                child:
                                    Icon(CupertinoIcons.arrow_right, size: 20))
                          ],
                        ),
                      ),
                    ),
                  ),
          ],
        );
      }),
    );
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text( shopController.userName.value.isEmpty
            ? controller.productArgs[2]
            : shopController.userName.value, style: headline),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          height: size.width / 7,
          width: double.infinity,
          child: addToCart,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 80),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: size.width * 1,
                  width: size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.grey.shade300),
                      image: DecorationImage(
                        image: NetworkImage(ApiServices().productImageURL +
                            shopController.productArgs[1]),
                        fit: BoxFit.cover,
                      )),
                ),
                SizedBox(height: size.width * 0.05),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      controller.productArgs[2],
                      style: headline,
                    ),
                    Container(
                      height: size.width * 0.1,
                      width: size.width * 0.3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 2,
                          )
                        ],
                      ),
                      child: Center(
                        child: Text(
                          '₹ ${controller.productArgs[3]}/-',
                          style: buttonTitleStyle,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.width * 0.03,
                ),
                Text(
                  controller.productArgs[4],
                  style: headline1,
                ),
                SizedBox(
                  height: size.width * 0.03,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
