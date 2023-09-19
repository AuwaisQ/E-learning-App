import 'package:get/get.dart';

import '../controllers/display_address_controller.dart';

class DisplayAddressBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DisplayAddressController>(
      () => DisplayAddressController(),
    );
  }
}
