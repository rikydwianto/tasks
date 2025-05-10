import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

import '../firebase_options.dart';

class FirebaseService {
  static late FirebaseDatabase _database;
  static bool _initialized = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  static String get currentUid {
    final user = FirebaseAuth.instance.currentUser;
    return user?.uid ?? 'anonymous';
  }

  /// Inisialisasi Firebase + login anonymous
  static Future<void> initialize() async {
    if (_initialized) return;

    // Inisialisasi Firebase jika belum
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Login anonymous (jika belum login)
    if (FirebaseAuth.instance.currentUser == null) {
      await FirebaseAuth.instance.signInAnonymously();
    }

    _database = FirebaseDatabase.instance;
    _initialized = true;
  }

  /// Menambahkan data ke path tertentu
  static Future<void> addData(String path, Map<String, dynamic> data) async {
    await initialize();
    final ref = _database.ref(path);
    await ref.set(data);
  }

  /// Mengambil data dari path tertentu
  static Future<Map<String, dynamic>?> getData(String path) async {
    await initialize();
    final ref = _database.ref(path);
    final snapshot = await ref.get();
    if (snapshot.exists) {
      final value = snapshot.value;
      if (value is Map) {
        return Map<String, dynamic>.from(value);
      }
    }
    return null;
  }

  static Future<void> removeData(String path) async {
    await initialize();
    final ref = _database.ref(path);
    await ref.remove();
  }

  /// Mengedit (update) sebagian data di path tertentu
  static Future<void> editData(String path, Map<String, dynamic> data) async {
    await initialize();
    final ref = _database.ref(path);
    await ref.update(data);
  }
}
