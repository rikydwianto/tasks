import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app/modules/login/controllers/login_controller.dart';
import '../app/modules/profile/controllers/profile_controller.dart';

class MainLayout extends StatefulWidget {
  final Widget child;
  final String title;

  const MainLayout({required this.child, this.title = "App", Key? key})
      : super(key: key);

  @override
  _MainLayoutState createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  late bool _isDarkMode;
  late ProfileController profileController; // Menambahkan controller profil

  @override
  void initState() {
    super.initState();
    _loadTheme();
    profileController = Get.put(ProfileController()); // Inisialisasi controller
  }

  // Memuat status tema dari SharedPreferences
  void _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode =
          prefs.getBool('darkMode') ?? false; // Default false jika belum ada
    });
  }

  // Menyimpan status tema ke SharedPreferences
  void _saveTheme(bool isDarkMode) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('darkMode', isDarkMode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title.tr,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
        ), // Ganti ini
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.black87,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications_none_outlined,
              color: Colors.white,
            ),
            onPressed: () {
              Get.toNamed('/notifications');
            },
          ),
          IconButton(
            icon: const Icon(Icons.person, color: Colors.white),
            onPressed: () {
              Get.toNamed('/profile');
            },
          ),
        ],
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.notes, color: Colors.white),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 32),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF00B0FF), Color(0xFF80D0FF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: 30),
                  Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [Colors.white, Colors.blueAccent],
                      ),
                    ),
                    child: Obx(() => CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.white,
                          backgroundImage:
                              profileController.profileImage.value.isNotEmpty
                                  ? NetworkImage(
                                      profileController.profileImage.value)
                                  : null,
                          child: profileController.profileImage.value.isEmpty
                              ? Text(
                                  _getInitials(
                                      profileController.userName.value),
                                  style: const TextStyle(
                                      fontSize: 24, color: Colors.blue),
                                )
                              : null,
                        )),
                  ),
                  const SizedBox(height: 12),
                  Obx(() => Text(
                        profileController
                            .userName.value, // Mengambil nama pengguna
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )),
                  Obx(() => Text(
                        profileController.email.value,
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      )),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: [
                  // Menu Utama (Penting)
                  _buildMenuItem(Icons.home, 'home'.tr,
                      () => Get.offNamed('/home')), // Ganti ini
                  _buildMenuItem(Icons.add_task, 'my_tasks'.tr,
                      () => Get.toNamed('/tasks')), // Ganti ini
                  _buildMenuItem(Icons.alarm, 'alarm'.tr,
                      () => Get.toNamed('/alarm')), // Ganti ini
                  _buildMenuItem(Icons.notes, 'notes'.tr,
                      () => Get.toNamed('/notes')), // Ganti ini
                  const Divider(thickness: 1, height: 16),

                  // Menu Pengaturan
                  _buildMenuItem(Icons.settings, 'settings'.tr,
                      () => Get.offNamed('/settings')), // Ganti ini

                  // Switch Dark Mode
                  _buildDarkModeSwitch(),
                  _buildMenuItem(Icons.language, 'change_language'.tr, () {
                    // Ganti ini
                    _showLanguageDialog(context);
                  }),

                  const Divider(thickness: 1, height: 16),
                  _buildLogoutItem(), // ⬅️ Tambahkan ini
                ],
              ),
            ),
          ],
        ),
      ),
      body: widget.child,
    );
  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.blue.withOpacity(0.2),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(8),
              child: Icon(icon, color: Colors.blue, size: 24),
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutItem() {
    return InkWell(
      onTap: _confirmLogout,
      splashColor: Colors.red.withOpacity(0.2),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(8),
              child: const Icon(Icons.logout, color: Colors.red),
            ),
            const SizedBox(width: 16),
            Text(
              'logout'.tr, // Ganti ini
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.red,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDarkModeSwitch() {
    return InkWell(
      onTap: () {
        setState(() {
          _isDarkMode = !_isDarkMode;
          _saveTheme(_isDarkMode);
          Get.changeThemeMode(_isDarkMode ? ThemeMode.dark : ThemeMode.light);
        });
      },
      splashColor: Colors.blue.withOpacity(0.2),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(8),
              child: Icon(
                _isDarkMode ? Icons.dark_mode : Icons.light_mode,
                color: Colors.blue,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                _isDarkMode ? 'dark_mode'.tr : 'light_mode'.tr,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Switch(
              value: _isDarkMode,
              onChanged: (value) {
                setState(() {
                  _isDarkMode = value;
                  _saveTheme(value);
                  Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
                });
              },
              activeColor: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Get.theme.scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: Wrap(
          children: [
            ListTile(
              leading: Image.asset('assets/icons/indonesia.png',
                  width: 30), // Ganti dengan path gambar bendera Indonesia
              title: const Text('Bahasa Indonesia'),
              onTap: () async {
                await prefs.setString('languageCode', 'id');
                await prefs.setString('countryCode', 'ID');
                Get.updateLocale(const Locale('id', 'ID'));
                Get.back();
              },
            ),
            ListTile(
              leading: Image.asset('assets/icons/us.png',
                  width: 30), // Ganti dengan path gambar bendera Inggris
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

  void _confirmLogout() {
    final LoginController controller = Get.put(LoginController());
    Get.defaultDialog(
      title: 'logout_title'.tr, // Ganti ini
      middleText: 'logout_confirm'.tr, // Ganti ini
      textCancel: 'cancel'.tr, // Ganti ini
      textConfirm: 'logout'.tr, // Ganti ini
      confirmTextColor: Colors.white,
      buttonColor: Colors.redAccent,
      onConfirm: () async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('isLoggedIn'); // hapus status login
        controller.logout(); // panggil fungsi logout dari controller
        Get.offAllNamed('/login'); // kembali ke halaman login
      },
    );
  }

  String _getInitials(String name) {
    // Jika nama tidak kosong, ambil huruf pertama dari setiap kata
    List<String> nameParts = name.split(" ");
    String initials = "";
    for (var part in nameParts) {
      if (part.isNotEmpty) {
        initials += part[0].toUpperCase();
      }
    }
    return initials.isNotEmpty
        ? initials
        : 'N/A'; // Jika tidak ada inisial, kembalikan 'N/A'
  }
}
