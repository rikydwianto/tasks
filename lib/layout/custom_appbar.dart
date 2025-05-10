import 'package:flutter/material.dart';
import 'package:get/get.dart';

AppBar customAppBar({
  required String title,
  List<Widget>? actions, // Opsi untuk actions
  Widget? leading, // Opsi untuk leading
}) {
  return AppBar(
    title: Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 25,
      ),
    ),
    centerTitle: true,
    backgroundColor: Colors.blueAccent,
    actions: actions,
    leading: leading ??
        IconButton(
          // Default leading adalah tombol back
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // Tindakan default ketika back button ditekan
            Get.back();
          },
        ),
  );
}
