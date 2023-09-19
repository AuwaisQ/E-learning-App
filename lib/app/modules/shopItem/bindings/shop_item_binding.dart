import 'package:get/get.dart';

import '../controllers/shop_item_controller.dart';

class ShopItemBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShopItemController>(
      () => ShopItemController(),
    );
  }
}
