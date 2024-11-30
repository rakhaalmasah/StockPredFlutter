import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DetailHomeController extends GetxController {
  var stockDetail = {}.obs;

  Future<void> fetchStockDetail(String code) async {
    final url = 'https://capstone-backendapi-final-500727111626.asia-southeast2.run.app/stocks/$code';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        stockDetail.value = jsonDecode(response.body);
      } else {
        Get.snackbar("Error", "Failed to load stock details");
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to load stock details: $e");
    }
  }
}
