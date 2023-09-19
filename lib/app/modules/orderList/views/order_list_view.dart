import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import '../controllers/order_list_controller.dart';
import 'package:mini_guru/constants.dart';

class OrderListView extends GetView<OrderListController> {
  const OrderListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OrderListController controller = Get.put(OrderListController());
    final size = MediaQuery.of(context).size;
    final appBar = SizedBox(
      height: size.width * 0.1,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 5),
        child: Stack(
          children: [
            InkWell(
              onTap: ()=> Get.back(),
              child: const Align(
                  alignment: Alignment.bottomLeft,
                  child: Icon(Icons.arrow_back,color: Colors.black,)),),
            const Align(
                alignment: Alignment.bottomCenter,
                child: Text('Order Detail\'s', style: titleStyle)),
            Align(
              alignment: Alignment.topRight,
              child: Lottie.network(
                  'https://assets5.lottiefiles.com/packages/lf20_65fiagjg.json',
                  width: size.width * 0.15,
                  fit: BoxFit.cover
              ),
            ),
          ],
        ),
      ),
    );

    return DefaultTabController(
      length: 2,
      child: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: EnterAnimation(Column(
                children: [
                  appBar,
                  SizedBox(height: size.width * 0.05),
                  //TabBar Tab's
                  Expanded(flex: 0,child: Container(
                      margin: const EdgeInsets.all(5),
                      width: size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: primaryColor, width: 2.5),
                      ),
                      child: const Align(
                        alignment: Alignment.center,
                        child: TabBar(
                          labelStyle: headline,
                          labelColor: primaryColor,
                          indicatorColor: primaryColor,
                          unselectedLabelColor: Colors.grey,
                          unselectedLabelStyle: headline1,
                          indicatorWeight: 5,
                          indicatorSize: TabBarIndicatorSize.tab,
                          isScrollable: true,
                          tabs: [
                            Tab(
                              text: 'Pending Orders',
                            ),
                            Tab(
                              text: 'Completed Orders',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: size.width * 0.05,),
                  //TabBar View's
                  Obx(() {return Expanded( flex: 1,child: TabBarView(
                        children: [
                          //Pending Order List
                          controller.pendingOrderList.isEmpty
                          ? Align(
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                Lottie.network('https://assets8.lottiefiles.com/packages/lf20_WpDG3calyJ.json'),
                                const Text(
                                  'No Orders to show yet',
                                  style: subTitle,
                                )
                              ],
                            ),
                          )
                          : ListView.builder(
                              itemCount: controller.pendingOrderList.length,
                              itemBuilder: (BuildContext context, index){
                                return Container(
                                  width: size.width,
                                  margin: const EdgeInsets.only(
                                      left: 10, right: 10, bottom: 15),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  child: Column(children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text('Item Total:', style: headline1),
                                        Text('₹ ${controller.pendingOrderList[index].ordertotal}/-', style: buttonSubTitleStyle),
                                      ],),
                                    const Divider(),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text('Order Date:', style: headline1),
                                        Text(DateFormat('yyyy-MM-dd').format(controller.pendingOrderList[index].orderdate),
                                            style: buttonSubTitleStyle),
                                      ],),
                                    const Divider(),
                                    const Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Text('Order Status:', style: headline1),
                                        Text('Pending', style: TextStyle(
                                            color: redColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),),
                                      ],),
                                    const Divider(),
                                    ExpandableNotifier(
                                        child: ScrollOnExpand(
                                          scrollOnExpand: true,
                                          scrollOnCollapse: false,
                                          child: ExpandablePanel(
                                            header: const Text(
                                              'Order Detail\'s',
                                              style: headline1,
                                            ),
                                            collapsed: Container(),
                                            expanded: Container(
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius
                                                    .circular(10),
                                                border: Border.all(
                                                    color: Colors.black),
                                              ),
                                              child: Column(children: List.generate(controller.pendingOrderList[index].productdetails.length, (i) => Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text('${controller.pendingOrderList[index].productdetails[i].name}(${controller.pendingOrderList[index].productdetails[i].quantity})',style: const TextStyle(fontSize: 14)),
                                                      Text('${controller.pendingOrderList[index].productdetails[i].price}/-',style: const TextStyle(fontSize: 14)),
                                                    ],),
                                                  const Divider()
                                                ],
                                              ),)
                                              ),
                                            ),
                                            builder: (_, collapsed, expanded) {
                                              return Expandable(
                                                collapsed: collapsed,
                                                expanded: expanded,
                                              );
                                            },
                                          ),
                                        )),
                                  ],),
                                );
                              },
                          ),

                          //Completed Order List
                          ListView.builder(
                            itemCount: controller.completeOrderList.length,
                            itemBuilder: (BuildContext context, index){
                              return Container(
                                width: size.width,
                                margin: const EdgeInsets.only(
                                    left: 10, right: 10, bottom: 15),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: Column(children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Item Total:', style: headline1),
                                      Text('₹ ${controller.completeOrderList[index].ordertotal}/-',
                                          style: buttonSubTitleStyle),
                                    ],),
                                  const Divider(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      const Text('Order Date:', style: headline1),
                                      Text(DateFormat('yyyy-MM-dd').format(controller.completeOrderList[index].orderdate),
                                          style: buttonSubTitleStyle),
                                    ],),
                                  const Divider(),
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Text('Order Status:', style: headline1),
                                      Text('Pending', style: TextStyle(
                                          color: redColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),),
                                    ],),
                                  const Divider(),
                                  ExpandableNotifier(
                                      child: ScrollOnExpand(
                                        scrollOnExpand: true,
                                        scrollOnCollapse: false,
                                        child: ExpandablePanel(
                                          header: const Text(
                                            'Order Detail\'s',
                                            style: headline1,
                                          ),
                                          collapsed: Container(),
                                          expanded: Container(
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius
                                                  .circular(10),
                                              border: Border.all(
                                                  color: Colors.black),
                                            ),
                                            child: Column(children:
                                            List.generate(controller.completeOrderList.length, (index) => Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text('${controller.completeOrderList[index].productdetails[index].name}(${controller.completeOrderList[index].productdetails[index].quantity})',style: const TextStyle(fontSize: 14)),
                                                    Text('${controller.completeOrderList[index].productdetails[index].price}/-',style: const TextStyle(fontSize: 14)),
                                                  ],),
                                                const Divider()
                                              ],
                                            ),)
                                            ),
                                          ),
                                          builder: (_, collapsed, expanded) {
                                            return Expandable(
                                              collapsed: collapsed,
                                              expanded: expanded,
                                            );
                                          },
                                        ),
                                      )),
                                ],),
                              );
                            },
                          ),
                        ],
                      ),);}),
                ],
              ),
              ),
            ),
          )),
    );
  }
}

