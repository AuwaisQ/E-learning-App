import 'package:get/get.dart';

class MyCoursesController extends GetxController {
  //TODO: Implement MyCoursesController
  var isAgeSwitcher = false.obs;
  var isTopicSwitcher = false.obs;
  var isCitySwitcher = false.obs;
  var isCommentsSwitcher = false.obs;
  final count = 0.obs;



  void increment() => count.value++;
}
