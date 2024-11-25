import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import '../../../routes/app_pages.dart';
import '../../predict/controllers/predict_controller.dart';
import '../controllers/home_controller.dart';
import '../../predict/views/predict_view.dart';
import '../../../controllers/page_index_controller.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final PageIndexController pageIndexController = Get.put(PageIndexController());
  final PredictController predictController = Get.put(PredictController());

  final List<Widget> pages = [
    const HomePage(),
    const PredictView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: const Color(0xFF1A1E57),
          title: Image.asset(
            'assets/logo_text.png',
            height: 40,
          ),
        ),
        body: IndexedStack(
          index: pageIndexController.pageIndex.value,
          children: pages,
        ),
        bottomNavigationBar: CurvedNavigationBar(
          index: pageIndexController.pageIndex.value,
          backgroundColor: Colors.white,
          color: const Color(0xFF1A1E57),
          buttonBackgroundColor: const Color(0xFF1A1E57),
          height: 60,
          items: const <Widget>[
            Icon(Icons.home, size: 30, color: Colors.white),
            Icon(Icons.analytics, size: 30, color: Colors.white),
          ],
          onTap: (index) {
            pageIndexController.changePage(index);
          },
        ),
      );
    });
  }
}

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
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
          final stockLogo = stock['logo'] ?? '';
          final stockCode = stock['code'] ?? 'Unknown Code';
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
                            : const AssetImage('assets/pngwing.com.png')
                        as ImageProvider,
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
                onTap: () {
                  if (stockCode != 'Unknown Code') {
                    Get.toNamed(
                      Routes.DETAIL_HOME,
                      arguments: stockCode,
                    );
                  } else {
                    Get.snackbar(
                      "Error",
                      "Invalid stock code.",
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  }
                },
              ),
            ),
          );
        },
      );
    });
  }
}
