import 'package:get/get.dart';

import '../controllers/hasil_predict_controller.dart';

class HasilPredictBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HasilPredictController>(
      () => HasilPredictController(),
    );
  }
}
