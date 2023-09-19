import 'package:get/get.dart';

import '../controllers/update_project_controller.dart';

class UpdateProjectBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdateProjectController>(
      () => UpdateProjectController(),
    );
  }
}
