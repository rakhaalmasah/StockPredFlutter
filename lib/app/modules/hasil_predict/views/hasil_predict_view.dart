import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HasilPredictView extends StatelessWidget {
  const HasilPredictView({super.key});

  @override
  Widget build(BuildContext context) {
    final predictions = Get.arguments as Map<String, dynamic>;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: predictions.entries.map((entry) {
            return ListTile(
              title: Text(entry.key),
              subtitle: Text(entry.value.toString()),
            );
          }).toList(),
        ),
      ),
    );
  }
}
