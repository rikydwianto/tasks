import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist/app/modules/addtask/controllers/addtask_controller.dart';
import '../../../../services/firebase_service.dart';

class TasksController extends GetxController {
  var tasks = <Map<String, dynamic>>[].obs;
  AddTaskController addTaskController = Get.put(AddTaskController());
  var isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
    fetchTasks();
  }

  Future<void> deleteTask(String taskId) async {
    try {
      await FirebaseService.removeData(
          'users/${FirebaseService.currentUid}/tasks/$taskId');

      // Hapus dari list lokal
      tasks.removeWhere((task) => task['id'] == taskId);

      Get.snackbar(
        'Berhasil',
        'Tugas berhasil dihapus',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      print('Gagal hapus tugas: $e');
      Get.snackbar(
        'Gagal',
        'Tidak bisa menghapus tugas: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> fetchTasks() async {
    isLoading.value = true;
    try {
      final data = await FirebaseService.getData(
        'users/${FirebaseService.currentUid}/tasks',
      );

      if (data != null) {
        tasks.value = data.entries.map((e) {
          final taskData = Map<String, dynamic>.from(e.value);

          final subtasksData = taskData['subtasks'];
          List<Map<String, dynamic>> subtasksList = [];

          if (subtasksData != null && subtasksData is Map) {
            subtasksList =
                subtasksData.entries.map<Map<String, dynamic>>((entry) {
              return {
                'id': entry.key,
                ...Map<String, dynamic>.from(entry.value),
              };
            }).toList();
          }

          return {
            'id': e.key,
            'title': taskData['taskTitle'] ?? 'No title',
            'description': taskData['taskDescription'] ?? '',
            'subtasks': subtasksList,
          };
        }).toList();
      } else {
        tasks.clear();
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch tasks: $e');
    }
    isLoading.value = false;
  }
}
