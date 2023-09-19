import 'package:get/get.dart';

import '../controllers/course_lessons_controller.dart';

class CourseLessonsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CourseLessonsController>(
      () => CourseLessonsController(),
    );
  }
}
