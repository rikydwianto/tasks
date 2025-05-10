import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/routes/app_pages.dart';
import 'firebase_options.dart';
import 'lang/translations.dart';

void debugFirebaseConnection() async {
  try {
    // 1. Cek user login
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      await FirebaseAuth.instance.signInAnonymously();
      print('✅ Signed in anonymously');
    } else {
      print('✅ Already signed in: ${user.uid}');
    }

    // 2. Cek akses ke database
    final db = FirebaseDatabase.instance;
    final snapshot = await db.ref('/debug-test').get();
    if (snapshot.exists) {
      // print('✅ Firebase Database connected. Data: ${snapshot.value}');
    } else {
      // print(
      //     '⚠️ Firebase Database connected, tapi tidak ada data di /debug-test');
    }
  } catch (e) {
    print('❌ Gagal terhubung ke Firebase: $e');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Menunggu sampai Flutter siap
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  debugFirebaseConnection(); // Debug koneksi Firebase
  //  Firebase

  final prefs = await SharedPreferences.getInstance();
  final bool isDarkMode =
      prefs.getBool('darkMode') ?? false; // Memuat preferensi tema
  final bool isLoggedIn =
      prefs.getBool('isLoggedIn') ?? false; // Cek apakah sudah login
  final String? savedLangCode = prefs.getString('languageCode');
  final String? savedCountryCode = prefs.getString('countryCode');

  final Locale savedLocale = (savedLangCode != null && savedCountryCode != null)
      ? Locale(savedLangCode, savedCountryCode)
      : const Locale('id', 'ID');

  await initializeDateFormatting(savedLangCode, null);

  runApp(MyApp(isDarkMode, isLoggedIn,
      savedLocale)); // Menginisialisasi aplikasi dengan tema yang sudah disimpan
}

class MyApp extends StatelessWidget {
  final bool isDarkMode;
  final bool isLoggedIn;
  final Locale savedLocale;

  const MyApp(this.isDarkMode, this.isLoggedIn, this.savedLocale, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Todo App',
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 300),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      translations: AppTranslations(), // Tambahkan ini
      locale: savedLocale, // Pakai locale dari shared prefs
      fallbackLocale: const Locale('en', 'US'),
      initialRoute: isLoggedIn ? AppPages.HOME : AppPages.LOGIN,
      getPages: AppPages.routes,
    );
  }
}

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.blue,
  visualDensity: VisualDensity.adaptivePlatformDensity,
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.blue,
  visualDensity: VisualDensity.adaptivePlatformDensity,
);
