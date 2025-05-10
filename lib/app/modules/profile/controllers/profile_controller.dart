import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../services/firebase_service.dart';

class ProfileController extends GetxController {
  var userName = ''.obs;
  var email = ''.obs;
  var bio = ''.obs;
  var profileImage = ''.obs;
  var coverColor = Colors.blueAccent.obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    loadUserInfo();
  }

  void loadUserInfo() async {
    final user = _auth.currentUser;
    if (user != null) {
      // Mengambil data pengguna dari Firebase
      Map<String, dynamic>? userData =
          await FirebaseService.getData('users/${user.uid}');

      if (userData != null) {
        // Update state dengan data yang diambil
        userName.value = userData['name'] ?? 'No Name';
        email.value = userData['email'] ?? 'No Email';
        bio.value = userData['bio'] ?? 'No Bio';
        profileImage.value = userData['profileImage'] ?? '';

        // Perbarui coverColor dengan nilai yang diambil dari Firebase
        // coverColor.value = Color(userData['coverColor'] ?? 0xFF000000); // Tipe Color

        print('✅ Profile data loaded from Firebase');
      } else {
        print('❌ No user data found in Firebase');
      }
    } else {
      print('❌ No user is logged in');
    }
  }

  void saveUserInfo() async {
    final user = _auth.currentUser;
    if (user != null) {
      // Persiapkan data untuk disimpan
      Map<String, dynamic> userData = {
        'bio': bio.value,
      };

      // Simpan ke database
      await FirebaseService.editData('users/${user.uid}', userData);
    } else {}
  }
}
