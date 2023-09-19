import 'package:get/get.dart';

import '../controllers/address_controller.dart';

class AddAddressBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddressController>(
      () => AddressController(),
    );
  }
}
