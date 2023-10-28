// ignore_for_file: must_be_immutable

import 'package:d_chart/d_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mini_guru/app/modules/home/controllers/home_controller.dart';
import 'package:mini_guru/app/modules/projectList/controllers/project_list_controller.dart';
import '../../../../constants.dart';
import '../../appProfile/views/app_profile_view.dart';
import '../controllers/progress_report_controller.dart';

class ProgressReportView extends GetView<ProgressReportController> {
  ProjectListController projectListController = Get.put(ProjectListController());
  HomeController homeController = Get.put(HomeController());
  ProgressReportView({super.key});

  @override
  Widget build(BuildContext context) {
    ProgressReportController controller = Get.put(ProgressReportController());

    final size = MediaQuery.of(context).size;

    //App Bar
    final appBar = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Hello,', style: subTitle),
            Text(
                homeController.userName.value == ''
                    ? 'User Name'
                    : '${homeController.userName.value} 👑',
                style: headline),
          ],
        ),
        //Actions
        Align(
          alignment: Alignment.centerRight,
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  if (kDebugMode) {print("ID-${homeController.userId.value}");}
                  Get.to(() => AppProfileView(), transition: Transition.downToUp);
                },
                child: const Center(
                  child: Icon(
                    CupertinoIcons.person_alt_circle_fill,
                    color: Colors.black,
                    size: 33,
                  ),
                ),
              ),
              SizedBox(width: size.width * 0.02),
            ],
          ),
        )
      ],
    );

    //Goin Score Card
    final scoreCard = Row(
      children: [
        //Score
        Expanded(
          flex: 1,
          child: Container(
            margin: const EdgeInsets.only(bottom: 10, right: 5, left: 5),
            padding: const EdgeInsets.only(top: 10, right: 10, left: 10, bottom: 5),
            height: Get.width * 0.2,
            decoration: BoxDecoration(
              // color: secondaryColor,
                gradient: const LinearGradient(
                    colors: [primaryColor, greenColor],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black, width: 1.5)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Score',
                        style: headline,
                      ),
                      Row(
                        children: [
                          const Text('G ',style: TextStyle(color: secondaryColor, fontSize: 20, fontWeight: FontWeight.bold),),
                          Obx(() {
                            return Text(homeController.goinData.value, style: headline);
                          }),
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex:1,
                  child: Lottie.network('https://assets7.lottiefiles.com/packages/lf20_c6s0ojkl.json'),
                )
              ],
            ),
          ),
        ),

        //Wallet
        Expanded(
          flex: 1,
          child: Container(
            margin: const EdgeInsets.only(bottom: 10, right: 5, left: 5),
            padding: const EdgeInsets.only(top: 10, right: 10, left: 10, bottom: 5),
            height: Get.width * 0.2,
            width: double.infinity,
            decoration: BoxDecoration(
              // color: secondaryColor,
                gradient: const LinearGradient(
                    colors: [primaryColor, greenColor],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black, width: 1.5)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Wallet',
                        style: headline,
                      ),
                      Row(
                        children: [
                          const Icon(Icons.currency_rupee_outlined, color: secondaryColor,size: 20,),
                          Obx(()=> Text('${homeController.walletBal.value}/-', style: headline),),
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Lottie.network('https://assets2.lottiefiles.com/packages/lf20_sMFNaCTfdu.json'),
                )
              ],
            ),
          ),
        ),
      ],
    );

    return Scaffold(
      backgroundColor: const Color(0xFFEFEEEE),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
            child: RefreshIndicator(
              color: secondaryColor,
              displacement: 100,
              onRefresh: () async {
                controller.getLikes();
              },
              child: SingleChildScrollView(
                child: EnterAnimation(Column(
                  children: [
                    appBar,
                    SizedBox(height: size.width * 0.05),
                    scoreCard,
                    SizedBox(height: size.width * 0.02),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //Project Health Card
                        Container(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          width: size.width,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade400),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withOpacity(0.8),
                                offset: const Offset(-6.0, -6.0),
                                blurRadius: 16.0,
                              ),
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                offset: const Offset(6.0, 6.0),
                                blurRadius: 16.0,
                              ),
                            ],
                            color: const Color(0xFFEFEEEE),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          // decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(20),
                          //     border: Border.all(color: Colors.grey)),
                          child: Column(children: [
                            const Text(
                              'Score card  📊', style: titleStyle,),
                            SizedBox(height: size.width * 0.01),
                            const Divider(thickness: 1,),
                            SizedBox(height: size.width * 0.01),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Total Projects', style: headline1,),
                                  Container(
                                    height: size.width * 0.08,
                                    width: size.width * 0.15,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(color: Colors.grey),
                                    ),
                                    child: Center(child: Obx(() {
                                      return Text(
                                        projectListController.totalProject.value.toString(),
                                        style: buttonTitleStyle,);
                                    })),
                                  ),
                                ],),
                            ),
                            SizedBox(height: size.width * 0.01),
                            const Divider(thickness: 1,),
                            //Completed Projects Info.
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  const Text(
                                    'Live on Channel', style: headline1,),
                                  Container(
                                    height: size.width * 0.08,
                                    width: size.width * 0.15,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(color: Colors.grey),
                                    ),
                                    child: Center(child: Obx(() {
                                      return Text(
                                        controller.completeProject.value
                                            .toString(),
                                        style: buttonTitleStyle,);
                                    })),
                                  ),
                                ],),
                            ),
                            SizedBox(height: size.width * 0.01),
                          ],),
                        ),
                        SizedBox(height: size.width * 0.05),

                        //Material Graph
                        Container(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          width: size.width,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade400),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withOpacity(0.8),
                                offset: const Offset(-6.0, -6.0),
                                blurRadius: 16.0,
                              ),
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                offset: const Offset(6.0, 6.0),
                                blurRadius: 16.0,
                              ),
                            ],
                            color: const Color(0xFFEFEEEE),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Column(children: [
                            //Comments Percentage
                            const Padding(
                              padding: EdgeInsets.only(
                                  left: 10, right: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Material Used Graph', style: headline1,),
                                ],),
                            ),
                            SizedBox(height: size.width * 0.01),
                            const Divider(thickness: 1),
                            //Material Used Graph
                            Obx(() {
                              return Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: SizedBox(
                                  height: size.width * 1.0,
                                  child: DChartBar(
                                    data: [
                                      {
                                        'id': '',
                                        'data': controller.likeDataList.map((element) {
                                          return {
                                            'domain': element['domain'],
                                            'measure': element['measure']
                                          };
                                        }).toList()
                                      },
                                    ],
                                    domainLabelPaddingToAxisLine: 15,
                                    axisLineTick: 2,
                                    axisLinePointTick: 2,
                                    axisLinePointWidth: 7,
                                    axisLineColor: Colors.black,
                                    measureLabelPaddingToAxisLine: 10,
                                    verticalDirection: false,
                                    barColor: (barData, index, id) => primaryColor,
                                    showBarValue: true,
                                  ),
                                ),
                              );
                            }),
                          ],),
                        ),
                        SizedBox(height: size.width * 0.2),
                        // Container(
                        //   padding: const EdgeInsets.only(top: 10, bottom: 10),
                        //   width: size.width,
                        //   decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(20),
                        //       border: Border.all(color: Colors.grey)),
                        //   child: Column(children: [
                        //     //Comments Percentage
                        //     Padding(
                        //       padding: const EdgeInsets.only(
                        //           left: 10, right: 10),
                        //       child: Row(
                        //         mainAxisAlignment: MainAxisAlignment
                        //             .spaceBetween,
                        //         children: [
                        //           Obx(() {
                        //             return Text(controller.projectTitle.value,
                        //               style: headline1,);
                        //           }),
                        //         ],),
                        //     ),
                        //     SizedBox(height: size.width * 0.01),
                        //     const Divider(thickness: 1),
                        //     //Material Used Graph
                        //     Obx(() {
                        //       return Padding(
                        //         padding: const EdgeInsets.only(left: 15),
                        //         child: SizedBox(
                        //           height: size.width * 0.5,
                        //           child: DChartBar(
                        //             data: [
                        //               {
                        //                 'id': 'Bar',
                        //                 'data': controller.likeDataList.map((
                        //                     element) {
                        //                   return {
                        //                     'domain': element['domain'],
                        //                     'measure': element['measure']
                        //                   };
                        //                 }).toList()
                        //               },
                        //             ],
                        //             domainLabelPaddingToAxisLine: 16,
                        //             axisLineTick: 2,
                        //             axisLinePointTick: 2,
                        //             axisLinePointWidth: 10,
                        //             axisLineColor: Colors.black,
                        //             measureLabelPaddingToAxisLine: 20,
                        //             barColor: (barData, index,
                        //                 id) => primaryColor,
                        //             showBarValue: true,
                        //           ),
                        //         ),
                        //       );
                        //     }),
                        //   ],),
                        // ),
                      ],),
                  ],
                )),
              ),
            ),
          ),
        ));
  }
}
