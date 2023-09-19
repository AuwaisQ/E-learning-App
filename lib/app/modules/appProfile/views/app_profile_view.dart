import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mini_guru/app/apiServices/apiServices.dart';
import 'package:mini_guru/others/progressHud.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../constants.dart';
import '../controllers/app_profile_controller.dart';

class AppProfileView extends GetView<AppProfileController> {
  AppProfileController profileController = Get.put(AppProfileController());
  AppProfileView({super.key});

  @override
  Widget build(BuildContext context){
    return Obx(() {
      return ProgressHud(buildUi(context), profileController.isLoading.value);
    });
  }

  Widget buildUi(BuildContext context) {
    final size = MediaQuery.of(context).size;

    //Settings Widgets
    Widget settingsWidget({
      required GestureTapCallback onTap,
      required String title,
      required Color iconBackColor,
      required Color iconColor,
      required IconData iconData}) {
      return InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(10),
          width: size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      height: size.width * 0.12,
                      width: size.width * 0.12,
                      decoration: BoxDecoration(
                        color: iconBackColor,
                        borderRadius: BorderRadius.circular(150),
                      ),
                      child: Center(
                        child: FaIcon(
                          iconData,
                          color: iconColor,
                          size: 25,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.05,
                  ),
                  Text(title, style: headline),
                ],
              ),
              const Icon(Icons.arrow_forward_ios)
            ],
          ),
        ),
      );
    }
    return RefreshIndicator(
      onRefresh: ()async{
        profileController.getUserData();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          elevation: 0.0,
          leading: InkWell(
            onTap: ()=>Get.back(),
              child: const Icon(Icons.arrow_back_ios_new,color: Colors.black,)),
          title: const Text(
            'Profile🌟',
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: InkWell(
                  onTap: (){profileController.openEditSheet();},
                  child: const Icon(FontAwesomeIcons.edit ,color: Colors.black,size: 25,)),
            ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: SingleChildScrollView(
              child: EnterAnimation(
                  Column(
                    children: [
                      //Profile View
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Lottie.network('https://assets6.lottiefiles.com/packages/lf20_4cuwsw1e.json',width: 230,height: 230,fit: BoxFit.cover),
                          //Profile Photo
                          CircleAvatar(
                            backgroundColor: primaryColor,
                            radius: 100,
                            child: CircleAvatar(
                              radius: 95,
                              backgroundImage: NetworkImage(
                                profileController.userImage.value == ''
                                ? 'https://t3.ftcdn.net/jpg/02/22/85/16/360_F_222851624_jfoMGbJxwRi5AWGdPgXKSABMnzCQo9RN.jpg'
                                : ApiServices().userImageURL + profileController.userImage.value,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size.width * 0.01),
                      //UserName
                      Align(
                        alignment: Alignment.center,
                        child: Text(profileController.userName.value == ''
                            ? 'User-Name'
                                :profileController.userName.value, style: titleStyle),
                      ),
                      SizedBox(height: size.width * 0.01),
                      //PhoneNumber
                      Align(
                        alignment: Alignment.center,
                        child: Text(profileController.userMobile.value == ''
                          ? 'Phone-Number'
                            : '+91-${profileController.userMobile.value}', style: subTitle),
                      ),
                      SizedBox(height: size.width * 0.05),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Settings ⚙', style: titleStyle),
                      ),
                      SizedBox(
                        height: size.width * 0.03,
                      ),
                      //Achievement
                      settingsWidget(
                          title: 'Share Us',
                          iconBackColor: secondaryColor,
                          iconColor: Colors.white,
                          iconData: Icons.share_sharp,
                          onTap: () async {
                            Share.share('Share Us with Your Friend\'s & Family - https://play.google.com/store/apps/details?id=com.Tlabs.miniGuru');
                          }),
                      SizedBox(
                        height: size.width * 0.03,
                      ),
                      //About us
                      settingsWidget(
                          title: 'About Us',
                          iconBackColor: redColor,
                          iconColor: Colors.white,
                          iconData: FontAwesomeIcons.listUl,
                          onTap: () {
                            launchUrl(Uri.parse('https://miniguru.in'));
                          }),
                      SizedBox(
                        height: size.width * 0.03,
                      ),
                      //Privacy Policy
                      settingsWidget(
                          title: 'Privacy Policy',
                          iconBackColor: greenColor,
                          iconColor: Colors.white,
                          iconData: Icons.privacy_tip_outlined,
                          onTap: () {
                            launchUrl(Uri.parse(
                                'https://miniguru.in/privacy-policy'));
                          }),
                      SizedBox(
                        height: size.width * 0.03,
                      ),
                      //About us
                      settingsWidget(
                          title: 'Logout',
                          iconBackColor: Colors.black,
                          iconColor: Colors.white,
                          iconData: FontAwesomeIcons.arrowRightFromBracket,
                          onTap: () async{
                            profileController.showActionSheet(context);
                          }),
                    ],
                  ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
