import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../routes/app_pages.dart';

class PredictController extends GetxController {
  final exchangeRateController = TextEditingController();
  final biRateController = TextEditingController();
  final inflationRateController = TextEditingController();

  void clearForm() {
    exchangeRateController.clear();
    biRateController.clear();
    inflationRateController.clear();
  }


  Future<void> submitPrediction() async {
    try {
      final exchangeRate = double.parse(exchangeRateController.text);
      final biRate = double.parse(biRateController.text);
      final inflationRate = double.parse(inflationRateController.text);

      final response = await http.post(
        Uri.parse(
          'https://capstone-backendapi-final-500727111626.asia-southeast2.run.app/predict',
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
        Get.toNamed(Routes.HASIL_PREDICT, arguments: result["prediction"]);
      } else {
        Get.snackbar(
          'Error',
          'Failed to fetch prediction: ${response.statusCode}',
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Invalid input or network error: $e',
        snackPosition: SnackPosition.TOP,
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
