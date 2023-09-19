
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_guru/constants.dart';
import 'package:mini_guru/others/progressHud.dart';
import '../../../apiServices/apiServices.dart';
import '../controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  CartController cartController = Get.put(CartController());

  CartView({super.key});

  @override
  Widget build(BuildContext context){
    return Obx(() {
      return ProgressHud(buildUi(context), cartController.isLoading.value);
    });
  }


  Widget buildUi(BuildContext context) {
    cartController.setCartValue();
    final size = MediaQuery.of(context).size;

    //AppBar
    final appBar = SizedBox(
      height: size.width * 0.15,
      child: Stack(
        children: [
          const Center(
              child: Text(
                'My Cart',
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
        ],
      ),
    );

    //Item Total Button
    final itemTotalButton = Row(
      children: [
        Flexible(
          flex: 5,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            height: size.width / 7,
            width: double.infinity,
            decoration: BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.circular(
                15,
              ),
            ),
            child: Center(
                child: Text.rich(TextSpan(
                    text: 'Total : ',
                    style: buttonTitleStyle,
                    children: [
                      TextSpan(
                        text: '₹${cartController.cartValue.value
                            .toString()}/-',
                        style: headline,
                      )
                    ]))),
          ),
        ),
        const SizedBox(width: 15),
        Flexible(
          flex: 1,
          child: InkWell(
            onTap: ()=> Get.toNamed('/display-address'),
            child: Container(
              height: size.width / 7,
              width: double.infinity,
              decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: BorderRadius.circular(150),
              ),
              child: const Center(
                child: Icon(
                  CupertinoIcons.arrow_right_circle,
                  size: 55,
                ),
              ),
            ),
          ),
        ),
      ],
    );

    return RefreshIndicator(
      color: secondaryColor,
      displacement: 100,
      onRefresh: ()async{
        cartController.getCartItems();
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
                          SizedBox(height: size.width * 0.03),
                        ],
                      ),
                    ),
                    //items List
                    Obx(() {
                      return Flexible(
                        flex: 1,
                        child: EnterAnimation(ListView.builder(
                              itemCount: controller.productList.length,
                              itemBuilder: (BuildContext ctx, int index) {
                                return Badge(
                                  alignment: AlignmentDirectional.topStart,
                                  largeSize: 25,
                                  label: InkWell(
                                    onTap: () {
                                      controller.showConfirmDialog(context, index);
                                    },
                                    child: const Icon(Icons.delete_outline, color: Colors.white, size: 20,),),
                                  child: Card(
                                    elevation: 5.0,
                                    shadowColor: Colors.grey.shade400,
                                    child: ListTile(
                                      leading: Container(
                                        height: size.width * 0.15,
                                        width: size.width * 0.15,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          image: DecorationImage(
                                              image: NetworkImage(ApiServices().productImageURL + controller.productList[index].image), fit: BoxFit.cover),
                                        ),
                                      ),

                                      //Item Name
                                      title: Text(
                                        controller.productList[index].productName,
                                        style: headline1,
                                        overflow: TextOverflow.ellipsis,
                                      ),

                                      //Item Price
                                      subtitle: Text('₹ ${controller.productList[index].price}/-', style: buttonTitleStyle),

                                      //Counter Button
                                      trailing: Container(
                                        height: size.width * 0.1,
                                        width: size.width * 0.2,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey.shade400),
                                          borderRadius: BorderRadius.circular(7),
                                          // color: primaryColor,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              InkWell(
                                                  onTap: () {
                                                    if (int.parse(cartController.productList[index].quantity) == 1) {} else {
                                                      cartController.decreaseQuantity(cartController.productList[index].productId);
                                                    }
                                                  },
                                                  child: const Icon(
                                                    CupertinoIcons.minus_circle,
                                                    color: Colors.black,
                                                    size: 20,
                                                  )),
                                              Obx(() {
                                                return Text(
                                                  cartController.productList[index].quantity.toString(),
                                                  style: headline,
                                                );
                                              }),
                                              InkWell(
                                                  onTap: () {
                                                    cartController.increaseQuantity(cartController.productList[index].productId);
                                                  },
                                                  child: const Icon(
                                                    CupertinoIcons.plus_circle,
                                                    color: Colors.black,
                                                    size: 20,
                                                  ))
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
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
