import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/hasil_predict_controller.dart';

class HasilPredictView extends GetView<HasilPredictController> {
  const HasilPredictView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color(0xFF1A1E57),
        title: Image.asset(
          'assets/logo_text.png',
          height: 40,
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Obx(() {
        if (controller.stocks.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          itemCount: controller.stocks.length,
          itemBuilder: (context, index) {
            final stock = controller.stocks[index];
            final stockCode = stock['code'] ?? 'Unknown Code';
            final stockLogo = stock['logo'] ?? '';
            final rawPrediction = controller.predictions[stockCode];
            final parsedPrediction = rawPrediction != null ? num.tryParse(rawPrediction.toString()) : null;
            final stockPrediction = (parsedPrediction != null && parsedPrediction >= 0)
                ? parsedPrediction.toString()
                : "Can’t Predict";

            return Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: Card(
                color: Colors.white,
                elevation: 2,
                child: ListTile(
                  leading: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: stockLogo.isNotEmpty
                              ? NetworkImage(stockLogo)
                              : const AssetImage('assets/pngwing.com.png') as ImageProvider,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        stockCode,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        controller.stockDetails[stockCode]?['name'] ?? 'Loading...',
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      "Prediction: $stockPrediction",
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
