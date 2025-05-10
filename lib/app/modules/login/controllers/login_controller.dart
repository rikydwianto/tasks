import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../services/firebase_service.dart';

class LoginController extends GetxController {
  final isLoading = false.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> login() async {
    try {
      isLoading.value = true;

      // 🔐 Google Sign-In
      final userCredential = await signInWithGoogle();
      final user = userCredential.user;

      if (user != null) {
        final cekUser = await FirebaseService.getData('users/${user.uid}');
        if (cekUser != null) {
        } else {
          await FirebaseService.addData('users/${user.uid}', {
            'name': user.displayName ?? 'No Name',
            'email': user.email ?? 'No Email',
            'bio': '',
            'profileImage': user.photoURL ?? '',
            'coverColor': 0xFF2196F3,
          });
        }
        // Simpan data ke pref isLoggedIn
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool('isLoggedIn', true);
        // FirebaseService.addData('users/${user.uid}', {
        // 📝 Simpan data ke Realtime Database

        Get.offAllNamed('/home'); // arahkan ke halaman home jika perlu
      }
    } catch (e) {
      Get.snackbar('Login Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser == null) throw Exception('Login dibatalkan pengguna');

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await _auth.signInWithCredential(credential);
  }

  Future<void> logout() async {
    try {
      await _auth.signOut(); // Sign out from Firebase
      await _googleSignIn.signOut(); // Sign out from Google
      Get.offAllNamed('/login'); // Navigate back to login screen
    } catch (e) {
      Get.snackbar('Logout Error', e.toString());
    }
  }
}
