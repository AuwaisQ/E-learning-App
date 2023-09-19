import 'package:get/get.dart';

import '../controllers/prefrences_controller.dart';

class PrefrencesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PrefrencesController>(
      () => PrefrencesController(),
    );
  }
}
