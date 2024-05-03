import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mini_guru/app/modules/courseLessons/views/course_lessons_view.dart';
import 'package:mini_guru/constants.dart';
import 'package:mini_guru/others/progressHud.dart';
import '../../appProfile/views/app_profile_view.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeController homeController = Get.put(HomeController());

  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ProgressHud(buildUi(context), homeController.isLoading.value);
    });
  }

  Widget buildUi(BuildContext context) {

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
                          Obx(() {
                            return Text('${homeController.walletBal.value}/-', style: headline);
                          }),
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

    //UI
    return RefreshIndicator(
      color: secondaryColor,
      displacement: 100,
      onRefresh: () async {
        homeController.getYoutubeVideos();
        homeController.getGoinData();
        homeController.getUserData();
        homeController.getWalletBal();
      },
      child: Scaffold(
          body: SafeArea(
            child: Padding(
              padding:
              const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 5),
              child: EnterAnimation(
                Stack(
                  children: [
                    Column(
                      children: [
                        //Appbar, Search, Score, wallet & Filter
                        Expanded(
                          flex: 0,
                          child: Column(
                            children: [
                              appBar,
                              SizedBox(
                                height: Get.width * 0.04,
                              ),
                              scoreCard,
                            ],
                          ),
                        ),
                        //Video List's
                        Obx(() {
                          return Expanded(
                              flex: 1,
                              child: EnterAnimation(GridView.builder(
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 1.3,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 20,
                                      crossAxisCount: 1,
                                    ),
                                    itemCount: homeController.videosList.length,
                                    itemBuilder: (BuildContext ctx, int index) {
                                      return Container(
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.grey.shade600),
                                            borderRadius: BorderRadius.circular(10)),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            //Video Widget
                                            Expanded(
                                              child: InkWell(
                                                onTap: () =>
                                                    Get.to(()=>CourseLessonsView(),arguments: [
                                                      homeController.videosList[index].id,
                                                      homeController.videosList[index].title,
                                                      homeController.videosList[index].description,
                                                    ],
                                                        transition: Transition.downToUp),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(color: Colors.grey),
                                                    borderRadius:
                                                    BorderRadius.circular(7),
                                                    image: DecorationImage(
                                                        image: NetworkImage(homeController.videosList[index].thumbnailUrl),
                                                        fit: BoxFit.cover),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                SizedBox(height: size.width * 0.01),
                                                Padding(
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: Text(controller.videosList[index].title, style: headline1),
                                                ),
                                                SizedBox(height: size.width * 0.01),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                              ));
                        }),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
