import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist/services/firebase_service.dart'; // pastikan path ini sesuai dengan struktur proyekmu

class AddTaskController extends GetxController {
  final taskTitleController = TextEditingController();
  final taskDescriptionController = TextEditingController();

  Future<void> saveTask() async {
    final title = taskTitleController.text.trim();
    final desc = taskDescriptionController.text.trim();

    if (title.isEmpty || desc.isEmpty) {
      Get.snackbar(
        'Error',
        'Title and Description cannot be empty',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      final taskId = DateTime.now().millisecondsSinceEpoch.toString();
      final now = DateTime.now();

      final taskData = {
        'taskTitle': title,
        'taskDescription': desc,
        'createdAt': now.toIso8601String(),
        'editedAt': now.toIso8601String(),
      };

      await FirebaseService.addData(
        'users/${FirebaseService.currentUid}/tasks/$taskId',
        taskData,
      );

      Get.back(result: true);
      Future.delayed(const Duration(milliseconds: 300), () {
        Get.snackbar(
          'Success',
          'Task saved successfully',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      });
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to save task',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
