import 'package:get/get.dart';

import '../controllers/detail_home_controller.dart';

class DetailHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailHomeController>(
      () => DetailHomeController(),
    );
  }
}
