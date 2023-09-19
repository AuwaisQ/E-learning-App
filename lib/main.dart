import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mini_guru/app/modules/appProfile/views/app_profile_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/apiServices/notificationService.dart';
import 'app/modules/bottomBar/views/bottom_bar_view.dart';
import 'app/modules/onBoarding/views/on_boarding_view.dart';
import 'app/routes/app_pages.dart';
import 'package:firebase_core/firebase_core.dart';

bool? isLogin;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  await Firebase.initializeApp();
  final prefs = await SharedPreferences.getInstance();
  isLogin = prefs.getBool('isLogin');
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins'),
      title: "MiniGuru",
      // home: AppProfileView(),
      home: isLogin == true ? BottomBarView() : const OnBoardingView(),
      getPages: AppPages.routes,
    );
  }
}