import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import '../../../../services/firebase_service.dart';

class AddNoteController extends GetxController {
  Rxn<XFile> selectedImage = Rxn<XFile>();
  Rxn<Uint8List> drawnImage = Rxn<Uint8List>();

  Future<void> pickImage() async {
    // ... tetap
  }

  void setDrawnImage(Uint8List bytes) {
    drawnImage.value = bytes;
  }

  Future<void> saveNote(String title, String description) async {
    try {
      final noteId = const Uuid().v4(); // generate id unik

      await FirebaseService.addData(
          'users/${FirebaseService.currentUid}/notes/$noteId', {
        'title': title,
        'description': description,
        'createdAt': DateTime.now().toIso8601String(),
        'modifyAt': DateTime.now().toIso8601String(),
      });

      Get.back();
      Get.snackbar(
        'Success',
        'Note saved successfully',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.green,
      );
    } catch (e) {
      print('Error saving note: $e');
      Get.snackbar('Error', 'Failed to save note: $e');
    }
  }

  Future<void> deleteNote(String noteId) async {
    try {
      await FirebaseService.removeData(
          'users/${FirebaseService.currentUid}/notes/$noteId');

      Get.snackbar('Success', 'Note deleted successfully',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.red,
          colorText: Colors.white);
    } catch (e) {
      print('Error deleting note: $e');
      Get.snackbar('Error', 'Failed to delete note: $e');
    }
  }

  Future<void> updateNote(
      String noteId, String title, String description) async {
    try {
      await FirebaseService.editData(
        'users/${FirebaseService.currentUid}/notes/$noteId',
        {
          'title': title,
          'description': description,
          'modifyAt': DateTime.now().toIso8601String(),
        },
      );

      Get.back();
      Get.snackbar('Success', 'Note updated successfully',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.green,
          colorText: Colors.white);
    } catch (e) {
      print('Error updating note: $e');
      Get.snackbar('Error', 'Failed to update note: $e');
    }
  }
}
