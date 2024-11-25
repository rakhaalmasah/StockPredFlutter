import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HasilPredictController extends GetxController {
  var stocks = [].obs;
  var stockDetails = {}.obs;
  var predictions = {}.obs;

  @override
  void onInit() {
    fetchStocks();
    final receivedPredictions = Get.arguments as Map<String, dynamic>;
    predictions.addAll(receivedPredictions);
    super.onInit();
  }

  Future<void> fetchStocks() async {
    const url = 'https://project-capstone-api-873925841072.asia-southeast2.run.app/stocks';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        stocks.value = jsonDecode(response.body);
        for (var stock in stocks) {
          final code = stock['code'];
          if (code != null) {
            await fetchStockDetail(code);
          }
        }
      } else {
        Get.snackbar("Error", "Failed to load stocks");
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to load stocks: $e");
    }
  }

  Future<void> fetchStockDetail(String code) async {
    final url = 'https://project-capstone-api-873925841072.asia-southeast2.run.app/stocks/$code';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        stockDetails[code] = data;
      } else {
        Get.snackbar("Error", "Failed to load stock details for $code");
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to load stock details: $e");
    }
  }
}
