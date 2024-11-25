import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class PredictController extends GetxController {
  final exchangeRateController = TextEditingController();
  final biRateController = TextEditingController();
  final inflationRateController = TextEditingController();

  Future<void> submitPrediction() async {
    try {
      final exchangeRate = double.parse(exchangeRateController.text);
      final biRate = double.parse(biRateController.text);
      final inflationRate = double.parse(inflationRateController.text);

      final response = await http.post(
        Uri.parse(
          'https://capstone-project-api-2-873925841072.asia-southeast2.run.app/predict',
        ),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "exchange_rate": exchangeRate,
          "bi_rate": biRate,
          "inflation_rate": inflationRate,
        }),
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        Get.toNamed('/hasil-prediksi', arguments: result["prediction"]);
      } else {
        Get.snackbar(
          'Error',
          'Failed to fetch prediction: ${response.statusCode}',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Invalid input or network error: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  void onClose() {
    exchangeRateController.dispose();
    biRateController.dispose();
    inflationRateController.dispose();
    super.onClose();
  }
}
