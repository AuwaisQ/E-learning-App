import 'package:get/get.dart';

import '../controllers/select_materials_controller.dart';

class SelectMaterialsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SelectMaterialsController>(
      () => SelectMaterialsController(),
    );
  }
}
