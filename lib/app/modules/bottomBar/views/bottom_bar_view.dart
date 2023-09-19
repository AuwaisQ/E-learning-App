import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_guru/app/modules/bottomBar/controllers/bottom_bar_controller.dart';
import 'package:mini_guru/app/modules/home/views/home_view.dart';
import 'package:mini_guru/app/modules/myProjects/views/my_projects_view.dart';
import 'package:mini_guru/app/modules/projectList/views/project_list_view.dart';
import 'package:mini_guru/app/modules/shop/views/shop_view.dart';
import 'package:mini_guru/constants.dart';
import 'package:stylish_bottom_bar/model/bar_items.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import '../../progressReport/views/progress_report_view.dart';

class BottomBarView extends GetView<BottomBarController>
{
  BottomBarController barController = Get.put(BottomBarController());

  BottomBarView({super.key});
  @override
  Widget build(BuildContext context)
  {
    final size = MediaQuery.of(context).size;
    Future<bool> showExitPopup() async {
      return await
      showDialog(
        //show confirm dialogue
        //the return value will be from "Yes" or "No" options
        context: context,
        builder: (context) => AlertDialog(
          title: Row(
            children: [
              const Icon(Icons.exit_to_app,color: secondaryColor,),
              const SizedBox(width: 10,),
              Text("Exit App".tr,style: const TextStyle(fontFamily: "Varela")),
            ],
          ),
          elevation: 5.0,
          content: Text("Do you want to exit from the app".tr,style: const TextStyle(fontFamily: "Varela")),
          actions:
          [
            ElevatedButton(
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.green),),
              child: Text("Cancel".tr,style: const TextStyle(fontFamily: "Varela",color: Colors.white),),
              onPressed:  ()
              {
                Navigator.pop(context);
              },
            ),
            ElevatedButton(
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.red),),
              child: Text("Exit".tr,style: const TextStyle(fontFamily: "Varela",color: Colors.white)),
              onPressed:() async
              {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        ),
      ) ?? false; //if showDialog had returned null, then return false
    }
    return WillPopScope(
        onWillPop: showExitPopup,
        child: Scaffold(
          extendBody: true,
      resizeToAvoidBottomInset: false,
      body: PageView(
        controller: barController.pageController,
        children: [
          HomeView(),
          ProgressReportView(),
          ProjectListView(),
          ShopView(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=> Get.to(MyProjectsView(),transition: Transition.downToUp),
        backgroundColor: primaryColor,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Image.asset('images/plus.png'),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: Obx(() {
        return SizedBox(
          height: size.width * 0.21,
          width: size.width,
          child: StylishBottomBar(
            option: AnimatedBarOptions(
              barAnimation: BarAnimation.fade,
              iconStyle: IconStyle.animated,
              // opacity: 0.3,
            ),
            currentIndex: barController.currentIndex.value,
            onTap: (index) {
              barController.currentIndex.value = index;
              barController.pageController.jumpToPage(index);
            },
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            elevation: 10,
            fabLocation: StylishBarFabLocation.end,
            //new
            hasNotch: true,
            //optional, uses theme color if not specified
            items: [
              BottomBarItem(
                  icon: const Icon(CupertinoIcons.house_alt),
                  selectedIcon: const Icon(CupertinoIcons.house_alt),
                  selectedColor: primaryColor,
                  title: const Text("Home",style: TextStyle(fontSize: 12),)),

              BottomBarItem(
                  icon: const Icon(CupertinoIcons.graph_circle),
                  selectedIcon: const Icon(CupertinoIcons.graph_circle),
                  selectedColor: secondaryColor,
                  title: const Text("Report",style: TextStyle(fontSize: 12))),

              BottomBarItem(
                  icon: const Icon(Icons.folder_open),
                  selectedIcon: const Icon(Icons.folder_open),
                  selectedColor: greenColor,
                  title: const Text("Project's",style: TextStyle(fontSize: 12))),

              BottomBarItem(
                  icon: const Icon(CupertinoIcons.shopping_cart),
                  selectedIcon: const Icon(CupertinoIcons.shopping_cart),
                  selectedColor: Colors.red,
                  title: const Text("Shop",style: TextStyle(fontSize: 12))),
            ],
          ),
        );
      }))
    );
  }
}
