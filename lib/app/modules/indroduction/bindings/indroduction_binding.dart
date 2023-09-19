import 'package:get/get.dart';

import '../controllers/indroduction_controller.dart';

class IndroductionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IndroductionController>(
      () => IndroductionController(),
    );
  }
}
