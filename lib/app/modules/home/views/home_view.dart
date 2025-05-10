import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../layout/main_layout.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime? _lastPressed;

    return WillPopScope(
      onWillPop: () async {
        // Handle back button press
        final now = DateTime.now();
        if (_lastPressed == null ||
            now.difference(_lastPressed!) > Duration(seconds: 2)) {
          _lastPressed = now;
          Get.snackbar(
            'Konfirmasi',
            'Tekan sekali lagi untuk keluar',
            snackPosition: SnackPosition.BOTTOM,
            duration: Duration(seconds: 2),
          );
          return false;
        }
        return true;
      },
      child: MainLayout(
        title: "Dashboard".tr, // Ganti ini
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildWelcomeCard(),
              const SizedBox(height: 16),
              _buildQuickStats(),
              const SizedBox(height: 16),
              _buildMenuGrid(),
              const SizedBox(height: 24),
              _buildQuoteCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF42A5F5), Color(0xFF1E88E5)],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "welcome_back".tr, // Ganti ini
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            "productive_day".tr, // Ganti ini
            style: TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStats() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            // controller.increment();
            Get.toNamed('/tasks');
          },
          child: _buildStatCard(
              "tasks".tr, "12", Icons.check_circle, Colors.green), // Ganti ini
        ),
        InkWell(
          onTap: () => Get.toNamed('/notifications'),
          child: _buildStatCard("notifications".tr, "3", Icons.notifications,
              Colors.orange), // Ganti ini
        ),
        _buildStatCard(
            "events".tr, "2", Icons.event, Colors.purple), // Ganti ini
      ],
    );
  }

  Widget _buildStatCard(
      String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Icon(icon, size: 30, color: color),
              const SizedBox(height: 8),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                title,
                style: const TextStyle(color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuGrid() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      children: [
        _buildMenuTile(
            Icons.people,
            "profile".tr,
            Colors.teal, // Ganti ini
            () => Get.toNamed('/profile')),
        _buildMenuTile(
            Icons.schedule, "schedule".tr, Colors.blue, () {}), // Ganti ini
        _buildMenuTile(
            Icons.settings,
            "settings".tr,
            Colors.grey, // Ganti ini
            () => Get.toNamed('/settings')),
        _buildMenuTile(Icons.info, "about".tr, Colors.deepOrange, () {
          Get.toNamed('/about');
        }), // Ganti ini
      ],
    );
  }

  Widget _buildMenuTile(
      IconData icon, String title, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: color),
            const SizedBox(height: 12),
            Text(title,
                style: TextStyle(color: color, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  Widget _buildQuoteCard() {
    return Card(
      color: Colors.amber.shade100,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            const Icon(Icons.format_quote, size: 30, color: Colors.amber),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                "quote".tr, // Ganti ini
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
