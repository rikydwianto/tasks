import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist/layout/custom_appbar.dart';
import '../controllers/about_controller.dart';

class AboutView extends GetView<AboutController> {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: "about".tr),
      backgroundColor: const Color(0xFFF9FAFB), // Light gray background
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          children: [
            _buildAppDescription(),
            const SizedBox(height: 32),
            _buildSectionTitle('App Info'),
            _buildInfoRow('App Name'.tr, controller.appName.value),
            _buildInfoRow('Package Name'.tr, controller.packageName.value),
            _buildInfoRow('Version'.tr, controller.version.value),
            _buildInfoRow('Build Number'.tr, controller.buildNumber.value),
            const SizedBox(height: 32),
            _buildSectionTitle('Device Info'),
            _buildInfoRow(
              'Device Name'.tr,
              controller.deviceName.value.isNotEmpty
                  ? controller.deviceName.value
                  : 'Not available',
            ),
            _buildInfoRow(
              'OS Version'.tr,
              controller.osVersion.value.isNotEmpty
                  ? controller.osVersion.value
                  : 'Not available',
            ),
          ],
        );
      }),
    );
  }

  Widget _buildAppDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          "Todo+ Alarm App",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 12),
        Text(
          "Aplikasi ini membantu kamu mencatat tugas harian, menyetel pengingat, dan memastikan semua aktivitas pentingmu tercatat dan terorganisir dengan baik.",
          style: TextStyle(
            fontSize: 15.5,
            color: Color(0xFF4B5563),
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Color(0xFF111827),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                color: Color(0xFF6B7280),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 3,
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 15,
                color: Color(0xFF111827),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
