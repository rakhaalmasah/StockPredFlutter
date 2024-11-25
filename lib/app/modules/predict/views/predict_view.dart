import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/predict_controller.dart';

class PredictView extends GetView<PredictController> {
  const PredictView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 30),
            TextField(
              controller: controller.exchangeRateController,
              decoration: const InputDecoration(
                labelText: 'Exchange Rate (USD/IDR)',
                labelStyle: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: controller.biRateController,
              decoration: const InputDecoration(
                labelText: 'BI Rate (%)',
                labelStyle: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: controller.inflationRateController,
              decoration: const InputDecoration(
                labelText: 'Inflation Rate (%)',
                labelStyle: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: controller.submitPrediction,
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
