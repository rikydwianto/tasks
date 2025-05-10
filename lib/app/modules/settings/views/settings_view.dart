import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../layout/main_layout.dart';
import '../controllers/settings_controller.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  late bool isDarkMode;

  @override
  void initState() {
    super.initState();
    isDarkMode = Get.isDarkMode;
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'settings'.tr,
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ListTile(
            leading: const Icon(Icons.brightness_6),
            title: Text('change_theme'.tr),
            trailing: Switch(
              value: isDarkMode,
              onChanged: (value) {
                setState(() {
                  isDarkMode = value;
                });
                Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
              },
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.language),
            title: Text('change_language'.tr),
            onTap: _showLanguageDialog,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: Text('notification_settings'.tr),
            onTap: () {
              // Tambahkan logika pengaturan notifikasi jika diperlukan
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: Text('account_settings'.tr),
            onTap: () {
              // Tambahkan logika pengaturan akun
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: Text('about'.tr),
            onTap: () {
              // Tampilkan halaman tentang
              Get.toNamed('/about');
            },
          ),
        ],
      ),
    );
  }

  void _showLanguageDialog() async {
    final prefs = await SharedPreferences.getInstance();

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Get.theme.scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('select_language'.tr,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            ListTile(
              leading: Image.asset('assets/icons/indonesia.png', width: 30),
              title: const Text('Bahasa Indonesia'),
              onTap: () async {
                await prefs.setString('languageCode', 'id');
                await prefs.setString('countryCode', 'ID');
                Get.updateLocale(const Locale('id', 'ID'));
                Get.back();
              },
            ),
            ListTile(
              leading: Image.asset('assets/icons/us.png', width: 30),
              title: const Text('English'),
              onTap: () async {
                await prefs.setString('languageCode', 'en');
                await prefs.setString('countryCode', 'US');
                Get.updateLocale(const Locale('en', 'US'));
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }
}
