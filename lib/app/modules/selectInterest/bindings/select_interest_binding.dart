import 'package:get/get.dart';

import '../controllers/select_interest_controller.dart';

class SelectInterestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SelectInterestController>(
      () => SelectInterestController(),
    );
  }
}
