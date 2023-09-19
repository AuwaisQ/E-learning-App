import 'package:get/get.dart';

import '../controllers/app_profile_controller.dart';

class AppProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AppProfileController>(
      () => AppProfileController(),
    );
  }
}
