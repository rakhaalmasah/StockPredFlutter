import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controllers/detail_home_controller.dart';

class DetailHomeView extends GetView<DetailHomeController> {
  const DetailHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final stockCode = Get.arguments as String? ?? 'Unknown Stock';
    controller.fetchStockDetail(stockCode);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Color(0xFF1A1E57),
        title: Image.asset(
          'assets/logo_text.png',
          height: 40,
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Obx(() {
        if (controller.stockDetail.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final detail = controller.stockDetail;
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 200,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: (detail['logo'] != null && detail['logo']!.isNotEmpty)
                          ? NetworkImage(detail['logo']!)
                          : const AssetImage('assets/pngwing.com.png') as ImageProvider,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  detail['name'] ?? 'No Name',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  detail['sector'] ?? 'Unknown Sector',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ),
              const Divider(height: 32, thickness: 1),
              _buildDetailItem("Code ", detail['code'] ?? 'Unknown'),
              _buildDetailItem("Sector ", detail['sector'] ?? 'Unknown'),
              _buildDetailItem("Description ", detail['description'] ?? 'No description available'),
              _buildWebsiteButton("Website ", detail['website'] ?? 'No website'),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label: ",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWebsiteButton(String label, String url) {
    final completeUrl = url.startsWith('http') ? url : 'https://$url';
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Center(
        child: ElevatedButton(
          onPressed: () async {
            if (await canLaunch(completeUrl)) {
              await launch(completeUrl);
            } else {
              Get.snackbar('Error', 'Could not open the website');
            }
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            backgroundColor: Color(0xFF1A1E57),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            "Visit Company Website",
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
