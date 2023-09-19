import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:mini_guru/app/modules/home/controllers/home_controller.dart';
import 'package:mini_guru/others/progressHud.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../constants.dart';
import '../../../apiServices/apiServices.dart';
import '../../appProfile/views/app_profile_view.dart';
import '../controllers/project_list_controller.dart';

class ProjectListView extends GetView<ProjectListController> {
  ProjectListController projectController = Get.put(ProjectListController());
  HomeController homeController = Get.put(HomeController());
  ProjectListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ProgressHud(buildUi(context), controller.isLoading.value);
    });
  }

  Widget buildUi(BuildContext context) {
    const String demoImage = 'https://t3.ftcdn.net/jpg/02/22/85/16/360_F_222851624_jfoMGbJxwRi5AWGdPgXKSABMnzCQo9RN.jpg';
    final size = MediaQuery
        .of(context)
        .size;
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

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SafeArea(child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 5),
          child: EnterAnimation(Column(children: [
            appBar,
            SizedBox(height: size.width * 0.05),
            //TabBar Tab's
            Expanded(flex: 0, child: Container(
              margin: const EdgeInsets.all(0),
              width: size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: redColor, width: 2.5),
              ),
              child: const Align(
                alignment: Alignment.center,
                child: TabBar(
                  labelStyle: headline,
                  labelColor: redColor,
                  indicatorColor: redColor,
                  unselectedLabelColor: Colors.grey,
                  unselectedLabelStyle: headline1,
                  indicatorWeight: 5,
                  indicatorSize: TabBarIndicatorSize.tab,
                  isScrollable: true,
                  tabs: [
                    Tab(
                      text: 'Ongoing',
                    ),
                    Tab(
                      text: 'Completed',
                    ),
                  ],
                ),
              ),
            ),
            ),
            SizedBox(height: size.width * 0.06),
            Obx(() {
              return Expanded(
                  flex: 1,
                  child: TabBarView(
                    physics: const ScrollPhysics(),
                    children: [
                      //----OnGoing-Projects----
                      RefreshIndicator(
                        onRefresh: () async {
                          controller.getOngoingProjectList();
                        },
                        child: ListView.builder(
                            itemCount: projectController.onGoingProjectList.length,
                            itemBuilder: (BuildContext ctx, int i) {
                              int itemCount = projectController.onGoingProjectList.length;
                              int index = itemCount - 1 - i;
                              return InkWell(
                                onTap: () {
                                  Get.toNamed('/update-project',arguments: [
                                    projectController.onGoingProjectList[index].id,
                                    projectController.onGoingProjectList[index].title,
                                    projectController.onGoingProjectList[index].description,
                                    projectController.onGoingProjectList[index].projectImage,
                                    projectController.onGoingProjectList[index].startDate,
                                    projectController.onGoingProjectList[index].endDate,
                                  ]);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  margin: const EdgeInsets.only(bottom: 20),
                                  height: size.width * 0.8,
                                  width: size.width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  child: Column(
                                    children: [
                                      //Image & Title,Subtitle
                                      Expanded(
                                        flex: 1,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            //Project Image
                                            Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              //Title
                                              Text(projectController.onGoingProjectList[index].title,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: titleStyle,
                                                  maxLines: 2),
                                              //Description
                                              Text(
                                                  projectController.onGoingProjectList[index].description,
                                                  style: subTitle,
                                                  maxLines: 5,
                                                  overflow: TextOverflow.ellipsis),
                                            ],),
                                            //Title & Description
                                            Expanded(flex: 2, child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                //Image
                                                Expanded(
                                                  child: Container(
                                                    margin: const EdgeInsets.symmetric(vertical: 5),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(color: Colors.grey.shade300),
                                                        borderRadius: BorderRadius.circular(10),
                                                        image: DecorationImage(
                                                            image: NetworkImage(ApiServices().projectImageURl + projectController.onGoingProjectList[index].projectImage),
                                                            fit: BoxFit.cover
                                                        )
                                                    ),
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        const Text(
                                                          'Start Date',
                                                          style: buttonSubTitleStyle,),
                                                        Text(DateFormat(
                                                            'dd-MM-yyyy')
                                                            .format(
                                                            projectController
                                                                .onGoingProjectList[index]
                                                                .startDate),
                                                          style: subTitle,),
                                                      ],),
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        const Text(
                                                          'End Date',
                                                          style: buttonSubTitleStyle,),
                                                        Text(DateFormat(
                                                            'dd-MM-yyyy')
                                                            .format(
                                                            projectController
                                                                .onGoingProjectList[index]
                                                                .endDate),
                                                          style: subTitle,),
                                                      ],),
                                                  ],
                                                ),
                                              ],)),
                                          ],),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),

                      //----Completed-Projects----
                      RefreshIndicator(
                        onRefresh: () async {
                          controller.getCompletedProjectList();
                        },
                        child: ListView.builder(
                            itemCount: projectController.completedProjectList.length,
                            itemBuilder: (BuildContext ctx, index) {
                              return InkWell(
                                onTap: (){
                                  print("Video Url Value - ${projectController.completedProjectList[index].youtubeUrl.toString()}");
                                  if(projectController.completedProjectList[index].youtubeUrl == false){
                                    print('No URL Available');
                                    Get.snackbar(
                                      'Video Unavailable',
                                      'Video unavailable Please Try Again in some time',
                                      duration: const Duration(seconds: 5),
                                      margin: const EdgeInsets.all(20),
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor: Colors.red,
                                      colorText: Colors.white,
                                    );
                                  }else{
                                    launchUrl(Uri.parse(projectController.completedProjectList[index].youtubeUrl.toString()),);
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  margin: const EdgeInsets.only(bottom: 20),
                                  height: size.width * 0.8,
                                  width: size.width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            //Project Image
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                //Title
                                                Text(projectController.completedProjectList[index].title,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: titleStyle,
                                                    maxLines: 2),
                                                //Description
                                                Text(
                                                    projectController.completedProjectList[index].description,
                                                    style: subTitle,
                                                    maxLines: 5,
                                                    overflow: TextOverflow.ellipsis),
                                              ],),
                                            //Title & Description
                                            Expanded(flex: 2, child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                //Image
                                                Expanded(
                                                  child: Container(
                                                    margin: const EdgeInsets.symmetric(vertical: 5),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(color: Colors.grey.shade300),
                                                        borderRadius: BorderRadius.circular(10),
                                                        image: DecorationImage(
                                                            image: NetworkImage(ApiServices().projectImageURl + projectController.completedProjectList[index].projectImage),
                                                            fit: BoxFit.cover
                                                        )
                                                    ),
                                                  ),
                                                ),
                                                const Padding(
                                                  padding: EdgeInsets.only(right: 10),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(
                                                        'Tap to watch on youtube', style: buttonSubTitleStyle,),
                                                      Icon(Icons.ondemand_video_outlined)
                                                    ],
                                                  ),
                                                ),
                                              ],)),
                                          ],),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                    ],
                  ));
            }),
          ],),
          ),
        ),),
      ),
    );
  }

  double setPercent(double asm) {
    double vvel = asm / 100;
    return vvel;
  }

  setColor(int asm) {
    if (asm < 40) {
      return Colors.red;
    } else if (asm < 70) {
      return Colors.yellow;
    } else {
      return Colors.green;
    }
  }

  Widget getEndDate(String ddate) {
    print("dDateHere.$ddate.");
    DateTime tempDate = DateFormat("dd/MM/yyyy").parse(ddate);
    DateTime dob = DateTime.parse("2022-10-10");
    Duration dur = tempDate.difference(DateTime.now());
    String differenceInYears = (dur.inDays).floor().toString();
    print("$ddate#$differenceInYears");

    if (int.parse(differenceInYears) < 3) {
      return Shimmer.fromColors(baseColor: Colors.grey,
          highlightColor: Colors.red,
          child: Text(ddate, style: const TextStyle(color: Colors.black),));
    } else {
      return Text(ddate, style: const TextStyle(color: Colors.green),);
    }
  }

}
