import 'package:get/get.dart';
import '../modules/detail_home/bindings/detail_home_binding.dart';
import '../modules/detail_home/views/detail_home_view.dart';
import '../modules/hasil_predict/bindings/hasil_predict_binding.dart';
import '../modules/hasil_predict/views/hasil_predict_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/predict/bindings/predict_binding.dart';
import '../modules/predict/views/predict_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () =>  HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_HOME,
      page: () => const DetailHomeView(),
      binding: DetailHomeBinding(),
    ),
    GetPage(
      name: _Paths.PREDICT,
      page: () => const PredictView(),
      binding: PredictBinding(),
    ),
    GetPage(
      name: _Paths.HASIL_PREDICT,
      page: () => const HasilPredictView(),
      binding: HasilPredictBinding(),
    ),
  ];
}
