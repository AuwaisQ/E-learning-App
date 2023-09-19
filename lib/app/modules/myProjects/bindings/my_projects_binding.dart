import 'package:get/get.dart';

import '../controllers/my_projects_controller.dart';

class MyProjectsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyProjectsController>(
      () => MyProjectsController(),
    );
  }
}
